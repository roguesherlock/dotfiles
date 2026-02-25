#!/usr/bin/env python3
"""Convert a multipage web guide into a single EPUB file.

Example:
  uv run scripts/web_to_epub.py \
    --start-url https://www.julian.com/guide/write/intro \
    --output writing-better.epub \
    --title "Writing Better"
"""

from __future__ import annotations

import argparse
import html
import re
import sys
import uuid
import zipfile
from dataclasses import dataclass
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import urljoin, urlparse
from urllib.request import Request, urlopen


UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
    "AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/131.0.0.0 Safari/537.36"
)

VOID_TAGS = {
    "area",
    "base",
    "br",
    "col",
    "embed",
    "hr",
    "img",
    "input",
    "link",
    "meta",
    "param",
    "source",
    "track",
    "wbr",
}


def fetch(url: str, timeout: int = 20) -> str:
    req = Request(url, headers={"User-Agent": UA})
    with urlopen(req, timeout=timeout) as resp:
        charset = resp.headers.get_content_charset() or "utf-8"
        return resp.read().decode(charset, errors="replace")


def clean_text(value: str) -> str:
    return re.sub(r"\s+", " ", html.unescape(value)).strip()


def slugify(value: str) -> str:
    value = re.sub(r"[^a-zA-Z0-9]+", "-", value.strip().lower())
    return re.sub(r"-{2,}", "-", value).strip("-") or "chapter"


def title_from_url(url: str, fallback: str) -> str:
    parsed = urlparse(url)
    parts = [p for p in parsed.path.split("/") if p]
    if not parts:
        return fallback
    last = clean_text(parts[-1].replace("-", " "))
    if len(parts) >= 2 and parts[-2] == "article":
        combined = clean_text(" ".join(parts[-3:]).replace("-", " "))
        return combined.title()
    return last.title() if last else fallback


def attr_string(attrs: list[tuple[str, str | None]]) -> str:
    out = []
    for key, raw_val in attrs:
        if raw_val is None:
            out.append(f' {key}="{key}"')
            continue
        escaped = html.escape(raw_val, quote=True)
        out.append(f' {key}="{escaped}"')
    return "".join(out)


class RichTextExtractor(HTMLParser):
    """Extract inner HTML of first <div class="text w-richtext"> block."""

    def __init__(self) -> None:
        super().__init__(convert_charrefs=False)
        self._capturing = False
        self._done = False
        self._div_depth = 0
        self._chunks: list[str] = []

    @property
    def content(self) -> str:
        return "".join(self._chunks).strip()

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        if self._done:
            return
        if not self._capturing and tag == "div":
            class_attr = next((v for (k, v) in attrs if k == "class"), "") or ""
            classes = set(class_attr.split())
            if {"text", "w-richtext"}.issubset(classes):
                self._capturing = True
                self._div_depth = 1
                return
        if not self._capturing:
            return
        if tag == "div":
            self._div_depth += 1
        attrs_txt = attr_string(attrs)
        if tag in VOID_TAGS:
            self._chunks.append(f"<{tag}{attrs_txt} />")
        else:
            self._chunks.append(f"<{tag}{attrs_txt}>")

    def handle_endtag(self, tag: str) -> None:
        if self._done or not self._capturing:
            return
        if tag == "div":
            self._div_depth -= 1
            if self._div_depth == 0:
                self._capturing = False
                self._done = True
                return
        if tag not in VOID_TAGS:
            self._chunks.append(f"</{tag}>")

    def handle_data(self, data: str) -> None:
        if self._capturing and not self._done:
            self._chunks.append(data)

    def handle_entityref(self, name: str) -> None:
        if self._capturing and not self._done:
            self._chunks.append(f"&{name};")

    def handle_charref(self, name: str) -> None:
        if self._capturing and not self._done:
            self._chunks.append(f"&#{name};")

    def handle_comment(self, data: str) -> None:
        if self._capturing and not self._done:
            self._chunks.append(f"<!--{data}-->")

    def handle_startendtag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        if self._done or not self._capturing:
            return
        attrs_txt = attr_string(attrs)
        self._chunks.append(f"<{tag}{attrs_txt} />")


def extract_content(html_text: str) -> str:
    parser = RichTextExtractor()
    parser.feed(html_text)
    parser.close()
    return parser.content


def extract_guide_links(html_text: str, start_url: str) -> list[str]:
    parsed_start = urlparse(start_url)
    # /guide/write/intro -> /guide/write/
    segments = [s for s in parsed_start.path.split("/") if s]
    prefix_path = "/" + "/".join(segments[:-1]) + "/"

    hrefs = re.findall(r'<a[^>]+href="([^"]+)"[^>]*class="[^"]*toc-menu-link[^"]*"', html_text)
    urls: list[str] = []
    seen: set[str] = set()
    for href in hrefs:
        full = urljoin(start_url, href.split("#")[0])
        parsed = urlparse(full)
        if (
            parsed.netloc == parsed_start.netloc
            and parsed.path.startswith(prefix_path)
            and parsed.path not in seen
        ):
            seen.add(parsed.path)
            urls.append(full)
    if not urls:
        return [start_url]
    return urls


def extract_title(html_text: str, fallback: str) -> str:
    m = re.search(r'<h1[^>]*class="[^"]*page-heading[^"]*"[^>]*>(.*?)</h1>', html_text, re.S | re.I)
    if m:
        title_raw = re.sub(r"<[^>]+>", "", m.group(1))
        title = clean_text(title_raw)
        if title:
            return title
    mt = re.search(r"<title>(.*?)</title>", html_text, re.S | re.I)
    if mt:
        title = clean_text(mt.group(1))
        if title:
            return title
    return fallback


def is_x_or_twitter_url(url: str) -> bool:
    host = (urlparse(url).netloc or "").lower()
    return host in {"x.com", "www.x.com", "twitter.com", "www.twitter.com"}


def is_medium_url(url: str) -> bool:
    host = (urlparse(url).netloc or "").lower()
    return host == "medium.com" or host.endswith(".medium.com")


def medium_scribe_url(url: str) -> str:
    return f"https://scribe.rip/{url}"


def jina_reader_url(url: str) -> str:
    parsed = urlparse(url)
    target = parsed.netloc + parsed.path
    if parsed.query:
        target += "?" + parsed.query
    return f"https://r.jina.ai/http://{target}"


def extract_jina_markdown_payload(raw_text: str) -> tuple[str, str]:
    title = "Untitled"
    m = re.search(r"^Title:\s*(.+)$", raw_text, flags=re.M)
    if m:
        title = clean_text(m.group(1))
    marker = "Markdown Content:"
    if marker in raw_text:
        content = raw_text.split(marker, 1)[1].strip()
    else:
        content = raw_text.strip()
    if title.lower() in {"x", "twitter"}:
        title = "Untitled"
    return title, content


def markdown_inline_to_html(text: str) -> str:
    placeholders: list[tuple[str, str]] = []

    def add_placeholder(value: str) -> str:
        token = f"@@PH{len(placeholders)}@@"
        placeholders.append((token, value))
        return token

    def repl_image(match: re.Match[str]) -> str:
        alt = html.escape(match.group(1).strip(), quote=True)
        src = html.escape(match.group(2).strip(), quote=True)
        return add_placeholder(f'<img src="{src}" alt="{alt}" />')

    def repl_link(match: re.Match[str]) -> str:
        label = html.escape(match.group(1).strip())
        href = html.escape(match.group(2).strip(), quote=True)
        return add_placeholder(f'<a href="{href}">{label}</a>')

    text = re.sub(r"!\[([^\]]*)\]\(([^)\s]+)\)", repl_image, text)
    text = re.sub(r"\[([^\]]+)\]\(([^)\s]+)\)", repl_link, text)
    escaped = html.escape(text)

    for token, value in placeholders:
        escaped = escaped.replace(token, value)
    return escaped


def markdown_to_html(markdown: str) -> str:
    out: list[str] = []
    paragraph_parts: list[str] = []
    in_ul = False
    in_ol = False
    in_blockquote = False

    def flush_paragraph() -> None:
        nonlocal paragraph_parts
        if paragraph_parts:
            joined = " ".join(paragraph_parts).strip()
            if joined:
                out.append(f"<p>{markdown_inline_to_html(joined)}</p>")
            paragraph_parts = []

    def close_lists() -> None:
        nonlocal in_ul, in_ol
        if in_ul:
            out.append("</ul>")
            in_ul = False
        if in_ol:
            out.append("</ol>")
            in_ol = False

    def close_blockquote() -> None:
        nonlocal in_blockquote
        if in_blockquote:
            out.append("</blockquote>")
            in_blockquote = False

    for raw_line in markdown.splitlines():
        line = raw_line.strip()
        if not line:
            flush_paragraph()
            close_lists()
            close_blockquote()
            continue

        heading = re.match(r"^(#{1,6})\s+(.*)$", line)
        if heading:
            flush_paragraph()
            close_lists()
            close_blockquote()
            level = len(heading.group(1))
            out.append(f"<h{level}>{markdown_inline_to_html(heading.group(2))}</h{level}>")
            continue

        bq = re.match(r"^>\s?(.*)$", line)
        if bq:
            flush_paragraph()
            close_lists()
            if not in_blockquote:
                out.append("<blockquote>")
                in_blockquote = True
            out.append(f"<p>{markdown_inline_to_html(bq.group(1))}</p>")
            continue
        close_blockquote()

        ul = re.match(r"^[-*]\s+(.*)$", line)
        if ul:
            flush_paragraph()
            if in_ol:
                out.append("</ol>")
                in_ol = False
            if not in_ul:
                out.append("<ul>")
                in_ul = True
            out.append(f"<li>{markdown_inline_to_html(ul.group(1))}</li>")
            continue

        ol = re.match(r"^\d+\.\s+(.*)$", line)
        if ol:
            flush_paragraph()
            if in_ul:
                out.append("</ul>")
                in_ul = False
            if not in_ol:
                out.append("<ol>")
                in_ol = True
            out.append(f"<li>{markdown_inline_to_html(ol.group(1))}</li>")
            continue

        close_lists()
        paragraph_parts.append(line)

    flush_paragraph()
    close_lists()
    close_blockquote()
    return "\n".join(out)


def build_chapter_from_jina(url: str, fallback_title: str) -> tuple[str, str]:
    reader_raw = fetch(jina_reader_url(url))
    title, markdown = extract_jina_markdown_payload(reader_raw)
    html_body = markdown_to_html(markdown)
    if not html_body:
        raise RuntimeError("Reader fallback returned empty content.")
    return (title if title and title != "Untitled" else fallback_title), html_body


def build_chapter_from_scribe(url: str, fallback_title: str) -> tuple[str, str]:
    scribe_html = fetch(medium_scribe_url(url))
    title = extract_title(scribe_html, fallback=fallback_title)
    article_match = re.search(r"<article[^>]*>(.*?)</article>", scribe_html, flags=re.S | re.I)
    if not article_match:
        raise RuntimeError("Could not extract <article> content from scribe mirror.")
    content_html = article_match.group(1).strip()
    if not content_html:
        raise RuntimeError("Scribe mirror returned empty article content.")
    return title, content_html


def absolutize_links(content_html: str, page_url: str) -> str:
    # href="/foo" -> absolute
    content_html = re.sub(
        r'href="(/[^"]*)"',
        lambda m: f'href="{html.escape(urljoin(page_url, m.group(1)), quote=True)}"',
        content_html,
    )
    # src="/foo" -> absolute
    content_html = re.sub(
        r'src="(/[^"]*)"',
        lambda m: f'src="{html.escape(urljoin(page_url, m.group(1)), quote=True)}"',
        content_html,
    )
    return content_html


def normalize_fragment_for_xhtml(content_html: str) -> str:
    # Ensure HTML void tags are XHTML self-closing for strict XML parsing.
    for tag in sorted(VOID_TAGS, key=len, reverse=True):
        pattern = re.compile(rf"<{tag}(\s[^<>]*?)?>", flags=re.I)

        def repl(match: re.Match[str]) -> str:
            original = match.group(0)
            if original.endswith("/>"):
                return original
            attrs = match.group(1) or ""
            return f"<{tag}{attrs} />"

        content_html = pattern.sub(repl, content_html)
    return content_html


@dataclass
class Chapter:
    title: str
    url: str
    filename: str
    xhtml: str


def chapter_xhtml(title: str, body_html: str) -> str:
    return f"""<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8" />
  <title>{html.escape(title)}</title>
  <link rel="stylesheet" type="text/css" href="styles.css" />
</head>
<body>
  <h1>{html.escape(title)}</h1>
  {body_html}
</body>
</html>
"""


def build_epub(book_title: str, author: str, chapters: list[Chapter], output_path: Path) -> None:
    book_id = f"urn:uuid:{uuid.uuid4()}"

    manifest_items = [
        '<item id="toc" href="toc.ncx" media-type="application/x-dtbncx+xml" />',
        '<item id="nav" href="nav.xhtml" media-type="application/xhtml+xml" properties="nav" />',
        '<item id="css" href="styles.css" media-type="text/css" />',
    ]
    spine_items = []
    ncx_navpoints = []
    nav_links = []

    for idx, ch in enumerate(chapters, start=1):
        item_id = f"chap{idx}"
        manifest_items.append(
            f'<item id="{item_id}" href="{html.escape(ch.filename)}" media-type="application/xhtml+xml" />'
        )
        spine_items.append(f'<itemref idref="{item_id}" />')
        ncx_navpoints.append(
            f"""    <navPoint id="navPoint-{idx}" playOrder="{idx}">
      <navLabel><text>{html.escape(ch.title)}</text></navLabel>
      <content src="{html.escape(ch.filename)}" />
    </navPoint>"""
        )
        nav_links.append(f'      <li><a href="{html.escape(ch.filename)}">{html.escape(ch.title)}</a></li>')

    container_xml = """<?xml version="1.0" encoding="utf-8"?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
  <rootfiles>
    <rootfile full-path="OEBPS/content.opf" media-type="application/oebps-package+xml"/>
  </rootfiles>
</container>
"""

    content_opf = f"""<?xml version="1.0" encoding="utf-8"?>
<package xmlns="http://www.idpf.org/2007/opf" version="3.0" unique-identifier="bookid">
  <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
    <dc:identifier id="bookid">{book_id}</dc:identifier>
    <dc:title>{html.escape(book_title)}</dc:title>
    <dc:creator>{html.escape(author)}</dc:creator>
    <dc:language>en</dc:language>
  </metadata>
  <manifest>
    {"\n    ".join(manifest_items)}
  </manifest>
  <spine toc="toc">
    {"\n    ".join(spine_items)}
  </spine>
</package>
"""

    nav_xhtml = f"""<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops">
<head>
  <meta charset="utf-8" />
  <title>Table of Contents</title>
</head>
<body>
  <nav epub:type="toc" id="toc">
    <h1>Contents</h1>
    <ol>
{"\n".join(nav_links)}
    </ol>
  </nav>
</body>
</html>
"""

    toc_ncx = f"""<?xml version="1.0" encoding="utf-8"?>
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1">
  <head>
    <meta name="dtb:uid" content="{book_id}" />
    <meta name="dtb:depth" content="1" />
    <meta name="dtb:totalPageCount" content="0" />
    <meta name="dtb:maxPageNumber" content="0" />
  </head>
  <docTitle><text>{html.escape(book_title)}</text></docTitle>
  <navMap>
{"\n".join(ncx_navpoints)}
  </navMap>
</ncx>
"""

    styles_css = """body {
  font-family: serif;
  line-height: 1.5;
  margin: 1em;
}
h1, h2, h3, h4, h5, h6 {
  line-height: 1.25;
}
img {
  max-width: 100%;
  height: auto;
}
blockquote {
  margin: 0.75em 0 0.75em 1em;
  padding-left: 0.75em;
  border-left: 2px solid #999;
}
"""

    output_path.parent.mkdir(parents=True, exist_ok=True)

    with zipfile.ZipFile(output_path, "w") as zf:
        zf.writestr("mimetype", "application/epub+zip", compress_type=zipfile.ZIP_STORED)
        zf.writestr("META-INF/container.xml", container_xml)
        zf.writestr("OEBPS/content.opf", content_opf)
        zf.writestr("OEBPS/nav.xhtml", nav_xhtml)
        zf.writestr("OEBPS/toc.ncx", toc_ncx)
        zf.writestr("OEBPS/styles.css", styles_css)
        for ch in chapters:
            zf.writestr(f"OEBPS/{ch.filename}", ch.xhtml)


def convert(start_url: str, output_path: Path, book_title: str | None, author: str) -> tuple[str, int]:
    print(f"Fetching start page: {start_url}", file=sys.stderr)
    start_html = fetch(start_url)
    page_urls = extract_guide_links(start_html, start_url)
    print(f"Discovered {len(page_urls)} chapter page(s).", file=sys.stderr)

    chapters: list[Chapter] = []
    for idx, page_url in enumerate(page_urls, start=1):
        print(f"  [{idx}/{len(page_urls)}] {page_url}", file=sys.stderr)
        fallback_title = title_from_url(page_url, fallback=f"Chapter {idx}")
        title = fallback_title
        content_html = ""

        try:
            html_text = fetch(page_url)
            title = extract_title(html_text, fallback=fallback_title)
            content_html = extract_content(html_text)
        except Exception as exc:  # noqa: BLE001
            print(f"Warning: direct fetch failed for {page_url}: {exc}", file=sys.stderr)

        if not content_html:
            if is_medium_url(page_url):
                print("    Falling back to Medium mirror extraction...", file=sys.stderr)
                try:
                    title, content_html = build_chapter_from_scribe(page_url, fallback_title=title)
                except Exception as exc:  # noqa: BLE001
                    print(f"Warning: Medium mirror extraction failed for {page_url}: {exc}", file=sys.stderr)

            if not content_html:
                source_label = "X/Twitter" if is_x_or_twitter_url(page_url) else "reader"
                print(f"    Falling back to {source_label} extraction...", file=sys.stderr)
                try:
                    title, content_html = build_chapter_from_jina(page_url, fallback_title=title)
                except Exception as exc:  # noqa: BLE001
                    print(f"Warning: reader extraction failed for {page_url}: {exc}", file=sys.stderr)
                    continue

        if not content_html:
            print(f"Warning: no article body found on {page_url}; skipping.", file=sys.stderr)
            continue

        content_html = absolutize_links(content_html, page_url)
        content_html = normalize_fragment_for_xhtml(content_html)
        filename = f"{idx:02d}-{slugify(title)}.xhtml"
        chapters.append(
            Chapter(
                title=title,
                url=page_url,
                filename=filename,
                xhtml=chapter_xhtml(title, content_html),
            )
        )

    if not chapters:
        raise RuntimeError("No chapters were extracted. Site layout may have changed.")

    final_title = book_title or chapters[0].title
    build_epub(final_title, author, chapters, output_path)
    return final_title, len(chapters)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Convert a multipage web guide to EPUB.")
    parser.add_argument("--start-url", required=True, help="Entry page URL.")
    parser.add_argument("--output", required=True, help="Output .epub file path.")
    parser.add_argument("--title", help="Override EPUB title.")
    parser.add_argument("--author", default="Unknown", help="EPUB author metadata.")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    output_path = Path(args.output).expanduser().resolve()
    try:
        title, chapter_count = convert(
            start_url=args.start_url,
            output_path=output_path,
            book_title=args.title,
            author=args.author,
        )
    except Exception as exc:  # noqa: BLE001
        print(f"Error: {exc}", file=sys.stderr)
        return 1
    print(f"Created EPUB: {output_path}")
    print(f"Title: {title}")
    print(f"Chapters: {chapter_count}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
