local M = {}

local function openfunc(how)
  return function(item)
    if type(item) == "string" then
      item = vim.fn.bufadd(item)
      vim.bo[item].buflisted = true
    end
    if how == "tab" then
      vim.cmd("tabnew | buffer " .. item)
    elseif how == "edit" then
      local w = vim.fn.win_findbuf(item)[1]
      if w then
        if w ~= vim.api.nvim_get_current_win() then
          vim.api.nvim_set_current_win(w)
          return
        end
      end
      vim.cmd("buffer " .. item)
    elseif how == "split" then
      vim.cmd("sbuffer " .. item)
    elseif how == "vsplit" then
      vim.cmd("vertical sbuffer " .. item)
    end
  end
end

local function tolines(items, opts)
  local func = nil
  if opts["key"] then
    func = function(item)
      return item[opts["key"]]
    end
  elseif opts["text_cb"] then
    func = opts["text_cb"]
  end
  if func then
    return vim.tbl_map(func, items)
  end
  return items
end

local function match_single(items, str, opts)
  local ch, inverse = nil, nil
  if str:sub(1, 1) == "!" then
    ch, inverse, str = "'", true, str:sub(2)
    if str:sub(1, 1) == "^" then
      ch, str = str:sub(1, 1), str:sub(2)
    elseif str:sub(-1) == "$" then
      ch, str = "$", str:sub(1, -2)
    end
  else
    if str:sub(1, 1) == "'" or str:sub(1, 1) == "^" then
      ch, str = str:sub(1, 1), str:sub(2)
    elseif str:sub(-1) == "$" then
      ch, str = "$", str:sub(1, -2)
    end
  end
  if ch then
    local ignorecase = not str:match("%u")
    if ignorecase then
      str = str:lower()
    end
    local func = nil
    if opts["key"] then
      func = function(item)
        return item[opts["key"]]
      end
    elseif opts["text_cb"] then
      func = opts["text_cb"]
    end
    local from, to
    local result = { {}, {} }
    for _, item in ipairs(items) do
      local text = func and func(item) or item
      if ignorecase then
        text = text:lower()
      end
      if ch == "'" then
        from, to = text:find(str, 1, true)
      elseif ch == "^" then
        from, to = text:sub(1, #str) == str and 1 or nil, #str
      else
        from, to = text:sub(-#str) == str and #text - #str + 1 or nil, #text
      end
      if inverse then
        if not from then
          table.insert(result[1], item)
        end
      elseif from then
        table.insert(result[1], item)
        table.insert(result[2], { { from - 1, to - 1 } })
      end
    end
    return result
  end
  return vim.fn.matchfuzzypos(items, str, opts)
end

local function match(items, query, opts)
  local w = 0
  local pos = nil
  for word in query:gmatch("%S+") do
    if w == 1 then
      assert(pos ~= nil)
      local temp = {}
      for i, item in ipairs(items) do
        table.insert(temp, { item = item, pos = pos[i] })
      end
      items = temp
      local func
      if opts["key"] then
        local key = opts["key"]
        func = function(item)
          return item["item"][key]
        end
      elseif opts["text_cb"] then
        local text_cb = opts["text_cb"]
        func = function(item)
          return text_cb(item["item"])
        end
      else
        func = function(item)
          return item["item"]
        end
      end
      opts = { text_cb = func, matchseq = 1 }
    elseif w > 1 then
      assert(pos ~= nil)
      for i, item in ipairs(items) do
        for _, p in ipairs(pos[i]) do
          table.insert(item["pos"], p)
        end
      end
    end
    items, pos = unpack(match_single(items, word, opts))
    w = w + 1
  end
  if w > 1 then
    local temp = {}
    for i, item in ipairs(items) do
      table.insert(temp, item["item"])
      for _, p in ipairs(pos[i]) do
        table.insert(item["pos"], p)
      end
      pos[i] = item["pos"]
    end
    items = temp
  end
  return { items, pos }
end

function M.pick(prompt, src, onclose, opts)
  local lspbuf = vim.api.nvim_get_current_buf()
  opts = vim.tbl_deep_extend("force", { matchseq = 1 }, opts or {})

  local ritems, items, sitems = {}, {}, {}
  local function setitems(arr)
    ritems = arr
    if opts.filter and opts.filter.func and opts.filter.enabled then
      items = vim.tbl_filter(opts.filter.func, ritems)
    else
      items = ritems
    end
  end

  if not opts["live"] then
    if type(src) == "function" then
      local srcopts = {}
      if opts.filter and not opts.filter.func then
        srcopts.filter = opts.filter.enabled
      end
      src(function(result)
        opts["src"] = src
        M.pick(prompt, result, onclose, opts)
      end, srcopts)
      return
    end
    setitems(src)
    if #items == 0 then
      local name = prompt:sub(-1) == ":" and prompt:sub(1, -2) or prompt
      vim.api.nvim_echo({ { "No " .. name .. " to select", "WarningMsg" } }, false, {})
      onclose(nil, {})
      return
    elseif #items == 1 then
      onclose(items[1], { open = openfunc("edit") })
      return
    end
  end
  local pbuf = vim.api.nvim_create_buf(false, true)
  vim.b[pbuf].completion = false
  local pwin = vim.api.nvim_open_win(pbuf, true, {
    relative = "editor",
    width = vim.o.columns,
    height = 1,
    row = vim.o.lines,
    col = 0,
    style = "minimal",
    zindex = 250,
  })
  vim.api.nvim_set_option_value("statuscolumn", prompt .. " ", { scope = "local", win = pwin })
  vim.api.nvim_set_option_value("winhighlight", "Normal:MsgArea,FloatBorder:Normal", { scope = "local", win = pwin })

  vim.cmd.startinsert()

  local sbuf = vim.api.nvim_create_buf(false, true)
  local sconfig = {
    relative = "editor",
    style = "minimal",
    border = { "", "", "", " ", "", "", "", " " },
    focusable = false,
    zindex = 100,
  }
  local swin = -1
  local closed = nil
  local timer = nil

  local gwin = nil
  local gconfig = {
    relative = "editor",
    row = 0,
    col = 0,
    width = vim.o.columns,
    height = vim.o.lines - 1,
    focusable = false,
    zindex = 50,
  }
  local ns = vim.api.nvim_create_namespace("fuzzyhl")
  local function show_preview()
    if not opts.preview then
      return
    end
    if gwin then
      vim.api.nvim_buf_clear_namespace(vim.api.nvim_win_get_buf(gwin), ns, 0, -1)
      vim.api.nvim_win_hide(gwin)
      gwin = nil
    end
    if not sitems or #sitems == 0 then
      return
    end
    local line = vim.fn.line(".", swin)
    local item = sitems[line]
    item = opts.preview(item)
    if not item then
      return
    end
    gwin = vim.api.nvim_open_win(item.bufnr, false, gconfig)
    vim.api.nvim_set_option_value("winhighlight", "Normal:Normal,FloatBorder:Normal", { scope = "local", win = gwin })
    vim.api.nvim_set_option_value("cursorline", true, { scope = "local", win = gwin })
    if item.lnum and item.lnum > 0 then
      vim.api.nvim_win_call(gwin, function()
        vim.api.nvim_win_set_cursor(gwin, { item.lnum, item.col })
        local gbuf = vim.api.nvim_win_get_buf(gwin)
        vim.api.nvim_buf_set_extmark(gbuf, ns, item.lnum - 1, item.col - 1, {
          end_col = item.end_col - 1,
          hl_group = "Incsearch",
          strict = false,
          priority = 900,
        })
        vim.cmd("normal! zz")
      end)
    end
  end

  local function close(copts)
    if closed then
      return
    end
    closed = true
    if timer then
      vim.fn.timer_stop(timer)
    end
    if gwin then
      vim.api.nvim_set_option_value("winhighlight", nil, { scope = "local", win = gwin })
      vim.api.nvim_set_option_value("cursorline", nil, { scope = "local", win = gwin })
      vim.api.nvim_buf_clear_namespace(vim.api.nvim_win_get_buf(gwin), ns, 0, -1)
      vim.api.nvim_win_close(gwin, true)
    end
    local line = vim.fn.line(".", swin)
    vim.cmd.stopinsert()
    vim.api.nvim_buf_delete(pbuf, {})
    vim.api.nvim_buf_delete(sbuf, {})
    if copts and copts["qflist"] then
      onclose(sitems, copts)
    else
      local item = nil
      if copts then
        if sitems ~= nil and line > 0 and line <= #sitems then
          item = sitems[line]
        end
      end
      onclose(item, copts)
    end
  end
  local function move(i)
    local line = vim.api.nvim_win_get_cursor(swin)[1] + i
    if line > 0 and line <= vim.api.nvim_buf_line_count(sbuf) then
      vim.api.nvim_win_set_cursor(swin, { line, 0 })
      show_preview()
    end
  end
  local function keymap(lhs, func, args)
    vim.keymap.set("i", lhs, function()
      func(unpack(args or {}))
    end, { buffer = pbuf })
  end
  vim.api.nvim_create_autocmd("WinLeave", {
    buffer = pbuf,
    callback = function()
      close(nil)
    end,
  })
  keymap("<tab>", function() end, {})
  if opts and opts["qflist"] then
    keymap("<c-q>", close, { { qflist = true } })
  end
  keymap("<cr>", close, { { open = openfunc("edit") } })
  keymap("<c-s>", close, { { open = openfunc("split") } })
  keymap("<c-v>", close, { { open = openfunc("vsplit") } })
  keymap("<c-t>", close, { { open = openfunc("tab") } })
  keymap("<esc>", close, { nil })
  keymap("<c-n>", move, { 1 })
  keymap("<c-p>", move, { -1 })
  keymap("<down>", move, { 1 })
  keymap("<up>", move, { -1 })

  local function showitems(lines, pos)
    if closed then
      return
    end
    sitems = lines
    lines = tolines(lines, opts)
    vim.api.nvim_buf_clear_namespace(sbuf, ns, 0, -1)
    vim.api.nvim_buf_set_lines(sbuf, 0, -1, false, lines)

    -- show counts
    local counts = ""
    if items and #items > #sitems then
      counts = string.format("%d/%d", #sitems, #items)
    elseif #sitems > 0 then
      counts = counts .. #sitems
    end
    vim.api.nvim_buf_clear_namespace(pbuf, ns, 0, -1)
    vim.api.nvim_buf_set_extmark(pbuf, ns, 0, 0, {
      virt_text = { { counts, "Comment" } },
      virt_text_pos = "right_align",
      strict = false,
    })

    if #lines == 0 then
      if swin ~= -1 then
        vim.api.nvim_win_hide(swin)
        swin = -1
      end
    else
      local ht = math.min(10, #lines)
      local w = 15
      for _, line in ipairs(lines) do
        w = math.max(w, #line)
      end
      sconfig = vim.tbl_extend("force", sconfig, {
        width = w,
        height = ht,
        row = vim.o.lines - ht - 1,
        col = 0,
      })
      if swin == -1 then
        swin = vim.api.nvim_open_win(sbuf, false, sconfig)
      else
        vim.api.nvim_win_set_config(swin, sconfig)
      end
      vim.api.nvim_set_option_value("cursorline", true, { scope = "local", win = swin })
      if opts["add_highlights"] then
        for i, line in ipairs(lines) do
          opts["add_highlights"](sitems[i], line, function(col, ext_opts)
            ext_opts.priority = 800
            vim.api.nvim_buf_set_extmark(sbuf, ns, i - 1, col, ext_opts)
          end)
        end
      end
      if pos ~= nil then
        for line, arr in ipairs(pos) do
          for _, p in ipairs(arr) do
            local from, to
            if type(p) == "table" then
              from, to = p[1], p[2] + 1
            else
              from, to = p, p + 1
            end
            vim.api.nvim_buf_set_extmark(sbuf, ns, line - 1, from, {
              end_col = to,
              hl_group = "Special",
              strict = false,
              priority = 900,
            })
          end
        end
      end
    end
    show_preview()
  end
  if opts and opts.filter then
    keymap("<c-h>", function()
      opts.filter.enabled = not opts.filter.enabled
      local function refresh(result)
        setitems(result)
        local query = vim.fn.getline(1)
        if #query == 0 or opts.live then
          showitems(items)
        else
          local matched = match(items, query, opts)
          showitems(matched[1], matched[2])
        end
      end
      if opts.filter.func then
        refresh(ritems)
      else
        opts.src(function(result)
          refresh(result)
        end, { filter = opts.filter.enabled })
      end
    end)
  end
  showitems(items or {})
  vim.api.nvim_create_autocmd("TextChangedI", {
    buffer = pbuf,
    callback = function()
      if timer then
        vim.fn.timer_stop(timer)
        timer = nil
      end
      local query = vim.fn.getline(1)
      if #query > 0 then
        if opts["live"] then
          timer = vim.fn.timer_start(250, function()
            vim.api.nvim_buf_call(lspbuf, function()
              src(function(result)
                setitems(result)
                showitems(items, nil)
              end, { query = query })
            end)
          end)
        else
          local matched = match(items, query, opts)
          showitems(matched[1], matched[2])
        end
      else
        showitems(items or {}, nil)
      end
    end,
  })
end

------------------------------------------------------------------------

function M.select(items, opts, on_choice)
  local prompt = opts and opts["prompt"] or ""
  local popts = {}
  if opts and opts["format_item"] ~= nil then
    popts["text_cb"] = opts["format_item"]
  end
  M.pick(prompt, items, on_choice, popts)
end

local function fileshorten(fname)
  if vim.fn.isabsolutepath(fname) == 0 then
    return fname
  end
  local name = vim.fn.fnamemodify(fname, ":.")
  if name == fname then
    name = vim.fn.fnamemodify(name, ":~")
  end
  return name
end

local function qfentry_text(item)
  local file = item.filename or vim.fn.bufname(item.bufnr)
  local text = fileshorten(file) .. ":"
  if item.lnum and item.lnum > 0 then
    text = text .. item.lnum
  end
  if item["text"] then
    text = text .. " " .. item["text"]
  end
  return text
end

local typeHilights = {
  E = "DiagnosticSignError",
  W = "DiagnosticSignWarn",
  I = "DiagnosticSignInfo",
  N = "DiagnosticSignHint",
  H = "DiagnosticSignHint",
}

local function qfentry_add_highlights(item, line, add_highlight)
  local i = line:find(":", 1, true)
  if i then
    add_highlight(0, {
      end_col = i - 1,
      hl_group = "qfFilename",
      strict = false,
    })
    local k = line:find(" ", i + 1, true)
    assert(k ~= nil)
    add_highlight(i, {
      end_col = k - 1,
      hl_group = "qfLineNr",
      strict = false,
    })
    if item.type then
      add_highlight(k, {
        end_col = #line,
        hl_group = typeHilights[item.type],
        strict = false,
      })
    else
      local matches = item.matches
      if not matches then
        if item.lnum and item.col and item.end_col then
          if item.lnum > 0 and item.col > 0 and item.end_col > 0 then
            matches = { { item.col, item.end_col } }
          end
        end
      end
      for _, m in ipairs(matches or {}) do
        add_highlight(k + m[1] - 1, {
          end_col = k + m[2],
          hl_group = "ErrorMsg",
          strict = false,
        })
      end
    end
  end
end

local function qfentry_filter_cwd(item)
  local file = item.filename
  file = vim.fn.fnamemodify(file, ":.")
  return vim.fn.isabsolutepath(file) == 0
end

local function qfentry_preview(item)
  local bufnr = item.bufnr
  if not bufnr then
    bufnr = vim.fn.bufadd(item.filename)
  end
  return {
    bufnr = bufnr,
    lnum = item.lnum,
    col = item.col,
    end_col = item.end_col,
    matches = item.matches,
  }
end

local function open_qfentry(item, opts)
  if item ~= nil then
    if opts["qflist"] then
      vim.fn.setqflist(item)
      vim.cmd.copen()
    else
      vim.cmd("normal! m'")
      opts["open"](item.bufnr or item.filename)
      vim.fn.cursor(item["lnum"], item["col"] + 1)
      vim.cmd("normal! zz")
    end
  end
end

------------------------------------------------------------------------

local function files(on_list, opts)
  local cmd = "fd --type f --type l --color=never -E .git"
  if not opts.filter then
    cmd = cmd .. " --hidden"
  end
  on_list(vim.fn.systemlist(cmd))
end

local function edit(item, opts)
  if item then
    if opts["qflist"] then
      vim.fn.setqflist(vim.tbl_map(function(file)
        return { filename = file, text = file }
      end, item))
      vim.cmd.copen()
    else
      opts["open"](item)
    end
  end
end

function M.pick_file()
  if vim.fn.executable("fd") == 0 then
    vim.api.nvim_echo({ { "fd is not available", "ErrorMsg" } }, false, {})
    return
  end
  M.pick("File:", files, edit, { qflist = true, filter = { enabled = true } })
end

------------------------------------------------------------------------

local function buffers()
  local cur = vim.fn.bufnr("%")
  local alt = vim.fn.bufnr("#")
  local items = {}
  for _, bufinfo in ipairs(vim.fn.getbufinfo({ bufloaded = 1, buflisted = 1 })) do
    if bufinfo.bufnr == alt then
      table.insert(items, 1, bufinfo.bufnr)
    elseif bufinfo.bufnr ~= cur then
      table.insert(items, bufinfo.bufnr)
    end
  end
  return items
end

local function buffer_text(item)
  local name = vim.fn.bufname(item)
  if name == "" then
    name = string.format("%q", vim.bo[item].buftype)
  end
  return name
end

function M.pick_buffer()
  M.pick("Buffer:", buffers(), edit, { text_cb = buffer_text })
end

------------------------------------------------------------------------

local function grep(on_list, opts)
  local cmd = {
    "rg",
    "--column",
    "--line-number",
    "--no-heading",
    "--color=always",
    "--no-config",
    "--smart-case",
    "--colors=path:fg:magenta",
    "--colors=line:fg:green",
    "--colors=match:fg:red",
    "--colors=match:style:bold",
  }
  local query = opts.query
  while query:sub(1, 1) == "-" do
    local i, j = query:find("%s+")
    if not i then
      on_list({})
      return
    end
    table.insert(cmd, query:sub(1, i - 1))
    query = query:sub(j + 1)
    if cmd[#cmd] == "--" then
      break
    end
  end
  if query == "" then
    on_list({})
    return
  end
  if cmd[#cmd] ~= "--" then
    table.insert(cmd, "--")
  end
  table.insert(cmd, query)
  local list = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    on_list({})
    return
  end
  local items = {}
  for _, line in ipairs(list) do
    local i = line:find(":", 1, true)
    if i then
      local j = line:find(":", i + 1, true)
      assert(j ~= nil)
      local k = line:find(":", j + 1, true)
      assert(k ~= nil)
      local col = tonumber(line:sub(j + 5, k - 5))
      local t = line:sub(k + 1)
      local text = ""
      local matches = {}
      while true do
        local x, y = t:find("[0m[1m[31m", 1, true)
        if not x then
          text = text .. t
          break
        end
        local m, n = t:find("[0m", y + 1, true)
        if not m then
          text = text .. t
          break
        end
        table.insert(matches, { #text + x, #text + x + m - y - 2 })
        text = text .. t:sub(1, x - 1) .. t:sub(y + 1, m - 1)
        t = t:sub(n + 1)
      end
      local lnum = tonumber(line:sub(i + 10, j - 5))
      table.insert(items, {
        filename = line:sub(10, i - 1 - 4),
        lnum = lnum,
        col = col,
        end_lnum = lnum,
        end_col = matches[1][2] + 1,
        matches = matches,
        text = text,
      })
    else
      table.insert(items, {
        filename = line:sub(10, -5),
      })
    end
  end
  on_list(items)
end

function M.pick_grep()
  if vim.fn.executable("rg") == 0 then
    vim.api.nvim_echo({ { "ripgrep is not available", "ErrorMsg" } }, false, {})
    return
  end
  M.pick("Grep:", grep, open_qfentry, {
    text_cb = qfentry_text,
    live = true,
    add_highlights = qfentry_add_highlights,
    preview = qfentry_preview,
    qflist = true,
  })
end

------------------------------------------------------------------------

local function lsp_items(func)
  return function(on_list)
    return func({
      on_list = function(result)
        on_list(result.items)
      end,
    })
  end
end

local function pick_lsp_item(prompt, func, filter)
  M.pick(prompt, lsp_items(func), open_qfentry, {
    text_cb = qfentry_text,
    add_highlights = qfentry_add_highlights,
    preview = qfentry_preview,
    qflist = true,
    filter = filter,
  })
end

function M.pick_declaration()
  pick_lsp_item("Declaration:", vim.lsp.buf.declaration)
end

function M.pick_definition()
  pick_lsp_item("Definition:", vim.lsp.buf.definition)
end

function M.pick_type_definition()
  pick_lsp_item("TypeDefinition:", vim.lsp.buf.type_definition)
end

function M.pick_implementation()
  pick_lsp_item("Implementation:", vim.lsp.buf.implementation)
end

function M.pick_reference()
  pick_lsp_item("Reference:", function(opts)
    return vim.lsp.buf.references({}, opts)
  end, { func = qfentry_filter_cwd, enabled = true })
end

------------------------------------------------------------------------

local exclude_symbols = {
  { "Constant", "Variable", "Object", "Number", "String", "Boolean", "Array" },
  lua = { "Package" },
}

local function filter_symbol(item)
  local kind = item["kind"]
  if vim.tbl_contains(exclude_symbols[1], kind) then
    return false
  end
  local tbl = exclude_symbols[vim.bo.filetype]
  if tbl ~= nil and vim.tbl_contains(tbl, kind) then
    return false
  end
  return true
end

local function document_symbols(on_list)
  return vim.lsp.buf.document_symbol({
    on_list = function(result)
      on_list(vim.tbl_filter(filter_symbol, result.items))
    end,
  })
end

local function document_symbol_text(item)
  local text = item["text"]
  local index = string.find(text, " ")
  if index then
    text = string.sub(text, index + 1)
  end
  return string.format("%-80s %13s", text, item["kind"])
end

local function document_symbol_add_highlights(item, line, add_highlight)
  add_highlight(#line - 13, {
    end_col = #line,
    hl_group = "Comment",
    strict = false,
  })
end

function M.pick_document_symbol()
  M.pick("DocSymbol:", document_symbols, open_qfentry, {
    text_cb = document_symbol_text,
    preview = qfentry_preview,
    add_highlights = document_symbol_add_highlights,
  })
end

local function workspace_symbols(on_list, opts)
  return vim.lsp.buf.workspace_symbol(opts.query, {
    on_list = function(result)
      on_list(vim.tbl_filter(filter_symbol, result.items))
    end,
  })
end

local function workspace_symbol_text(item)
  local text = item["text"]
  local index = string.find(text, " ")
  if index then
    text = string.sub(text, index + 1)
  end
  local line = string.format("%-13s %s", item.kind, text)
  local file = fileshorten(item.filename)
  local w = vim.o.columns - #line - #file - 3
  return string.format("%s %s%s", line, string.rep(" ", w), file)
end

local function workspace_symbol_add_highlights(item, line, add_highlight)
  add_highlight(0, {
    end_col = 13,
    hl_group = "Comment",
    strict = false,
  })
  local text = item.text
  local index = string.find(text, " ")
  if index then
    text = string.sub(text, index + 1)
  end
  add_highlight(14 + #text, {
    end_col = vim.o.columns,
    hl_group = "qfFilename",
    strict = false,
  })
end

function M.pick_workspace_symbol()
  M.pick("WorkSymbol:", workspace_symbols, open_qfentry, {
    text_cb = workspace_symbol_text,
    preview = qfentry_preview,
    add_highlights = workspace_symbol_add_highlights,
    live = true,
    filter = { func = qfentry_filter_cwd, enabled = true },
  })
end

------------------------------------------------------------------------

local function diagnostics(bufnr)
  return function(on_list)
    on_list(vim.diagnostic.toqflist(vim.diagnostic.get(bufnr)))
  end
end

function M.pick_document_diagnostic()
  return M.pick("DocDiagnostic", diagnostics(0), open_qfentry, {
    text_cb = qfentry_text,
    preview = qfentry_preview,
    add_highlights = qfentry_add_highlights,
    qflist = true,
  })
end

function M.pick_workspace_diagnostic()
  return M.pick("WorkDiagnostic", diagnostics(nil), open_qfentry, {
    text_cb = qfentry_text,
    preview = qfentry_preview,
    add_highlights = qfentry_add_highlights,
    qflist = true,
    filter = { func = qfentry_filter_cwd, enabled = true },
  })
end

------------------------------------------------------------------------

function M.setup()
  vim.ui.select = M.select
  vim.keymap.set("n", "<leader>f", M.pick_file)
  vim.keymap.set("n", "<leader>b", M.pick_buffer)
  vim.keymap.set("n", "<leader>/", M.pick_grep)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspPickers", {}),
    callback = function(ev)
      local function opts(desc)
        return { buffer = ev.buf, desc = desc }
      end
      vim.keymap.set("n", "gD", M.pick_declaration, opts("Goto declaration"))
      vim.keymap.set("n", "gd", M.pick_definition, opts("Goto definition"))
      vim.keymap.set("n", "gi", M.pick_implementation, opts("Goto implementation"))
      vim.keymap.set("n", "gy", M.pick_type_definition, opts("Goto type definition"))
      vim.keymap.set("n", "<leader>r", M.pick_reference, opts("Goto reference"))
      vim.keymap.set("n", "<leader>s", M.pick_document_symbol, opts("Open symbol picker"))
      vim.keymap.set("n", "<leader>S", M.pick_workspace_symbol, opts("Open workspace symbol picker"))
      vim.keymap.set("n", "<leader>d", M.pick_document_diagnostic, opts("Open diagnostic picker"))
      vim.keymap.set("n", "<leader>D", M.pick_workspace_diagnostic, opts("Open workspace diagnostic picker"))
    end,
  })
end

return M
