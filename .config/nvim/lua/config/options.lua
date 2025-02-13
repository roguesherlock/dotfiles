-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.g.trouble_lualine = false

if vim.g.neovide then
  vim.o.guifont = "Jetbrains Mono:h13"
  vim.opt.linespace = 2
  vim.g.neovide_refresh_rate = 120
end
