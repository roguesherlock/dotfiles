
" Section Misc {{{
set laststatus=2
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

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :mksession<CR>

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" open ag.vim
nnoremap <leader>a :Ag

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

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

" goyo vim config
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

" }}}


" Section CtrlP {{{

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" }}}


" Section VimPlug Config {{{

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" TypeScript
Plug 'https://github.com/leafgarland/typescript-vim.git'

" Group dependencies, vim-snippets depends on ultisnips
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'valloric/youcompleteme'
Plug 'junegunn/goyo.vim'
Plug 'altercation/vim-colors-solarized'
" Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'stevearc/vim-arduino'
Plug 'christoomey/vim-tmux-navigator'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'chriskempson/base16-vim'
Plug 'rakr/vim-two-firewatch'
Plug 'fxn/vim-monochrome'
" Plug 'dracula/vim'
" Plug 'https://bitbucket.org/johannes/arduino-vim-syntax'
" Plug 'jplaut/vim-arduino-ino'
" Plug '4Evergreen4/vim-hardy'

" Add plugins to &runtimepath
call plug#end()

" }}}


" Section Vim-easy-align {{{

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"}}}


" Section Colors and GUI config {{{

syntax enable               " enable syntax processing


if has('gui_running')
    let g:hybrid_custom_term_colors = 1
    set background=dark
    let g:two_firewatch_italics=1


    " awesome colorscheme
    colorscheme two-firewatch
    let g:airline_theme='twofirewatch'
    " colorscheme dracula
    set guioptions -=m          " no menubar
    set guioptions-=T           " no toolbar
    set guioptions-=r           " no scrollbar

    " set lines=60 columns=108 linespace=0
    " set guifont=Fantasque\ Sans\ Mono\ 16

    set guifont=Iosevka\ Term\ 16
else
    colorscheme monochrome
endif
" }}}


" Section Tmux {{{

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" }}}


" " Section Autogroups {{{

" augroup configgroup
"     autocmd!
"     autocmd VimEnter * highlight clear SignColumn
"     autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
"                 \:call <SID>StripTrailingWhitespaces()
"     autocmd FileType java setlocal noexpandtab
"     autocmd FileType java setlocal list
"     autocmd FileType java setlocal listchars=tab:+\ ,eol:-
"     autocmd FileType java setlocal formatprg=par\ -w80\ -T4
"     autocmd FileType php setlocal expandtab
"     autocmd FileType php setlocal list
"     autocmd FileType php setlocal listchars=tab:+\ ,eol:-
"     autocmd FileType php setlocal formatprg=par\ -w80\ -T4
"     autocmd FileType ruby setlocal tabstop=2
"     autocmd FileType ruby setlocal shiftwidth=2
"     autocmd FileType ruby setlocal softtabstop=2
"     autocmd FileType ruby setlocal commentstring=#\ %s
"     autocmd FileType python setlocal commentstring=#\ %s
"     autocmd BufEnter *.cls setlocal filetype=java
"     autocmd BufEnter *.zsh-theme setlocal filetype=zsh
"     autocmd BufEnter Makefile setlocal noexpandtab
"     autocmd BufEnter *.sh setlocal tabstop=2
"     autocmd BufEnter *.sh setlocal shiftwidth=2
"     autocmd BufEnter *.sh setlocal softtabstop=2
" augroup END

" " }}}


" Section Backups {{{

    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup

" }}}


" " Section Arduino {{{
"     nnoremap <buffer> <leader>am :ArduinoVerify<CR>
"     nnoremap <buffer> <leader>au :ArduinoUpload<CR>
"     nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
"     nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
"     nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>
" " }}}


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

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" }}}


set foldmethod=marker
set foldlevel=0
set modelines=1

" vim:foldmethod=marker:foldlevel=0
