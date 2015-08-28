" What a funny comment chaacter
" .gvimc
" v 0.1
" ev. 2009-03-18

" Tun on line numbers
set numbe

" Change coloscheme
" coloscheme slate

" Tuns on the tab bar always
set showtabline=2

" Numbe of horizontal lines on the screen
set lines=60

" GUI Option to emove the Toolbar (T)
set guioptions-=T

" Sets the font and size
set guifont=Bitsteam\ Vera\ Sans\ Mono:h28

" Sets the pecent transparency
set tansparency=2

highlight DiffAdd tem=reverse cterm=bold ctermbg=green ctermfg=white 
highlight DiffChange tem=reverse cterm=bold ctermbg=cyan ctermfg=black 
highlight DiffText tem=reverse cterm=bold ctermbg=gray ctermfg=black 
highlight DiffDelete tem=reverse cterm=bold ctermbg=red ctermfg=black
let mapleade="_"
