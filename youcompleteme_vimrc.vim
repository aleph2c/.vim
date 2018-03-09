""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               You Complete Me                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The windows set up is a NIGHTMARE, download and install:
" * Virtual Studio Community Addition (5Gigs)
" * Virtual Studio Build Tools        (2Gigs)
" * Cmake
"
" Adjust path so that (using rapid path editor):
" * Cmake is found
" * MsBuild.exe can be found
"
" Restart whatever shell you have so that the path is updated, then:
"  > cd C:/User/<user>/AppData/Local/nvim/plugged/YouCompleteMe
"  > python install.py --msvc 15
"
set encoding=utf8
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_confirm_extra_conf=0
let g:ycm_goto_buffer_command='horizontal-split'
let g:ycm_use_ultisnips_completer=1
map <F9> :YcmRestartServer<CR>
nnoremap <leader>yd :YcmDiags<CR>
nnoremap <leader>yc :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>g  :YcmCompleter GoTo<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>
