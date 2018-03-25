" To understand this configuration
" :help grepper
"
" To start grepper
" Using the default tool chain
nnoremap <leader>g  :Grepper<cr>
nnoremap <leader>b  :Grepper -buffers<cr>
nnoremap <leader>gg :Grepper -tool git -open -switch -cword -noprompt<cr>
nnoremap <leader>*  :Grepper -tool rg -cword -noprompt<cr>

nnoremap <leader>g Grepper  -tool rg<cr>
nnoremap <leader>G :Grepper -tool git<cr>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Optional. The default behaviour should work for most users.
let g:grepper               = {}
let g:grepper.tools         = ['rg', 'git', 'ag']
let g:grepper.jump          = 1
let g:grepper.next_tool     = '<leader>g'
let g:grepper.simple_prompt = 1
let g:grepper.quickfix      = 0
" After the ex window is triggered, you can switch between grep tools by
" using the same key motion that initiated the search
"let g:grepper.next_tool = '<leader> g'

" Note about commented items below.  If they are uncommented, the QT-vim client
" for windows will time out on startup.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Default Tool Chain                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A grepper search will try to grep starting from:
" 1) the directory that contains a repo directory (.git, etct) above the current
"    file location
" 2) any 'pwd' working directory above the given file location
" 3) the file directory itself
"let g:grepper.tools = ['ag', 'git', 'grep']
"let g:grepper.repo  = ['.git', '.hg'.'.svn']
"let g:grepper.dir   = 'repo,filecwd,file'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""                                Configuration                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""let &statusline .= ' %{grepper#statusline()}'
"" Grep the current buffer.
""let g:grepper.buffers   = 0
"" Highlight found matches.
""let g:grepper.highlight = 1
"" Use the quickfix list for the matches or the location list otherwise.
""let g:grepper.quickfix = 1
"" Open the quick fix
"let g:grepper.open = 1
"" When the quickfix/location window opens, switch to it.
"let g:grepper.switch = 1
"" Automatically jump to the first match.
"let g:grepper.jump = 0
"" To prompt or not to prompt!
"let g:grepper.prompt = 1
"" Only show the tool name in the prompt, without any of its arguments.
"let g:grepper.simple_prompt = 0
ord -tool rg




Only match 500 items then give up (if you get over 500 you have a bad search)
e-cword :-cword :le  g:grepper.stop = 500
