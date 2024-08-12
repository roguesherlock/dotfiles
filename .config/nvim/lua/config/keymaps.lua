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
	vim.keymap.set(mode, shortcut, command, options)
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
-- nmap("<esc><esc>", ":w<CR>", { desc = "Save file" })
-- imap("<esc>", "<esc>:w<CR>", { desc = "Save file" })

-- nmap("<leader>w<leader>", "<C-W>p", { desc = "Switch to previous window" })

nmap("J", "mzJ`z", { desc = "Delete line and join with next line" })

-- cursor should stay centered while scrolling
nmap("<C-d>", "<C-d>zz", { desc = "Scroll down half page" })
nmap("<C-u>", "<C-u>zz", { desc = "Scroll up half page" })

-- cursor should stay centered while scrolling through results
nmap("n", "nzzzv", { desc = "Move to next search result and keep window centered" })
nmap("N", "Nzzzv", { desc = "Move to previous search result and keep window centered" })

-- Useful mappings for managing tabs
-- lazy vim has tabs mapping with <leader><tab>
-- nmap("<leader>tn", ":tabnew<cr>", { desc = "New tab" })
-- nmap("<leader>to", ":tabonly<cr>", { desc = "Close all other tabs" })
-- nmap("<leader>tc", ":tabclose<cr>", { desc = "Close tab" })
-- nmap("<leader>tm", ":tabmove<cr>", { desc = "Move tab" })
-- nmap("<leader>t<Leader>", ":tabnext #<cr>", { desc = "Switch to last tab" })
-- nmap("<leader>tl", ":tabnext<cr>", { desc = "Switch to next tab" })
-- nmap("<leader>th", ":tabprev<cr>", { desc = "Switch to previous tab" })
-- nmap("<Leader>1", ":tabnext 1<cr>", { desc = "Switch to tab 1" })
-- nmap("<Leader>2", ":tabnext 2<cr>", { desc = "Switch to tab 2" })
-- nmap("<Leader>3", ":tabnext 3<cr>", { desc = "Switch to tab 3" })
-- nmap("<Leader>4", ":tabnext 4<cr>", { desc = "Switch to tab 4" })
-- nmap("<Leader>5", ":tabnext 5<cr>", { desc = "Switch to tab 5" })
-- nmap("<Leader>6", ":tabnext 6<cr>", { desc = "Switch to tab 6" })
-- nmap("<Leader>7", ":tabnext 7<cr>", { desc = "Switch to tab 7" })
-- nmap("<Leader>8", ":tabnext 8<cr>", { desc = "Switch to tab 8" })
-- nmap("<Leader>9", ":tabnext 9<cr>", { desc = "Switch to tab 9" })

-- Reload config leader-ui-reload-config
-- nmap("<leader>urc", ":source $MYVIMRC<cr>", { desc = "Reload config" })

-- Toggle theme
nmap("<leader>tt", function()
	local colorscheme = require("user.colorscheme")
	local is_light = vim.o.background == "light"
	if is_light then
		colorscheme.set_colorscheme(false)
	else
		colorscheme.set_colorscheme(true)
	end
end, { desc = "Toggle theme" })

nmap("<leader>tg", function()
	if string.find(vim.g.colors_name, "gruvbox") then
		require("user.colorscheme").set_from_os()
	else
		vim.cmd.colorscheme("gruvbox-material")
	end
end, { desc = "Toggle gruvbox-material colorscheme" })

nmap("<leader>tm", function()
	if string.find(vim.g.colors_name, "modus") then
		require("user.colorscheme").set_from_os()
	else
		vim.cmd.colorscheme("modus")
	end
end, { desc = "Toggle modus colorscheme" })
-- Telescope --
-- nmap(
-- 	"<leader>j",
-- 	'<cmd>lua require("telescope.builtin").git_files(require("telescope.themes").get_dropdown({ previewer = false, show_untracked = true }))<cr>',
-- 	{ desc = "Find files in git repo" }
-- )
-- nmap(
-- 	"<leader>,",
-- 	'<cmd>lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false }))<cr>',
-- 	{ desc = "Find buffers" }
-- )
-- nmap("<leader><tab>", '<cmd>lua require("telescope.builtin").buffers()<cr>', { desc = "Find buffers (with preview)" })
-- nmap("<leader><leader>", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "Switch Buffer" })
-- nmap("<leader><space>", "<cmd> Telescope smart_open theme=ivy <cr>", { desc = "Find Files" })
-- nmap("<leader>fb", "<cmd> Telescope buffers theme=ivy <cr>", { desc = "Find buffers (with preview)" })
-- nmap("<leader><leader>", "<cmd> Telescope buffers theme=ivy <cr>", { desc = "Find buffers (with preview)" })

-- Insert --
-- Press jk fast to enter
-- I just use escape now (which is mapped to caps lock key)
-- imap("jk", "<ESC>", { desc = "Exit insert mode" })
-- imap("fd", "<ESC>", { desc = "Exit insert mode" })

-- Visual --

-- paste without overwriting register
vmap("p", '"_dP')

-- move text up and down
-- LazyVim already has these mappings with alt key
-- vmap("<c-k>", ":m .=<CR>==")
-- vmap("<c-j>", ":m .+<CR>==")

-- vmap("J", ":m '>+1<CR>gv=gv")
-- vmap("K", ":m '<-2<CR>gv=gv")

-- Terminal --
-- tmap("<Esc>", "<C-\\><C-n>")

-- Trouble --
-- nmap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Toggle trouble quickfix list" })

-- Fold --
nmap("<space>", "za", { desc = "Toggle fold" })

-- Resize --
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

local function open_in_gh()
	local user_repo = vim.fn.system("git config --get remote.origin.url"):match("git@github%.com:([%w%d-/]+)%.git")
	if not user_repo then
		user_repo = vim.fn.system("git config --get remote.origin.url"):match("https://github%.com/([%w%d-/]+)%.git")
	end

	if user_repo then
		local branch = vim.fn.system("git branch --show-current"):gsub("%s*$", "")
		local file = vim.fn.expand("%:p:~:.")
		local line = vim.api.nvim_win_get_cursor(0)[1]
		local gh_url = "https://github.com/" .. user_repo .. "/blob/" .. branch .. "/" .. file .. "#L" .. line

		vim.fn.system("open " .. gh_url)
	end
end

nmap("<leader>gl", open_in_gh, { desc = "Open file in github" })
