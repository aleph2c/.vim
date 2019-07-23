""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Fugitive Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <leader>k  :Gvdiff <CR>
"nnoremap <leader>d  :Gstatus<CR>

" Add the git branch to your status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" Keep the buffer clear of fugitive generated files
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd QuickFixCmdPost *grep* cwindow
"nnoremap <leader>gg :execute "Ggrep " . expand("<cword>")<CR>:copen<CR><CR>
nnoremap <leader>gl :execute "Glog " . "--grep=" . expand("<cword>") . "--"<CR>
nnoremap <leader>gs :execute "Glog " . "-S" .expand("<cword>") . " -- %"<CR> :copen<CR>
"autocmd User fugitive
"\ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
"\   nnoremap <buffer> .. :edit %:h<CR> |
"\ endif
let g:vimwiki_table_mappings=0
if has("win32")
  let s:path_to_this_file=expand("<sfile>:p:h")
  let s:path_to_vim_wikis = s:path_to_this_file . '\Dropbox\vimwiki\'
  let s:path_to_vim_wikis_html = s:path_to_this_file .'Dropbox\vimwiki_html\'
  let g:vimwiki_list = [{'path': 'C:\Users\lincoln\Dropbox\vimwiki'}]
  "let s:path_to_vim_wikis = s:path_to_this_file . '\vimwiki\'
  "let s:path_to_vim_wikis = 'C:\Users\lincoln\Dropbox\vimwiki'
else
  "let s:path_to_this_file=expand("<sfile>:p:h:")
  "let s:path_to_vim_wikis = s:path_to_this_file . '/vimwiki/'
  let s:path_to_vim_wikis = 'C:\Users\lincoln\Dropbox\vimwiki'
endif

