""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  ultisnips                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger       = '<c-j>' " tab broken, c-tab slow
let g:UltiSnipsJumpForwardTrigger  = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
if has("python3")
  let g:UltiSnipsUsePythonVersion    = 3
else
  let g:UltiSnipsUsePythonVersion    = 2
endif

let g:UltiSnipsSnippetDirectories  = [$VIMRCHOME . "\snippets"]
let g:UltiSnipsSnippetsDir         = $VIMRCHOME . "\snippets"
let g:UltiSnipsEnableSnipMate      = 0
map <C-F8> :UltiSnipsEdit<CR>

