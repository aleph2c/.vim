if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nmap <leader>gg mG<ESC>:Ack! "\b<cword>\b" <CR>
"nmap <Esc>k   :Ack! "\b<cword>\b" <CR>

"nmap <c-g> :Ag<CR>
let g:ack_mappings = {
      \  'v':  '<C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p',
      \ 'gv': '<C-W><CR><C-W>L<C-W>p<C-W>J' }
