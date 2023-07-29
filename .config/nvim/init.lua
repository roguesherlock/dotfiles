vim.g.mapleader = ","
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "lazy")
if not status_ok then
  return
end

if vim.fn.exists("g:vscode") then
  require("lazy").setup("vscode.plugins")
  require("vscode.keymaps")
else
  require("lazy").setup("plugins")
  require "user.keymaps"
end

