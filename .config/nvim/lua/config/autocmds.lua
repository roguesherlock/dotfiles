-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- [[ Autosave ]] --
vim.api.nvim_create_autocmd({
  "FocusLost",
  -- 'InsertLeave',
  -- "BufEnter",
  -- "BufLeave",
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
