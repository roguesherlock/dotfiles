-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
function map(mode, shortcut, command, opts)
  local options = {
    noremap = true
  }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

function tmap(shortcut, command, opts)
  map("t", shortcut, command, opts)
end

function nmap(shortcut, command, opts)
  map("n", shortcut, command, opts)
end

function imap(shortcut, command, opts)
  map("i", shortcut, command, opts)
end

function vmap(shortcut, command, opts)
  map("v", shortcut, command, opts)
end

function xmap(shortcut, command, opts)
  map("x", shortcut, command, opts)
end

nmap("<D-s>", ":w<CR>")

-- Resize with arrows
nmap("<C-Left>", ":vertical resize -1<CR>")
nmap("<C-Right>", ":vertical resize +1<CR>")
nmap("<C-Up>", ":resize -1<CR>")
nmap("<C-Down>", ":resize +1<CR>")

nmap("J", "mzJ`z")

-- cursor should stay centered while scrolling
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

-- cursor should stay centered while scrolling through results
nmap("n", "nzzzv")
nmap("N", "Nzzzv")

-- Useful mappings for managing tabs
nmap("<leader>tn", ":tabnew<cr>")
nmap("<leader>to", ":tabonly<cr>")
nmap("<leader>tc", ":tabclose<cr>")
nmap("<leader>tm", ":tabmove<cr>")
nmap("<leader>t<Leader>", ":tabnext #<cr>")
nmap("<s-l>", ":tabnext<cr>")
nmap("<s-h>", ":tabprev<cr>")

-- Zen mode
nmap("<leader>z", ":lua require('zen-mode').toggle()<CR>")

-- Telescope --
nmap("<leader>j",
     "<cmd>lua require(\"telescope.builtin\").git_files(require(\"telescope.themes\").get_dropdown({ previewer = false, show_untracked = true }))<cr>")
nmap("<leader><TAB>",
     "<cmd>lua require(\"telescope.builtin\").buffers(require(\"telescope.themes\").get_dropdown({ previewer = false }))<cr>")
nmap("<leader>sl",
     "<cmd>lua require(\"telescope\").extensions.live_grep_args.live_grep_args()<cr>")

-- harpoon
nmap("<leader>ma", "<cmd>lua require(\"harpoon.mark\").add_file()<cr>")
nmap("<leader>mc", "<cmd>lua require(\"harpoon.mark\").clear_all()<cr>")
nmap("<leader>mn", "<cmd>lua require(\"harpoon.ui\").nav_next()<cr>")
nmap("<leader>mp", "<cmd>lua require(\"harpoon.ui\").nav_prev()<cr>")
nmap("<leader>ml", "<cmd>Telescope harpoon marks<cr>")
nmap("<leader>mt", "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>") -- goes to the first tmux window

-- nmap("<leader>mc", "<cmd>delmarks A-Z0-9<cr>")
-- nmap("<leader>ml", '<cmd>lua require("telescope.builtin").marks()<cr>')

-- Insert --
-- Press jk fast to enter
imap("jk", "<ESC>")
imap("fd", "<ESC>")

-- Visual --

-- move text up and down
vmap("<c-k>", ":m .=<CR>==")
vmap("<c-j>", ":m .+<CR>==")

vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")

-- Terminal --
tmap("<Esc>", "<C-\\><C-n>")
