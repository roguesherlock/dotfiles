" Section Misc {{{

set laststatus=2
set autoread                " Autoread when a file is changed from the outside

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" Remove delay after pressing escape and clearing the visual selection
set timeoutlen=1000 ttimeoutlen=0

" Turn on spellcheck in markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" ESC key comes out of terminal mode when in terminal
tnoremap <Esc> <C-\><C-n>

" Incremental search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Use tab to jump to closing/opening matches
"nnoremap <tab> %

" " Jump to end or beginning in insert mode
" inoremap <C-Right> <esc>A
" inoremap <C-Left> <esc>I
" }}}


" Section Spaces and Tabs {{{

set tabstop=2           " number of visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set expandtab           " tabs are spaces
set shiftwidth=2        " when indenting with '>', use 4 spaces

" Show symbols for tabs and trailing whitespace
set list!
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«

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
nnoremap <leader>ef :vsp ~/.config/fish/config.fish<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :ToggleWorkspace<CR>


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

" Easier buffer switching
nnoremap <Leader>l :ls<CR>:b
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>

" }}}


" Section Worspace {{{

" vim-workspace config
let g:workspace_autosave_always = 1

"}}}


" Section goyovim {{{

" goyo vim config
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2

"}}}


" Section deoplete {{{
"
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
" let g:indentLine_char = ">"

" }}}


" Section VimPlug Config {{{

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/vim-easy-align'              " everything to do with alignments
Plug 'junegunn/vim-github-dashboard'        " shows github  events
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " sidebar
Plug 'tpope/vim-fugitive'                   " git wrapper
Plug 'tpope/vim-surround'                   " allow operations on surroundings({''}) in pairs
Plug 'tpope/vim-commentary'                 " comments
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }    " fuzzy finder
Plug 'vim-airline/vim-airline'              " status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'                    " distraction free mode
Plug 'mhinz/vim-grepper'                    " search in files
Plug 'airblade/vim-gitgutter'               " shows git diff for each line and other goodies
" Plug 'Shougo/denite.nvim'                   " unite interfaces
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }   " auto complete
Plug 'justinmk/vim-sneak'                   " efficient moving around
Plug '907th/vim-auto-save'                  " autosave files
Plug 'mattn/emmet-vim/'                     " html css
Plug 'HerringtonDarkholme/yats.vim'         " typesscript syntax
Plug 'othree/yajs.vim'                      " javascript syntax
Plug 'othree/html5.vim'                     " html
Plug 'rizzatti/dash.vim'                    " Dash
Plug 'elixir-editors/vim-elixir'            " elixir
" Plug 'slashmili/alchemist.vim'              " elixir
Plug 'SirVer/ultisnips'                     " Autocomplete snippets
Plug 'honza/vim-snippets'                   " LOADS of snippets
Plug 'danro/rename.vim'                     " Easy file renaming
Plug 'Lokaltog/vim-easymotion'              " Easily move around text
Plug 'ConradIrwin/vim-bracketed-paste'      " No more se paste
Plug 'Raimondi/delimitMate'                 " Autoclose parens and quotes
Plug 'plasticboy/vim-markdown'              " Markdown highlighting
Plug 'AndrewRadev/splitjoin.vim'            " gJ and gS to join and split blocks
Plug 'AndrewRadev/linediff.vim'             " Diff 2 blocks of text
Plug 'terryma/vim-expand-region'            " Expand(v)/shrink(C-v) vis selection
Plug 'shinokada/dragvisuals.vim'            " Drag visual selections
Plug 'nixon/vim-vmath'                      " Math summary for visual selections
Plug 'Yggdroot/indentLine'                  " Shows vertical indentation lines
Plug 'jeetsukumaran/vim-indentwise'         " Movements using indentation
Plug 'Elzr/Vim-json'                        " Fine grained syntax highlighting for JSON
Plug 'haya14busa/incsearch.vim'             " Incremental searches
Plug 'zerowidth/vim-copy-as-rtf'            " Copy syntax highlighted text
Plug 'isRuslan/vim-es6'                     " Syntax and snippets for ES6
Plug 'pangloss/vim-javascript'              " Syntax highlighting for JS
Plug 'neomake/neomake'                      " Async filetype make for neovim
Plug 'janko-m/vim-test'                     " Async tests
Plug 'mhinz/vim-startify'                   " Awesome Start Screen
Plug 'thaerkh/vim-workspace'                " Workspace
Plug 'ervandew/supertab'                    " For Tab Completion

" Themes
" Plug 'dracula/vim', {'as':'dracula'}
" Plug 'nightsense/snow'
Plug 'morhetz/gruvbox'
" Plug 'nightsense/seabird'

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

let g:airline_theme='gruvbox'

" airline fonts
let g:airline_powerline_fonts = 1

" }}}


" Section UltiSnips {{{
" Use tab for snippet expansion
" let g:UltiSnipsExpandTrigger="<Tab>"
" let g:UltiSnipsJumpForwardTrigger="<Tab>"
" let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
" }}}


" Section Colors and GUI config {{{

syntax enable               " enable syntax processing

if has('gui_running')

    set guioptions -=m           " no menubar
    set guioptions -=T           " no toolbar
    set guioptions -=r           " no scrollbar

    set lines=60 columns=108 linespace=0

    set guifont=Fira\ Code\ Retina\ 16

endif

if (has("termguicolors"))
    set termguicolors
endif

"Draw a dark grey ruler at 80 chars
set colorcolumn=80
highlight ColorColumn ctermbg=234

set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox

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


