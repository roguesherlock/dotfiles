" Section Misc {{{
set laststatus=2
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
" }}}


" Section Spaces and Tabs {{{
set tabstop=4           " number of visual spaces per TAB
set softtabstop=4       " number of spaces in tab when editing
set expandtab           " tabs are spaces
set shiftwidth=4        " when indenting with '>', use 4 spaces

" }}}


" Section UI Config {{{

set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]

" }}}


" Section Searching {{{

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" }}}


" Section Folding {{{

set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
                        " space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level

" }}}


" Section Movement {{{

" mouse is annoying in this land
set mouse=r


" resize using arrows keys instead
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>

" Disable arrow keys completely in Insert Mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" }}}


" Section Leader Shortcuts {{{

let mapleader=","       " leader is comma

" jk is escape
inoremap jk <esc>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" edit vimrc/fish and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ef :vsp ~/.config/omf/init.fish<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :mksession<CR>

" Vim Indent guide
nnoremap <leader>ig :IndentLinesToggle<CR>

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" open CtrlP
map <leader>j :CtrlP<CR>

" Vim Grepper shortcuts

" search in entire project
nnoremap <Leader>fp :Grepper<Space>-query<Space>
" search in entire buffer
nnoremap <Leader>fb :Grepper<Space>-buffers<Space>-query<Space>-<Space>


" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>t<leader> :tabnext<cr>

" Fast saving
nmap <leader>w :w!<cr>

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" map goyovim
nnoremap <silent> <leader>z :Goyo<cr>

" Copy-Paste
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p


" Section goyovim {{{

" goyo vim config
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2

"}}}


" Section deoplete {{{
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"}}}


" Section ale {{{
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
"}}}


" Section CtrlP {{{

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" }}}


" Section Vim Sneak {{{

" Vim Sneak settings

let g:sneak#s_next = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

" }}}


" Section IndentLine {{{

" Vim IndentLine settings

let g:indentLine_enabled = 0
let g:indentLine_char = ">"

" }}}


" Section VimPlug Config {{{

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-easy-align'  " everything to do with alignments
Plug 'junegunn/vim-github-dashboard'    " shows github  events
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " sidebar

Plug 'tpope/vim-fugitive'       " git wrapper
Plug 'tpope/vim-surround'       " allow operations on surroundings({''}) in pairs
Plug 'tpope/vim-commentary'     " comments
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }    " fuzzy finder
Plug 'vim-airline/vim-airline'  " status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'        " distraction free mode
Plug 'mhinz/vim-grepper'        " search in files
Plug 'christoomey/vim-tmux-navigator'   " bindings for navigation when launch from tmux
Plug 'nathanaelkane/vim-indent-guides'  " indent guides
Plug 'airblade/vim-gitgutter'   " shows git diff for each line and other goodies
Plug 'Shougo/denite.nvim'       " unite interfaces
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " auto complete
" Plug 'valloric/youcompleteme'     " autocomplete
" Plug 'scrooloose/syntastic'     " linter
Plug 'w0rp/ale'     " linter
Plug 'justinmk/vim-sneak'       " efficient moving around
Plug 'Yggdroot/indentLine'      " indent guides
Plug '907th/vim-auto-save'      " autosave files
Plug 'mattn/emmet-vim/'         " html css 

" Themes
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'

" Add plugins to &runtimepath
call plug#end()

" }}}


" Section Vim-easy-align {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"}}}


" Section Vim Airline Config {{{

let g:airline#extensions#tabline#enabled=1

" airline fonts
let g:airline_powerline_fonts = 1

" }}}


" Section Colors and GUI config {{{

syntax enable               " enable syntax processing

if has('gui_running')

    set guioptions -=m           " no menubar
    set guioptions -=T           " no toolbar
    set guioptions -=r           " no scrollbar

    set lines=60 columns=108 linespace=0

    set guifont=Fira\ Code\ 16

else
    " awesome colorscheme
    set termguicolors
endif

color Dracula

" }}}


" Section Backups {{{

    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup

" }}}


" Section Custom Functions {{{

" Arduino status bar info
" my_file.ino [arduino:avr:uno] [arduino:usbtinyisp] (/dev/ttyACM0:9600)
" function! b:MyStatusLine()
"   let port = arduino#GetPort()
"   let line = '%f [' . g:arduino_board . '] [' . g:arduino_programmer . ']'
"   if !empty(port)
"     let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
"   endif
"   return line
" endfunction
" setl statusline=%!b:MyStatusLine()


" toggle between number and relativenumber

function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc


" }}}


set foldmethod=marker
set foldlevel=0
set modelines=1

" vim:foldmethod=marker:foldlevel=0

