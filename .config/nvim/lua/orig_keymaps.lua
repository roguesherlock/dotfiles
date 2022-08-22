-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

require('../helper_functions')

-- ESC key comes out of terminal mode when in terminal
tmap("<Esc>", "<C-\\><C-n>")


-- use ctrl-j,k,l,h to move between windows
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")
nmap("<C-h>", "<C-w>h")

-- resize using arrows keys instead
nmap("<Left>", ":vertical resize -1<CR>")
nmap("<Right>", ":vertical resize +1<CR>")
nmap("<Up>", ":resize -1<CR>")
nmap("<Down>", ":resize +1<CR>")


-- quit vim
nmap("<leader>qq", ":wqa<cr>")

-- edit vimrc/fish and load vimrc bindings
nmap("<leader>ev", ":vsp $MYVIMRC<CR>")
nmap("<leader>ef", ":vsp ~/.config/fish/config.fish<CR>")
nmap("<leader>sv", ":source $MYVIMRC<CR>")

-- save session
nmap("<leader>sw", ":ToggleWorkspace<CR>")




--[[
 		normal mode
--]]
nmap('n', 'nzzzv')
nmap('N','Nzzzv')

-- space open/closes folds
nmap("<space>", "za")

-- move vertically by visual line
nmap('j', 'gj')
nmap('k', 'gk')

-- move to beginning/end of line
nmap('B', '^')
nmap('E', '$')

-- toggle gundo
-- nmap('<leader>u', ':GundoToggle<CR>')

-- quit vim
nmap('<leader>qq', ':wqa<cr>')

-- Toggle paste mode on and off
nmap('<leader>pp', ':setlocal paste!<cr>')

-- Useful mappings for managing tabs
nmap('<leader>tn', ':tabnew<cr>')
nmap('<leader>to', ':tabonly<cr>')
nmap('<leader>tc', ':tabclose<cr>')
nmap('<leader>tm', ':tabmove<cr>')
nmap('<leader>t<Leader>', ':tabnext<cr>')

-- remove trailing whitespace
nmap('<Leader>rtw', ':%s/\\s\\+$//e<CR>')

-- map goyovim
-- nmap('<leader>z', ':Goyo<cr>')

-- Copy-Paste
nmap('<Leader>y', '"*y')
nmap('<Leader>p', '"*p')
nmap('<Leader>Y', '"+y')
nmap('<Leader>P', '"+p')

-- Easier buffer switching
nmap('<Leader>bl', ':ls<CR>:b')
nmap('<Leader>bc', ':bd<CR>')
nmap('<Leader><Leader>', '<C-^>')
nmap('<Leader><S-Tab>', ':bn<CR>')
nmap('<Leader><Tab>', ':bp<CR>')
nmap('<Leader>1', ':1b<CR>')
nmap('<Leader>2', ':2b<CR>')
nmap('<Leader>3', ':3b<CR>')
nmap('<Leader>4', ':4b<CR>')
nmap('<Leader>5', ':5b<CR>')
nmap('<Leader>6', ':6b<CR>')
nmap('<Leader>7', ':7b<CR>')
nmap('<Leader>8', ':8b<CR>')
nmap('<Leader>9', ':9b<CR>')



-- toggle ignore case
nmap('<leader>ic', ':set ignorecase<CR>')

-- turn highlight off
nmap("<leader><space>", ":nohlsearch<CR>")

-- Turn on limelight
-- nmap('<Leader>ll', ':Limelight!!<cr>')

-- Toggle Ditto
-- nmap('<leader>di', '<Plug>ToggleDitto')


-- telescope bindings
-- nmap('<leader>j', '<cmd>lua require("telescope.builtin").find_files()<cr>')
-- nmap('<leader>jf', '<cmd>lua require("telescope.builtin").find_files()<cr>')
nmap('<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
nmap('<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
nmap('<leader>fp', '<cmd>lua require("telescope.builtin").projects()<cr>')
nmap('<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
-- nmap('<leader>jb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
nmap('<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')


-- trouble bindings
nmap("<leader>xx", "<cmd>Trouble<cr>")
nmap("<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
nmap("<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
nmap("<leader>xl", "<cmd>Trouble loclist<cr>")
nmap("<leader>xq", "<cmd>Trouble quickfix<cr>")
nmap("gR", "<cmd>Trouble lsp_references<cr>")


-- anyjump bindings
vim.g.any_jump_disable_default_keybindings = 1

-- Jump to definition under cursor
nmap("<leader>jd", ":AnyJump<CR>")

-- jump to selected text in visual mode
vmap("<leader>jd", ":AnyJumpVisual<CR>")

-- open previous opened file (after jump)
nmap("<leader>opf", ":AnyJumpBack<CR>")

--  open last closed search window again
nmap("<leader>ols", ":AnyJumpLastResults<CR>")



--[[
 		insert mode
--]]
imap('fd', '<ESC>')
imap('jk', '<ESC>')

--[[
 		visual mode
--]]
