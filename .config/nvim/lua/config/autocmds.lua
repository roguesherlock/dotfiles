-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- [[ Autosave ]] --
vim.api.nvim_create_autocmd({
  "TextChanged",
  "FocusLost",
  "BufEnter",
  -- "InsertLeave"
}, {
  pattern = {
    "*"
  },
  callback = function()
    vim.cmd([[ silent! update ]])
  end
})

