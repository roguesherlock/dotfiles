-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

require("user.helper_functions")

--Remap , as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")
nmap("<C-h>", "<C-w>h")

nmap("Q", "<nop>")

-- move windows around
nmap("<C-S-j>", "<C-w>J")
nmap("<C-S-k>", "<C-w>K")
nmap("<C-S-l>", "<C-w>L")
nmap("<C-S-h>", "<C-w>H")

--save
nmap("<leader>w", ":w<CR>")
nmap("<d-s>", ":w<CR>")

-- Resize with arrows
nmap("<C-Left>", ":vertical resize -1<CR>")
nmap("<C-Right>", ":vertical resize +1<CR>")
nmap("<C-Up>", ":resize -1<CR>")
nmap("<C-Down>", ":resize +1<CR>")

-- Navigate buffers
--[[ nmap("<S-l>", ":bnext<CR>") ]]
--[[ nmap("<S-h>", ":bprevious<CR>") ]]

-- move text up and down
vmap("<c-k>", ":m .=<CR>==")
vmap("<c-j>", ":m .+<CR>==")

vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")

-- Clear highlights
nmap("<leader><space>", "<cmd>nohlsearch<CR>")

nmap("J", "mzJ`z")
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

nmap("n", "nzzzv")
nmap("N", "Nzzzv")

nmap("<leader>mv", ":edit $MYVIMRC<cr>")
nmap("<leader>sv", ":source $MYVIMRC<cr>")

-- space open/closes folds
-- nmap("<space>", "za")

-- move vertically by visual line
nmap("j", "gj")
nmap("k", "gk")

-- move to beginning/end of line
nmap("B", "^")
nmap("E", "$")

-- Better paste
vmap("p", '"_dP')
xmap("<leader>p", [["_dP]])

-- quit vim
nmap("<leader>qq", "<cmd>wqall<cr>")
nmap("<C-S-q>", "<cmd>q<CR>")

-- Toggle paste mode on and off
nmap("<leader>pp", ":setlocal paste!<cr>")

-- Toggle terminal
--[[ nmap('<c-\\>', '<CMD>lua require("FTerm").toggle()<CR>') ]]
--[[ tmap('<c-\\>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>') ]]

-- Useful mappings for managing tabs
nmap("<leader>tn", ":tabnew<cr>")
nmap("<leader>to", ":tabonly<cr>")
nmap("<leader>tc", ":tabclose<cr>")
nmap("<leader>tm", ":tabmove<cr>")
nmap("<leader>t<Leader>", ":tabnext #<cr>")
nmap("<s-l>", ":tabnext<cr>")
nmap("<s-h>", ":tabprev<cr>")

-- remove trailing whitespace
nmap("<Leader>rtw", ":%s/\\s\\+$//e<CR>")

-- Copy-Paste

-- Easier buffer switching
--[[ nmap('<Leader>bl', ':ls<CR>:b') ]]
nmap("<leader>bqq", "<cmd>:%bd|e#<CR>")
nmap("<leader>bc", "<cmd>Bdelete!<CR>")
nmap("<S-q>", "<cmd>Bdelete!<CR>")
nmap("<Leader><Leader>", "<C-^>")
nmap("<Leader><S-Tab>", ":bn<CR>")
--[[ nmap("<Leader><Tab>", ":bp<CR>") ]]
nmap("<Leader>1", ":1b<CR>")
nmap("<Leader>2", ":2b<CR>")
nmap("<Leader>3", ":3b<CR>")
nmap("<Leader>4", ":4b<CR>")
nmap("<Leader>5", ":5b<CR>")
nmap("<Leader>6", ":6b<CR>")
nmap("<Leader>7", ":7b<CR>")
nmap("<Leader>8", ":8b<CR>")
nmap("<Leader>9", ":9b<CR>")

-- diffview
nmap("<leader>dv", "<cmd>DiffviewOpen<cr>")

-- Insert --
-- Press jk fast to enter
imap("jk", "<ESC>")
imap("fd", "<ESC>")

-- Visual --
-- Stay in indent mode
vmap("<", "<gv")
vmap(">", ">gv")

-- Plugins --

-- NvimTree
nmap("<leader>e", ":NvimTreeToggle<CR>")

-- Zen mode
nmap("<leader>z", ":lua require('zen-mode').toggle()<CR>")

-- Telescope
nmap(
	"<leader>j",
	'<cmd>lua require("telescope.builtin").git_files(require("telescope.themes").get_dropdown({ previewer = false, show_untracked = true }))<cr>'
)
nmap("<leader>g", '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>')
nmap(
	"<leader><TAB>",
	'<cmd>lua require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false }))<cr>'
)
nmap("<leader>bl", '<cmd>lua require("telescope.builtin").buffers()<cr>')
nmap(
	"<leader>ff",
	'<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({ previewer = false }))<cr>'
)
nmap("<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
nmap("<leader>fp", "<cmd>Telescope workspaces<cr>")
--[[ nmap("<leader>fp", '<cmd>lua require("telescope").extensions.project.project{}<cr>') ]]
--[[ nmap('<leader>fp', '<cmd>Telescope projects<cr>') ]]
nmap("<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>')
nmap("<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<cr>')
nmap("<leader>fk", '<cmd>lua require("telescope.builtin").keymaps()<cr>')
nmap("<leader>fm", '<cmd>lua require("telescope.builtin").marks()<cr>')
--[[ nmap('<leader>fm', ':Telescope harpoon marks<cr>'); ]]
nmap("<leader>fc", '<cmd>lua require("telescope.builtin").commands()<cr>')
nmap("<leader>fj", '<cmd>lua require("telescope.builtin").jumplist()<cr>')

-- harpoon
--[[ nmap('<leader>ma', ':lua require("harpoon.mark").add_file()<cr>'); ]]
--[[ nmap('<leader>mc', ':lua require("harpoon.mark").clear_all()<cr>'); ]]
--[[ nmap('<leader>ml', ':Telescope harpoon marks<cr>'); ]]
nmap("<leader>mc", "<cmd>delmarks A-Z0-9<cr>")
nmap("<leader>ml", '<cmd>lua require("telescope.builtin").marks()<cr>')

-- set the split window sizes to be equal
nmap("<leader>se", "<cmd>FocusEqualise<cr>")

-- Git
nmap("<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>")

-- Comment
-- nmap("<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>")
-- xmap("<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- DAP
nmap("<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
nmap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
nmap("<leader>di", "<cmd>lua require'dap'.step_into()<cr>")
nmap("<leader>do", "<cmd>lua require'dap'.step_over()<cr>")
nmap("<leader>dO", "<cmd>lua require'dap'.step_out()<cr>")
nmap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
nmap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
nmap("<leader>du", "<cmd>lua require'dapui'.toggle()<cr>")
nmap("<leader>dt", "<cmd>lua require'dap'.terminate()<cr>")

-- trouble bindings
nmap("<leader>xx", "<cmd>Trouble<cr>")
nmap("<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
nmap("<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
nmap("<leader>xl", "<cmd>Trouble loclist<cr>")
nmap("<leader>xq", "<cmd>Trouble quickfix<cr>")
nmap("gR", "<cmd>Trouble lsp_references<cr>")

-- workspaces
nmap("<leader>sw", "<cmd>WorkspacesAdd<cr>")
nmap("<leader>lw", "<cmd>WorkspacesLoad<cr>")

-- ESC key comes out of terminal mode when in terminal
tmap("<Esc>", "<C-\\><C-n>")
