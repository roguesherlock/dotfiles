-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = {
  silent = true
}

require("user.helper_functions")

-- Remap , as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
