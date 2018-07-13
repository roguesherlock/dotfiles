let s:default_fontsize = 11
let s:fontsize = s:default_fontsize
let s:font = "Fira Code Retina"

colorscheme dracula

function! SetFont() abort
    if exists('g:GtkGuiLoaded')
        call rpcnotify(1, 'Gui', 'Font', s:font . ' ' . s:fontsize)
    else
        exec "GuiFont " . s:font . ":h" . s:fontsize
    endif
endfunction

call SetFont()

function! AdjustFontSize(delta)
    let s:fontsize += a:delta
    call SetFont()
endfunction

function! ResetFontSize()
    let s:fontsize = s:default_fontsize
    call SetFont()
endfunction

" Adjust Font Size Shortcuts
nnoremap <C-=> :call AdjustFontSize(1)<CR>
nnoremap <C-+> :call AdjustFontSize(1)<CR>
nnoremap <C--> :call AdjustFontSize(-1)<CR>
nnoremap <C-0> :call ResetFontSize()<CR>
