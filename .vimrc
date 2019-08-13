let g:acp_enableAtStartup = 0

let $MYVIMRC = expand("<sfile>:p")
let mapleader=","

if has("win32") && has('gui_running')
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar
  au GUIEnter * simalt ~x
  sign unplace *
endif

"I use fugitive so I don't need vim's file clutter
set nobackup
set nowritebackup
set noswapfile
set noundofile
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Installed Plugins                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
  call plug#begin($VIM . '/.vim' .'/plugged')
else
  call plug#begin($HOME . '/.vim' . '/plugged')
endif
  " Autocomplete
  Plug 'Valloric/YouCompleteMe'

  "Look of vim
  Plug 'Lokaltog/vim-powerline'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'powerline/fonts'

  " Tim Pope
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-tbone'
  Plug 'tpope/rbenv-ctags'
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-vividchalk'

  " Directory Changing
  "Plug 'airblade/vim-rooter'

  " Wiki
  Plug 'vim-scripts/utl.vim'
  Plug 'vimwiki/vimwiki'

  " Alignment
  Plug 'godlygeek/tabular'
  Plug 'junegunn/vim-easy-align'

  " Snippets
  Plug 'SirVer/ultisnips'

  " Folding
  Plug 'Konfekt/FastFold'

  " Navigation
  Plug 'scrooloose/nerdtree'
  Plug 'easymotion/vim-easymotion'
  Plug 'majutsushi/tagbar'

  " Fuzzy Searching
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'

  " Search and Search/Replace - This is the only neovim plugin
  "                             hardly worth the pain
  " Plug 'brooth/far.vim', { 'do': ':UpdateRemotePlugins' }


  " Drawing boxes
  Plug 'vim-scripts/DrawIt'

  " Because I have to restart nvim all of the time
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-session'

  " Destroy all buffers not currently open
  Plug 'artnez/vim-wipeout'

  " Linting
  Plug 'w0rp/ale'

  " Testing
  Plug 'janko-m/vim-test'
  Plug '5long/pytest-vim-compiler'
  Plug 'reinh/vim-makegreen'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'christoomey/vim-tmux-runner'

  " Candidates
  Plug 'tpope/vim-eunuch'
  Plug 'terryma/vim-multiple-cursors'

call plug#end()
set nocompatible

let test#python#runner = 'pytest'
let test#strategy = {
  \ 'nearest': 'make',
  \ 'file':    'dispatch',
  \ 'suite':   'dispatch_background',
  \}
let test#python#pytest#options = "--color=no --tb=short -q -s"

nmap <silent> <leader>tn :TestNearest<CR> " ,tn
nmap <silent> <leader>tf :TestFile<CR>    " ,tf
nmap <silent> <F8> :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>    " ,tl
nmap <silent> <leader>tg :TestVisit<CR>   " ,tg

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     ALE                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on only one linter per language, or you will be trying to shut off
" messages in the wrong tool.
let g:ale_linters ={
\ 'python': ['flake8']
\}
nmap <silent> <leader><C-j> <Plug>(ale_next_wrap)
nmap <silent> <leader><C-k> <Plug>(ale_previous_wrap)
let g:ale_sign_column_always=1
let g:ale_python_flake8_executable='flake8'
" PEP8 go to hell!  
" Lint (ale_python_flake8) is an EXTREMELY useful tool, but it has been filled with false alarms by PEP8
" Here are my PEP8 noise-over-rides
let g:ale_python_flake8_options =  "--ignore=W0311,"
let g:ale_python_flake8_options .= 'E501,' "line too long for the 70s
let g:ale_python_flake8_options .= 'E114,' "indent must be 4, no thank you
let g:ale_python_flake8_options .= 'E111,' "indentation is not a multiple of four, didn't we cover this?
let g:ale_python_flake8_options .= 'E272,' "multiple spaces before keyword, breaks tabularize
let g:ale_python_flake8_options .= 'E221,' "multiple spaces before operator, breaks tabularize
let g:ale_python_flake8_options .= 'E251,' "continuation line with same indent as next logical line
let g:ale_python_flake8_options .= 'E241,' "multiple space after ',' breaks tabularize
let g:ale_python_flake8_options .= 'E121,' "weird OCD overhang noise (wasting my precious heartbeats)
let g:ale_python_flake8_options .= 'E222,' "multiple spaces after operator, breaks tabularize
let g:ale_python_flake8_options .= 'E131,' "bike-shedding indent
let g:ale_python_flake8_options .= 'E128,' "bike-shedding indent
let g:ale_python_flake8_options .= 'E127,' "bike-shedding indent
let g:ale_python_flake8_options .= 'E116,' "bike-shedding indent
let g:ale_python_flake8_options .= 'E126,' "bike-shedding indent
let g:ale_python_flake8_options .= 'E122,' "yet another weird indent issue
let g:ale_python_flake8_options .= 'W391,' "why care about blank lines at the end of a file?
let g:ale_python_flake8_options .= 'E302,' "strange OCD space issue
let g:ale_python_flake8_options .= 'E303,' "strange OCD space issue
let g:ale_python_flake8_options .= 'E305,' "strange OCD space issue
let g:ale_python_flake8_options .= 'E265,' "hashtag comment space noise (distracting while debugging)
let g:session_autoload        = 'no'
let g:session_autosave        = 'yes'
let g:session_default_to_last = 'yes'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Custom configurations for plugins found in the same directory as $MYVIMRC   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
  let $VIMRCHOME= $VIM.'/.vim'
else
  let $VIMRCHOME= $HOME.'/.vim/'
endif
source $VIMRCHOME\code_vimrc.vim
source $VIMRCHOME\colorscheme_vimrc.vim
source $VIMRCHOME\easymotion_vimrc.vim
source $VIMRCHOME\fastfold_vimrc.vim
source $VIMRCHOME\fugitive_vimrc.vim
source $VIMRCHOME\language_vimrc.vim
source $VIMRCHOME\nerdtree_vimrc.vim
source $VIMRCHOME\vimairline_vimrc.vim
source $VIMRCHOME\vimwiki_vimrc.vim
source $VIMRCHOME\ackvimrc.vim
source $VIMRCHOME\fzfvimrc.vim
source $VIMRCHOME\fold_vimrc.vim
source $VIMRCHOME\ultisnips_vimrc.vim
source $VIMRCHOME\youcompleteme_vimrc.vim
source $VIMRCHOME\trace.vim
source $VIMRCHOME\ripgrep_vimrc.vim

let g:session_directory = $VIMRCHOME.'/sessions'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Tabularize                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>\ :Tabularize /\<CR>
nnoremap <leader>= :Tabularize /=<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Root Directory                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The rooter plugin will automatically cwd to the folder that is the parent that
" has the .git directory within it.
let g:rooter_patterns = ['.git/']
let g:rooter_silent_chdir = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Functions and Commands                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is for automatically aligning tables using the tabular plugin
" Taken from a Tim Pope gist, see https://gist.github.com/tpope/287147
function! s:align()
let p = '^\s*|\s.*\s|\s*$'
if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
  let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
  let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
  Tabularize/|/l1
  normal! 0
  call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               Get the number of lines from a visual selection                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:get_lines_from_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  return getline(lnum1,lnum2)
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           Write a visual selection to file, given that file's name           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:write_visual_selection_to_file(file_name)
  let file_name = a:file_name
  let input_strings = s:get_lines_from_visual_selection()
  return writefile(input_strings,file_name)
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"          Convert a visually selected trace into a Sequence Diagram           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
  function! s:call_trace_to_sequence_diagram(file_in_which_to_write_trace, diagram_output_file_name)
      let s:path_to_sequence = $VIM . "/.vim/.ruby/sequence.rb"
      normal mz
      let diagram_output_file_name = a:diagram_output_file_name
      let diagram_input_file_name  = a:file_in_which_to_write_trace
      call s:write_visual_selection_to_file(diagram_input_file_name)
      " write the trace to file
      call system("ruby " . s:path_to_sequence . " -i ".diagram_input_file_name. " -o " .diagram_output_file_name )
      " write the trace to the @t register
      let @t = system("ruby ". s:path_to_sequence . " -i ".diagram_input_file_name )
      " remove our input and output files
      call delete(diagram_input_file_name)
      call delete(diagram_output_file_name)
      " put the @t register into our buffer at the bottom of the selection
      normal `>
      normal o
      put! t
      normal `z
      " place the cursor at the first '?' so that we can start over-writing
      " our '?' characters with numbers
      call search( "?")
      normal zt
      return 0
  endfunction
else
  function! s:call_trace_to_sequence_diagram(file_in_which_to_write_trace, diagram_output_file_name)
      normal mz
      let diagram_output_file_name = a:diagram_output_file_name
      let diagram_input_file_name  = a:file_in_which_to_write_trace
      call s:write_visual_selection_to_file(diagram_input_file_name)
      " write the trace to file
      call system("ruby ~/.vim/.ruby/sequence.rb -i ".diagram_input_file_name. " -o " .diagram_output_file_name )
      " write the trace to the @t register
      let @t = system("ruby ~/.vim/.ruby/sequence.rb -i ".diagram_input_file_name )
      normal `>
      normal o
      put! t
      normal `z
      call search( "?")
      normal zt
      return 0
  endfunction
endif

command! -range TraceToSequenceDiagram call s:call_trace_to_sequence_diagram("__trace.txt__","__sequence_diagram.txt__")
function! GetRefactorProgramPath()
  let s:this_path = fnamemodify($MYVIMRC, ":h")
  let s:script_path = s:this_path . "/bundle/recurse/refactor.rb"
  return s:script_path
endfunction

function! GetYamlRefactorFileName()
  let s:this_path = fnamemodify($MYVIMRC, ":h")
  let s:script_path = s:this_path . "/bundle/recurse/refactor.rb"
  let s:cmd = "ruby ". "'" . s:script_path . "'" . " -f"
  let s:output = system( s:cmd )
  return s:output
endfunction

function! YamlForRefactor()
  "let s:this_path = fnamemodify($MYVIMRC, ":h")
  let s:script_path = GetRefactorProgramPath()
  let s:current_directory = expand("%:p:h")
  let s:cmd = "ruby " . "'" . s:script_path . "'" . " -e " . "'" . s:current_directory . "'"
  execute "!" . s:cmd
  let s:yaml_file_name = GetYamlRefactorFileName()
  let s:yaml_file_path = s:current_directory . "/" . s:yaml_file_name
  execute "vsplit " . s:yaml_file_path
  "let @a = s:cmd
endfunction

function! Refactor()
  let s:script_path = GetRefactorProgramPath()
  let s:yaml_file_name = GetYamlRefactorFileName()
  let s:current_directory = expand("%:p:h")
  let s:yaml_file_path = s:current_directory . "/" . s:yaml_file_name
  let s:cmd = "ruby " . "'" . s:script_path . "'"
  let s:cmd = s:cmd . " -d " . "'" . s:current_directory . "'"
  let s:cmd = s:cmd . " -y " . "'" .  s:yaml_file_path . "'"
  let @a = s:cmd
  execute "!" . s:cmd
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Determine the comment token character                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:GetToken()
  let token = "#"
  let file_name = expand("%:t:r")
  let file_ext  = expand("%:e")

  if file_name ==? ".vimrc"
    let token = "\""
  elseif file_ext ==? "vim"
    let token = "\""
  endif

  if file_ext ==? "c" || file_ext ==? "h"
      let token = "*"
  endif

  return token
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              Center and Box Some Text In a file specific token               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:BoxitFunction()
  let token = s:GetToken()
  " remove space before and after the words
  execute "silent! normal 0,$"
  execute "silent! normal 0d\/w"
  center
  " insert the top bar of tokens
  execute "silent! normal! O\e80i".token
  " add a bunch of spaces after your centered word
  execute "silent! normal! jA \e40i "
  " inset the bottom bar of tokens
  execute "silent! normal! o\e81i".token
  " place the first and the last token at 0 and the 80th column of the same
  " row as the centered word(s)
  execute "silent! normal! 0dt".token
  execute "silent! normal! k0i".token."\el\ex"
  execute "silent! normal! 80|lD"
  execute "silent! normal! r".token
  execute "silent! normal! k0"
  " for the * token, add some additional decoration
  " and for any token ensure we try to move to the line below the boxed
  " content
  if token == "*"
    silent! normal r/
    silent! normal jj$r/
    silent! normal j
  else
    silent! normal 3j
  endif
endfunction
command! Boxit call s:BoxitFunction()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Lifted from Tim Pope                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenURL(url)
  if has("win32")
    exe "!start cmd /cstart /b ".a:url.""
  elseif $DISPLAY !~ '^\w'
    exe "silent !tpope open \"".a:url."\""
  elseif exists(':Start')
    exe "Start tpope open -T \"".a:url."\""
  else
  endif
  redraw!
endfunction
command! -nargs=1 OpenURL :call OpenURL(<q-args>)
" open URL under cursor in browser
nnoremap gb :OpenURL <cfile><CR>
nnoremap gA :OpenURL http://www.answers.com/<cword><CR>
nnoremap gG :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>


"source $VIMRCHOME/code_vimrc.vim
"source $VIMRCHOME/colorscheme_vimrc.vim
""source $VIMRCHOME\denite_vimrc.vim
"source $VIMRCHOME/easymotion_vimrc.vim
"source $VIMRCHOME/fastfold_vimrc.vim
"source $VIMRCHOME/fugitive_vimrc.vim
"source $VIMRCHOME/language_vimrc.vim
"source $VIMRCHOME/nerdtree_vimrc.vim
"source $VIMRCHOME/vimairline_vimrc.vim
"source $VIMRCHOME/vimwiki_vimrc.vim
"source $VIMRCHOME/ackvimrc.vim
"source $VIMRCHOME/fzfvimrc.vim
"source $VIMRCHOME/fold_vimrc.vim
"source $VIMRCHOME/ultisnips_vimrc.vim
"source $VIMRCHOME/youcompleteme_vimrc.vim
"source $VIMRCHOME/trace.vim

" this makes vim's regex engine "not stupid"
" see :h magic
"nnoremap / /\v
"vnoremap / /\v

" This command will allow us to save a file we don't have permission to save
" *after* we have already opened it. Super useful.
cnoremap w!! w !sudo tee % >/dev/null

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Remove Trailing White Space                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>w :s/\v[ ]+$//ge<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Spelling                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The spelling file is found in $VIMRCHOME\spell\
"
" If you add a word, it will be placed in en.ascii.add -- this is under revision
" control so if you add a word by accident it will be apparent fugitive will
" find it.
"
" toggle your spell checker
nmap     <leader><C-s> :set spell!<CR>
" To automatically select the most likely word when over a misspelled word in
" normal mode
nnoremap <leader>z 1z=<ESC>ea
set spell spelllang=en_us
" Always move between wrapped lines
nnoremap j gj
nnoremap k gk

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Changing the font will crash NVIM on startup                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guifont=Consolas:h13
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Reload your VIMRC                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>s :source $MYVIMRC<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           Automatically Load any Adjustements to your *.vim files            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup reload_vimrc_and_init
  "Guifont! Consolas:h15 " This will crash nvim if you place it in the raw
  autocmd!
  au BufWritePost *.vim  source $MYVIMRC
augroup END

function! RsyncPython()
   let job = job_start('/usr/local/bin/python3.6 .rsync_local_files.py')
endfunction

augroup rsync_python_files
  autocmd!
  au BufWritePost *.py  call RsyncPython()
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Font/font                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Guifont! Droid Sans Mono:h15
"Guifont! Inconsolata:h15
"Guifont! Ubuntu Mono:h15
"Guifont! Consolas:h15
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Copy Full Path into @" Register                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap cp :let @" = expand("%:p")<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Status Line                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2 " Always show status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 White Space                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set title
set ruler
set backspace=indent,eol,start
filetype plugin on
filetype indent on
set shortmess=atI
set visualbell
set number
set encoding=utf8
set nocursorcolumn
set completeopt=menuone,preview
let g:cursorcolumn=80
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Powerline Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Powerline_symbols = 'compatible'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Tab-completion in command-line mode                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Tab>   ->
"   S-Tab> <-
set wildmode=full
set wildmenu
set wildignore=*.pdf,*.fo,*.xml
set suffixes=.otl
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Disable Swapfile and Backup                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set noswapfile
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Syntax Highlighting                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Recurse to the tags file                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags+=tags;/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Set our page size to 80 characters                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tw=80
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Diff Colors                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=white
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
if has("autocmd")
  " Enable filetype detection
  filetype plugin indent on

  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif
if &t_Co > 2 || has("gui_running")
  " Enable syntax highlighting
  syntax on
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Clip Board Control                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>p "*p
noremap <leader>y "*y
vmap <leader>y "*y
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Only! But Faster!                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>o :only!<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Toggle Highlighting                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>f :set hls!<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Change to this file's directory                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>cd :cd %:p:h<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Bubbling Text                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bubble single lines
nmap <C-UP> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-UP> [egv
vmap <C-Down> ]egv
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           Visually Select the Text that was the last edited/pasted           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap gV `[v`]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Tabularize your white space                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <leader>ts :Tabularize /^[^ ]*\zs /l0<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Dancing diff this                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader><leader>d :diffthis <CR><c-w>l :diffthis<CR><c-w>h<CR>gg
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     Make                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap  <leader><c-b> :make<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Move Around Windows Quickly                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around windows quickly
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Open this vimrc                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>e :e $MYVIMRC<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Select the last pasted text                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gp `[v`]oz.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Yank a whole line                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap Y v$y

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Color Scheme                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"colorscheme base16-atelier-cave
"colorscheme base16-embers
"colorscheme base16-apathy
"colorscheme base16-darktooth
"colorscheme base16-brewer
set background=light
let g:airline_base16_apathy = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Easymotion Configuration                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_keys             = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_verbose          = 0
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
nmap s <Plug>(easymotion-overwin-f)
nmap t <Plug>(easymotion-t)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Fast Fold, I'm not sure if this works at all                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Expand and Collapse Folds                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Space> za
nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     Ruby                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType *.ruby setlocal ts=2 sts=2 sw=2
autocmd FileType *.rb setlocal ts=2 sts=2 sw=2
au BufNewFile,BufReadPost *.rb setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.ruby setl shiftwidth=2 expandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Coffeescript                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Python                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType *.py setlocal ts=2 sts=2 sw=2
autocmd FileType *.py setlocal ts=2 sts=2 sw=2
au BufNewFile,BufReadPost *.py setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.py setl shiftwidth=2 expandtab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  LaTeX/TeX                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.tex colorscheme vividchalk

let g:airline_detect_modified=1
let g:airline_detect_spell=1
function! AirlineInit()
  let g:airline#extensions#branch#enabled       = 1
  let g:airline#extensions#branch#empty_message = ''
  set laststatus=2
endfunction

autocmd User AirlineAfterInit call AirlineInit()
"let g:airline#extensions#tabline#enabled = 1

"copy (write) highlighted text to .vimbuffer
vmap <C-c> y:new ~/.vimbuffer<CR>VGp:x<CR> :silent! !cat /home/scott/.vimbuffer \| clip.exe<CR><CR>

" paste from buffer
"map <C-V> :r ~/.vimbuffer<CR>

set spell!
colorscheme vividchalk
nnoremap <silent><F9> :TagbarToggle<CR>
au Filetype python setl et ts=2 sw=2

" place an A marker above your state definition
" place a W marker where you want your static functions
function! s:AutoWriteStaticFunctionMacroToq()
  let @q= '/handlewwwlvt)"ayj0mA`Wi  @staticmethoddef a(chart, e):status = return_status.HANDLEDreturn statusmW`A'
endfunction

command! StaticFunctionMacroToq call s:AutoWriteStaticFunctionMacroToq()

function! s:AutoWriteFunctionMacroToq()
  let @q= '/handlewwwlvt)"ayj0mA`Wi  def a(self, e):status = return_status.HANDLEDreturn statusmW`A'
endfunction

command! FunctionMacroToq call s:AutoWriteFunctionMacroToq()
