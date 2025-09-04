-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("user-highlight-yank", { clear = true }),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- [[ Autosave ]] --
vim.api.nvim_create_autocmd({
  "FocusLost",
  -- 'InsertLeave',
  "BufEnter",
  "BufLeave",
}, {
  pattern = {
    "*",
  },
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command("silent! update")
    end
  end,
})

-- [[ Check if we need to reload buffer ]] --
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Close certain filetypes with 'q'
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
  pattern = {
    "qf", -- quickfix list
    "help", -- help files
    "man", -- man pages
    "notify", -- notifications
    "lspinfo", -- lsp info
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
    "mini.pick", -- mini.pick
    "gitsigns*", -- gitsigns diff buffers
    "grug-far",
    "grug-far-history",
    "grug-far-help",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
    "gitsigns-blame",
    "diffview",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    -- vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  desc = "Set underline to undercurls",
  group = vim.api.nvim_create_augroup("user-set-undercurls", { clear = true }),
  callback = function()
    vim.cmd([[ highlight Underlined cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight @markup.underline cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineOk cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineHint cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineInfo cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineWarn cterm=undercurl gui=undercurl ]])
    vim.cmd([[ highlight DiagnosticUnderlineError cterm=undercurl gui=undercurl ]])
  end,
})
