-- theme
vim.cmd[[colorscheme gruvbox]]

vim.cmd[[filetype plugin on]]
-- load filetype-specific indent files
vim.cmd[[filetype indent on]]
vim.o.relativenumber = true
vim.o.cursorline = true      -- highlight current line

-- Spaces and tabs
vim.bo.tabstop = 2				-- number of visual spaces per TAB
vim.bo.softtabstop = 2   -- number of spaces in tab when editing
vim.o.expandtab = true  -- tabs are spaces
vim.bo.shiftwidth = 2    -- when indenting with '>', use 4 spaces

-- show command in bottom bar
vim.o.showcmd = true

-- visual autocomplete for command menu
vim.o.wildmenu = true

-- redraw only when we need to.
-- vim.o.lazyredraw = true

-- highlight matching [{()}]
-- vim.o.showmatch = true

-- Autoread when a file is changed from the outside
vim.o.autoread = true


-- Maintain undo history between sessions
vim.o.undofile = true
if not (vim.fn.isdirectory("$HOME" .. "/.nvim/undodir")) then
	vim.cmd([[ silent call mkdir($HOME . "/.nvim/undodir", "p") ]])
end
vim.o.undodir="~/.vim/undodir"

-- Show symbols for tabs and trailing whitespace
vim.o.list = false
vim.o.listchars="tab:▸\\ ,trail:•,extends:»,precedes:«"


-- enable folding
-- vim.o.foldenable = true

-- open most folds by default
-- vim.o.foldlevelstart = 10

--  10 nested fold max
-- vim.o.foldnestmax = 10

-- fold based on indent level
-- set foldmethod=indent


-- backups
vim.o.backup = true
vim.o.backupdir = "~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp"
vim.o.backupskip = "/tmp/*,/private/tmp/*"
vim.o.directory = "~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp"
vim.o.writebackup = true
