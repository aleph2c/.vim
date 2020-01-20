""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  ultisnips                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger       = '<c-j>' " tab broken, c-tab slow
let g:UltiSnipsJumpForwardTrigger  = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsUsePythonVersion  = 3

if has("win32")
  let g:UltiSnipsSnippetDirectories  = [$VIM . '/.vim' . '/snippets']
  let g:UltiSnipsSnippetsDir         = $VIM . '/.vim' . '/snippets'
else
  let g:UltiSnipsSnippetDirectories  = [$VIMRCHOME . "/snippets"]
  let g:UltiSnipsSnippetsDir         = $VIMRCHOME . "/snippets"
endif
let g:UltiSnipsEnableSnipMate      = 0
map <F8> :UltiSnipsEdit<CR>

