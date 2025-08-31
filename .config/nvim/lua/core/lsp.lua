local virtual_text_config = { current_line = true }
-- local virtual_lines_config = { current_line = true, severity = { min = "ERROR" } }
local virtual_lines_config = false
vim.diagnostic.config({
  virtual_text = virtual_text_config,
  virtual_lines = virtual_lines_config,
  update_in_insert = false,
  -- It is annoying to see too many errors when in insert mode,
  -- virtual_text = { current_line = true, severity = { min = "ERROR" } },
  -- virtual_lines = { current_line = true, severity = { min = "ERROR" } },
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.WARN] = "●",
      [vim.diagnostic.severity.INFO] = "●",
      [vim.diagnostic.severity.HINT] = "●",
    },
  },
})

local function restart_lsp(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients
  if vim.lsp.get_clients then
    clients = vim.lsp.get_clients({ bufnr = bufnr })
  else
    ---@diagnostic disable-next-line: deprecated
    clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  end

  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end

  vim.defer_fn(function()
    vim.cmd("edit")
  end, 100)
end

vim.api.nvim_create_user_command("LspRestart", function()
  restart_lsp()
end, {})

local vue_language_server_path = vim.fn.stdpath("data")
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}

local vue_ls_config = {}

vim.lsp.config("vtsls", vtsls_config)
vim.lsp.config("vue_ls", vue_ls_config)
vim.lsp.config("tailwindcss", {
  emmetCompletions = true,
  classFunctions = { "tw", "clsx", "cn", "tw\\.[a-z-]+" },
  includeLanguages = {
    php = "html",
    blade = "html",
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.enable({ "vtsls", "vue_ls", "lua_ls" })

local methods = vim.lsp.protocol.Methods

-- Navigate LSP references for the word under cursor
local ref_state = {}

---@param bufnr integer
---@return table
local function get_buf_references(bufnr)
  -- Use current window id for position params to avoid invalid win errors
  local params = vim.lsp.util.make_position_params(0)
  params.context = { includeDeclaration = true }

  local results = vim.lsp.buf_request_sync(bufnr, methods.textDocument_references, params, 800)
  if not results then
    return {}
  end

  local items = {}
  local seen = {}

  for client_id, res in pairs(results) do
    if res and res.result then
      local client = vim.lsp.get_client_by_id(client_id)
      local enc = client and client.offset_encoding or "utf-16"
      for _, loc in ipairs(res.result) do
        local uri = loc.uri or loc.targetUri
        local range = loc.range or loc.targetRange or loc.targetSelectionRange
        if uri and range then
          local lbuf = vim.uri_to_bufnr(uri)
          if lbuf == bufnr then
            local lnum = (range.start.line or 0) + 1
            local col = vim.lsp.util._get_line_byte_from_position(bufnr, range.start, enc)
            local key = string.format("%d:%d", lnum, col)
            if not seen[key] then
              table.insert(items, { lnum = lnum, col = col, location = loc, enc = enc })
              seen[key] = true
            end
          end
        end
      end
    end
  end

  table.sort(items, function(a, b)
    if a.lnum == b.lnum then
      return a.col < b.col
    end
    return a.lnum < b.lnum
  end)

  return items
end

---@param bufnr integer
---@param direction integer -- 1 for next, -1 for previous
local function cycle_references(bufnr, direction)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local word = vim.fn.expand("<cword>")
  local tick = vim.api.nvim_buf_get_changedtick(bufnr)

  local state = ref_state[bufnr]
  if not state or state.word ~= word or state.tick ~= tick then
    state = { word = word, items = get_buf_references(bufnr), index = nil, tick = tick }
    ref_state[bufnr] = state
  end

  local items = state.items or {}
  if #items == 0 then
    vim.notify("No LSP references found", vim.log.levels.INFO)
    return
  end

  local cur = vim.api.nvim_win_get_cursor(0) -- {lnum, col0}
  local cur_lnum, cur_col = cur[1], cur[2]
  local target_idx

  if direction > 0 then
    for i, item in ipairs(items) do
      if item.lnum > cur_lnum or (item.lnum == cur_lnum and item.col > cur_col) then
        target_idx = i
        break
      end
    end
    target_idx = target_idx or 1 -- wrap
  else
    for i = #items, 1, -1 do
      local item = items[i]
      if item.lnum < cur_lnum then
        target_idx = i
        break
      elseif item.lnum == cur_lnum then
        -- If cursor is after this reference (and not inside it), pick this
        if cur_col > item.col then
          local inside = false
          if item.location and item.location.range then
            local end_col = vim.lsp.util._get_line_byte_from_position(bufnr, item.location.range["end"], item.enc)
            if cur_col < end_col then
              inside = true
            end
          end
          if not inside then
            target_idx = i
            break
          end
        end
        -- otherwise continue to earlier items
      end
    end
    target_idx = target_idx or #items -- wrap
  end

  local item = items[target_idx]
  state.index = target_idx
  if item.location then
    vim.lsp.util.jump_to_location(item.location, item.enc)
  else
    vim.api.nvim_win_set_cursor(0, { item.lnum, math.max(0, item.col) })
  end
end

--- Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
  local map = function(keys, func, desc, mode)
    vim.keymap.set(mode or "n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  -- map("g.", "<cmd>FzfLua lsp_code_actions<cr>", "Code Action", { "n", "x" })
  map("g.", function()
    require("tiny-code-action").code_action()
  end, "Code Action", { "n", "x" })

  -- Find references for the word under your cursor.
  map("grr", "<cmd>FzfLua lsp_references<cr>", "[G]oto [R]eference all [R]eferences")

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map("gri", "<cmd>FzfLua lsp_implementations<cr>", "[G]oto [R]eference [I]mplementation")

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map("gd", "<cmd>FzfLua lsp_definitions<cr>", "[G]oto [D]efinition")

  -- Peek the definition of the word under your cursor.
  map("gD", "<cmd>FzfLua lsp_definitions jump1=false <cr>", "[G]oto [D]efinition (Peek)")

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map("grd", "<cmd>FzfLua lsp_document_symbols<cr>", "[G]oto [R]eference [D]ocument Symbols")

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map("grw", "<cmd>FzfLua lsp_workspace_symbols<cr>", "[G]oto [R]eference [W]orkspace Symbols")

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map("grt", "<cmd>FzfLua lsp_typedefs<cr>", "[G]oto [R]eference [T]ype Definition")

  -- stylua: ignore
  map("[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end,
    "Previeous [E]rror")
  -- stylua: ignore
  map("]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, "Next [E]rror")
  -- Navigate LSP references in current buffer
  if client:supports_method(methods.textDocument_references) then
    map("]]", function()
      cycle_references(bufnr, 1)
    end, "Next LSP reference in buffer")
    map("[[", function()
      cycle_references(bufnr, -1)
    end, "Previous LSP reference in buffer")
  end
  map("<leader>lr", "<cmd>LspRestart<cr>", "[L]sp [R]estart")
  map("<leader>li", "<cmd>LspInfo<cr>", "[l]sp [I]nfo")
  map("<leader>lg", "<cmd>LspLog<cr>", "[l]sp lo[g]")
  map("<leader>tld", function()
    local config = vim.diagnostic.config().virtual_lines
    if config then
      vim.diagnostic.config({ virtual_lines = false, virtual_text = false, underline = false })
    else
      vim.diagnostic.config({
        virtual_lines = virtual_lines_config,
        virtual_text = virtual_text_config,
        underline = true,
      })
    end
  end, "[T]oggle [l]sp [d]iagnostics")

  -- NOTE: Snacks.nvim does this I think
  if client:supports_method(methods.textDocument_documentHighlight) then
    local under_cursor_highlights_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Highlight references under the cursor",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
      group = under_cursor_highlights_group,
      desc = "Clear highlight references",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
  --   -- for copilot lsp server
  --   vim.lsp.inline_completion.enable(true)
  --
  --   vim.keymap.set("i", "<tab>", function()
  --     if not vim.lsp.inline_completion.get() then
  --       return "<tab>"
  --     end
  --   end, {
  --     expr = true,
  --     replace_keycodes = true,
  --     desc = "Get the current inline completion",
  --   })
  -- end
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure LSP keymaps",
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- I don't think this can happen but it's a wild world out there.
    if not client then
      return
    end

    on_attach(client, event.buf)
  end,
})

local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
  return hover({
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.4),
  })
end

local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
  return signature_help({
    max_height = math.floor(vim.o.lines * 0.5),
    max_width = math.floor(vim.o.columns * 0.4),
  })
end
