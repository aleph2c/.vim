let g:ale_linters ={
\ 'python': ['flake8']
\}
nmap <silent> <leader><C-k> <Plug>(ale_previous_wrap)
nmap <silent> <leader><C-j> <Plug>(ale_next_wrap)
let g:ale_python_flake8_executable='flake8'
let g:ale_sign_column_always=1

" PEP8 over-rides
let g:ale_python_flake8_options =  "--ignore=W0311,"
let g:ale_python_flake8_options .= 'E501,' "line too long for the 70s
let g:ale_python_flake8_options .= 'E114,' "indent must be 4
let g:ale_python_flake8_options .= 'E111,' "indentation is not a multiple of four
let g:ale_python_flake8_options .= 'E272,' "multiple spaces before keyword
let g:ale_python_flake8_options .= 'E221,' "multiple spaces before operator
let g:ale_python_flake8_options .= 'E251,' "continuation line with same indent as next logical line
let g:ale_python_flake8_options .= 'E241,' "multiple space after ','
let g:ale_python_flake8_options .= 'E121,' "weird OCD overhang noise
let g:ale_python_flake8_options .= 'E222,' "multiple spaces after operator
let g:ale_python_flake8_options .= 'E131,' "another weird indent issue
let g:ale_python_flake8_options .= 'E128,' "another weird indent issue
let g:ale_python_flake8_options .= 'E127,' "another weird indent issue
let g:ale_python_flake8_options .= 'E116,' "another weird indent issue
let g:ale_python_flake8_options .= 'E126,' "another weird indent issue
let g:ale_python_flake8_options .= 'E122,' "another weird indent issue
let g:ale_python_flake8_options .= 'W391,' "why care about blank lines at the end of a file?

let g:ale_python_flake8_options .= 'E402,' "I'm not sure how to make this happen if I want to
                                           "test the file, without a custom
                                           "import (When I become better with
                                           "Python I'll do it, for now it's
                                           "distracting)

let g:session_autoload        = 'no'
let g:session_autosave        = 'yes'
let g:session_default_to_last = 'yes'
let g:session_directory       = $VIMRCHOME.'/sessions'

nnoremap <leader>\ :Tabularize /\<CR>
nnoremap <leader>= :Tabularize /=<CR>
