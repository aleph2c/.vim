" What a funny comment character
" .gvimrc
" v 0.1
" rev. 2009-03-18

" Turn on line numbers
set number

" Change colorscheme
" colorscheme slate

" Turns on the tab bar always
set showtabline=2

" Number of horizontal lines on the screen
set lines=60

" GUI Option to remove the Toolbar (T)
set guioptions-=T

" Sets the font and size
set guifont=Bitstream\ Vera\ Sans\ Mono:h28

" Sets the percent transparency
set transparency=2

highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=white 
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black 
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black 
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
let mapleader="_"
