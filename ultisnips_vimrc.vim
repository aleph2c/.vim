""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  ultisnips                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger       = '<c-j>' " tab broken, c-tab slow
let g:UltiSnipsJumpForwardTrigger  = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsUsePythonVersion    = 3

if has("win32")
  let g:UltiSnipsSnippetDirectories  = [$HOME . '/.vim' . '/snippets']
  let g:UltiSnipsSnippetsDir         = $HOME . '/.vim' . '/snippets'
else
  let g:UltiSnipsSnippetDirectories  = [$VIMRCHOME . "\snippets"]
  let g:UltiSnipsSnippetsDir         = $VIMRCHOME . "\snippets"
endif
let g:UltiSnipsEnableSnipMate      = 0
map <C-F8> :UltiSnipsEdit<CR>

