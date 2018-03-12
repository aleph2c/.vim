"let g:airline_section_b = '%{strftime("%c")}'
"let g:airline_section_y = 'BN: %{bufnr("%s")}'

let g:airline_detect_modified=1
let g:airline_detect_spell=1
function! AirlineInit()
  let g:airline#extensions#branch#enabled       = 1
  let g:airline#extensions#branch#empty_message = ''
  set laststatus=2
endfunction

autocmd User AirlineAfterInit call AirlineInit()
"let g:airline#extensions#tabline#enabled = 1
