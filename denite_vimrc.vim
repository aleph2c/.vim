" to move down in the selection ctrl-j
" to move up in the selection ctrl-k
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" To clear your search <c-l>
call denite#custom#map('insert', '<C-l>', '<denite:delete_entire_text>', 'noremap')

" Change default prompt
call denite#custom#option('default', 'prompt', '>')

nnoremap <C-m><C-m> :Denite file_mru<CR>
nnoremap <C-b><C-b> :Denite buffer<CR>
nnoremap <C-c><C-c> :Denite colorscheme<CR>
nnoremap <C-h><C-h> :Denite command_history<CR>
nnoremap <C-;><C-;> :Denite line<CR>
nnoremap <C-,><C-,> :Denite register<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Denite to only search items in git                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
\ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> <C-p> :<C-u>Denite
\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
