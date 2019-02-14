noremap ; :Buffers<CR>
noremap  <c-p> :Files<CR>
nnoremap <leader>r :Tags<CR>
"nnoremap <c-m><c-m> :History<CR>
"let g:fzf_history_dir = $VIMRCHOME.'/history'
let g:fzf_nvim_statusline = 0
let g:fzf_layout = {'down': '~20%'}
if has("win32")
  let g:fzf_history_dir = 'c:/fzf-history'
endif
"nnoremap <leader>g :Ag<CR>
