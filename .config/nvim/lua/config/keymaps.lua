-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function map(mode, shortcut, command, opts)
	local options = {
		noremap = true,
	}
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, shortcut, command, options)
end

local function tmap(shortcut, command, opts)
	map("t", shortcut, command, opts)
end

local function nmap(shortcut, command, opts)
	map("n", shortcut, command, opts)
end

local function imap(shortcut, command, opts)
	map("i", shortcut, command, opts)
end

local function vmap(shortcut, command, opts)
	map("v", shortcut, command, opts)
end

local function xmap(shortcut, command, opts)
	map("x", shortcut, command, opts)
end

nmap("<leader>ww", ":w<CR>", { desc = "Save file" })
nmap("<D-s>", ":w<CR>", { desc = "Save file" })

nmap("<leader>w<leader>", "<C-W>p", { desc = "Switch to previous window" })

-- Resize with arrows
-- LazyVim already has these mappings
-- nmap("<C-Left>", ":vertical resize -1<CR>")
-- nmap("<C-Right>", ":vertical resize +1<CR>")
-- nmap("<C-Up>", ":resize -1<CR>")
-- nmap("<C-Down>", ":resize +1<CR>")

nmap("J", "mzJ`z", { desc = "Delete line and join with next line" })

-- cursor should stay centered while scrolling
nmap("<C-d>", "<C-d>zz", { desc = "Scroll down half page" })
nmap("<C-u>", "<C-u>zz", { desc = "Scroll up half page" })

-- cursor should stay centered while scrolling through results
nmap("n", "nzzzv", { desc = "Move to next search result and keep window centered" })
nmap("N", "Nzzzv", { desc = "Move to previous search result and keep window centered" })

-- Useful mappings for managing tabs
nmap("<leader>tn", ":tabnew<cr>", { desc = "New tab" })
nmap("<leader>to", ":tabonly<cr>", { desc = "Close all other tabs" })
nmap("<leader>tc", ":tabclose<cr>", { desc = "Close tab" })
nmap("<leader>tm", ":tabmove<cr>", { desc = "Move tab" })
nmap("<leader>t<Leader>", ":tabnext #<cr>", { desc = "Switch to last tab" })
nmap("<leader>tl", ":tabnext<cr>", { desc = "Switch to next tab" })
nmap("<leader>th", ":tabprev<cr>", { desc = "Switch to previous tab" })
nmap("<Leader>1", ":tabnext 1<cr>", { desc = "Switch to tab 1" })
nmap("<Leader>2", ":tabnext 2<cr>", { desc = "Switch to tab 2" })
nmap("<Leader>3", ":tabnext 3<cr>", { desc = "Switch to tab 3" })
nmap("<Leader>4", ":tabnext 4<cr>", { desc = "Switch to tab 4" })
nmap("<Leader>5", ":tabnext 5<cr>", { desc = "Switch to tab 5" })
nmap("<Leader>6", ":tabnext 6<cr>", { desc = "Switch to tab 6" })
nmap("<Leader>7", ":tabnext 7<cr>", { desc = "Switch to tab 7" })
nmap("<Leader>8", ":tabnext 8<cr>", { desc = "Switch to tab 8" })
nmap("<Leader>9", ":tabnext 9<cr>", { desc = "Switch to tab 9" })
-- lazyvim uses this for moving between buffers instead which I quite like. need to find a better mapping. For now, tl and th would do
-- nmap("<s-l>", ":tabnext<cr>")
-- nmap("<s-h>", ":tabprev<cr>")

-- Reload config leader-ui-reload-config
nmap("<leader>urc", ":source $MYVIMRC<cr>", { desc = "Reload config" })

-- Toggle theme
nmap(
	"<leader>tt",
	":lua vim.o.background = vim.o.background == 'light' and 'dark' or 'light'<CR>",
	{ desc = "Toggle theme" }
)

-- Zen mode
nmap("<leader>z", ":lua require('zen-mode').toggle()<CR>", { desc = "Toggle zen mode" })

-- Telescope --
nmap(
	"<leader>j",
	'<cmd>lua require("telescope.builtin").git_files(require("telescope.themes").get_dropdown({ previewer = false, show_untracked = true }))<cr>',
	{ desc = "Find files in git repo" }
)
nmap(
	"<leader>,",
	'<cmd>lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false }))<cr>',
	{ desc = "Find buffers" }
)
nmap("<leader><tab>", '<cmd>lua require("telescope.builtin").buffers()<cr>', { desc = "Find buffers (with preview)" })
nmap(
	"<leader>sl",
	'<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>',
	{ desc = "Live grep args" }
)

-- harpoon
nmap("<leader>ma", '<cmd>lua require("harpoon.mark").add_file()<cr>', { desc = "Add file to harpoon" })
nmap("<leader>mc", '<cmd>lua require("harpoon.mark").clear_all()<cr>', { desc = "Clear all harpoon marks" })
nmap("<leader>mn", '<cmd>lua require("harpoon.ui").nav_next()<cr>', { desc = "Navigate to next harpoon mark" })
nmap("<leader>mp", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', { desc = "Navigate to previous harpoon mark" })
nmap("<leader>ml", "<cmd>Telescope harpoon marks<cr>", { desc = "List harpoon marks" })
nmap("<leader>mt", "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>", { desc = "Open terminal with harpoon" }) -- goes to the first tmux window

-- nmap("<leader>mc", "<cmd>delmarks A-Z0-9<cr>")
-- nmap("<leader>ml", '<cmd>lua require("telescope.builtin").marks()<cr>')

-- Insert --
-- Press jk fast to enter
imap("jk", "<ESC>", { desc = "Exit insert mode" })
imap("fd", "<ESC>", { desc = "Exit insert mode" })

-- Visual --

-- move text up and down
-- LazyVim already has these mappings with alt key
-- vmap("<c-k>", ":m .=<CR>==")
-- vmap("<c-j>", ":m .+<CR>==")

-- vmap("J", ":m '>+1<CR>gv=gv")
-- vmap("K", ":m '<-2<CR>gv=gv")

-- Terminal --
-- tmap("<Esc>", "<C-\\><C-n>")