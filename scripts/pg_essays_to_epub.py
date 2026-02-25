#!/usr/bin/env python3
"""Build a single EPUB containing essays listed on paulgraham.com/articles.html.

Run with uv dependencies, for example:
  uv run --with requests --with beautifulsoup4 --with trafilatura \
    scripts/pg_essays_to_epub.py --output converted-epubs/paul-graham-essays.epub
"""

from __future__ import annotations

import argparse
import html
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import urljoin, urlparse

import requests
import trafilatura
from bs4 import BeautifulSoup

# Ensure repo root is importable when this file is executed directly.
REPO_ROOT = Path(__file__).resolve().parent.parent
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from scripts.web_to_epub import (
    Chapter,
    build_epub,
    chapter_xhtml,
    normalize_fragment_for_xhtml,
    slugify,
)


INDEX_URL = "https://paulgraham.com/articles.html"
TIMEOUT = 25
UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
)

EXCLUDED_PATHS = {
    "/index.html",
    "/articles.html",
    "/books.html",
    "/arc.html",
    "/bel.html",
    "/lisp.html",
    "/antispam.html",
    "/kedrosky.html",
    "/faq.html",
    "/raq.html",
    "/quo.html",
    "/rss.html",
    "/bio.html",
    "/apply.html",
}


@dataclass
class EssayLink:
    title: str
    url: str


def get_text(url: str, session: requests.Session) -> str:
    r = session.get(url, timeout=TIMEOUT)
    r.raise_for_status()
    r.encoding = r.encoding or "utf-8"
    return r.text


def should_include_link(abs_url: str) -> bool:
    parsed = urlparse(abs_url)
    host = (parsed.netloc or "").lower()
    path = parsed.path or ""

    if host in {"paulgraham.com", "www.paulgraham.com"}:
        if path in EXCLUDED_PATHS:
            return False
        return path.endswith(".html") or path.endswith(".txt")

    if host == "sep.turbifycdn.com":
        return bool(re.search(r"/paulgraham/acl\d+\.txt$", path))

    return False


def clean_title(raw: str) -> str:
    text = re.sub(r"\s+", " ", raw or "").strip()
    return html.unescape(text)


def parse_essay_links(index_html: str) -> list[EssayLink]:
    soup = BeautifulSoup(index_html, "html.parser")
    links: list[EssayLink] = []
    seen: set[str] = set()

    for a in soup.select("table[width='435'] a[href]"):
        href = (a.get("href") or "").strip()
        if not href or href.startswith("#") or href.startswith("javascript:"):
            continue
        abs_url = urljoin(INDEX_URL, href)
        abs_url = abs_url.split("#", 1)[0]
        if not should_include_link(abs_url):
            continue
        if abs_url in seen:
            continue
        title = clean_title(a.get_text(" ", strip=True))
        if not title:
            continue
        seen.add(abs_url)
        links.append(EssayLink(title=title, url=abs_url))

    return links


def absolutize_urls(fragment_html: str, page_url: str) -> str:
    fragment_html = re.sub(
        r'href="(?!https?://|mailto:|#|data:)([^"]+)"',
        lambda m: f'href="{html.escape(urljoin(page_url, m.group(1)), quote=True)}"',
        fragment_html,
    )
    fragment_html = re.sub(
        r'src="(?!https?://|data:)([^"]+)"',
        lambda m: f'src="{html.escape(urljoin(page_url, m.group(1)), quote=True)}"',
        fragment_html,
    )
    return fragment_html


def html_fallback_body(doc_html: str) -> str:
    soup = BeautifulSoup(doc_html, "html.parser")
    for t in soup(["script", "style", "noscript"]):
        t.decompose()

    tds = soup.find_all("td")
    if not tds:
        body = soup.body or soup
        return body.decode_contents()

    main_td = max(tds, key=lambda td: len(td.get_text(" ", strip=True)))
    return main_td.decode_contents()


def extract_chapter_html(
    essay: EssayLink,
    session: requests.Session,
) -> tuple[str, str]:
    parsed = urlparse(essay.url)
    is_text_file = parsed.path.endswith(".txt")

    if is_text_file:
        raw = get_text(essay.url, session)
        body_html = f"<pre>{html.escape(raw)}</pre>"
        return essay.title, body_html

    page_html = get_text(essay.url, session)
    soup = BeautifulSoup(page_html, "html.parser")

    page_title = clean_title(soup.title.get_text(" ", strip=True) if soup.title else essay.title)
    chapter_title = page_title or essay.title

    # Try high-quality extraction first.
    extracted_html = None
    try:
        downloaded = trafilatura.fetch_url(essay.url)
        if downloaded:
            extracted_html = trafilatura.extract(
                downloaded,
                output_format="html",
                include_links=True,
                include_images=False,
                include_tables=True,
                favor_precision=True,
            )
    except Exception:  # noqa: BLE001
        extracted_html = None

    if extracted_html:
        body_html = extracted_html
    else:
        body_html = html_fallback_body(page_html)

    body_html = absolutize_urls(body_html, essay.url)
    body_html = normalize_fragment_for_xhtml(body_html)
    return chapter_title, body_html


def build_pg_essays_epub(output_path: Path, limit: int | None = None) -> tuple[int, int]:
    session = requests.Session()
    session.headers.update({"User-Agent": UA})

    print(f"Fetching index: {INDEX_URL}", file=sys.stderr)
    index_html = get_text(INDEX_URL, session)
    links = parse_essay_links(index_html)
    if limit is not None:
        links = links[:limit]
    print(f"Discovered {len(links)} listed essays.", file=sys.stderr)

    chapters: list[Chapter] = []
    failed = 0
    for idx, essay in enumerate(links, start=1):
        print(f"  [{idx}/{len(links)}] {essay.title}", file=sys.stderr)
        try:
            title, body = extract_chapter_html(essay, session)
        except Exception as exc:  # noqa: BLE001
            failed += 1
            print(f"    Warning: failed to fetch/extract {essay.url}: {exc}", file=sys.stderr)
            continue

        filename = f"{idx:03d}-{slugify(title)[:80]}.xhtml"
        chapters.append(
            Chapter(
                title=title,
                url=essay.url,
                filename=filename,
                xhtml=chapter_xhtml(title, body),
            )
        )

    if not chapters:
        raise RuntimeError("No chapters extracted from articles index.")

    build_epub(
        book_title="Paul Graham Essays (articles.html)",
        author="Paul Graham",
        chapters=chapters,
        output_path=output_path,
    )
    return len(chapters), failed


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Build one EPUB from Paul Graham's articles index.")
    p.add_argument("--output", required=True, help="Output .epub path")
    p.add_argument("--limit", type=int, help="Optional: max essays for testing")
    return p.parse_args()


def main() -> int:
    args = parse_args()
    out = Path(args.output).expanduser().resolve()
    try:
        count, failed = build_pg_essays_epub(out, limit=args.limit)
    except Exception as exc:  # noqa: BLE001
        print(f"Error: {exc}", file=sys.stderr)
        return 1
    print(f"Created EPUB: {out}")
    print(f"Chapters: {count}")
    print(f"Skipped (failed): {failed}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
