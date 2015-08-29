""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               How To Navigate                                "
" Search Terms:                                                                "
"   Leader                 - the map leader                                    "
"   Configurations         - plugin configurations                             "
"   Settings               - typical vim settings                              "
"   Abbreviations          - vim abbreviations                                 "
"   File Specific Options  - how vim handles a given filetype                  "
"   Functions and Commands - vimscript functions and custom commands           "
"   Mappings               - key mappings                                      "
"                                                                              "
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim
if has("autocmd")
  filetype indent plugin on
endif
"                                 Tmux related                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set clipboard=unnamedplus
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 NeoComplete                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                neocomplcache                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Leader                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Configurations                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Vim Expand Region Configuration                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap v <Plug>(expand_region_expand)
vmap <C-v><Plug>(expand_region_shrink)
call expand_region#custom_text_objects({
      \ "\/\\n\\n\<CR>": 1,
      \ 'a]' :1,
      \ 'ab' :1,
      \ 'aB' :1,
      \ 'ii' :0,
      \ 'ai' :0,
      \ })

let g:expand_region_text_objects_ruby = {
      \ 'im' :0,
      \ 'am' :0,
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Pathogen Related Configurations                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pathogen_disabled = []
if v:version < '703' || !has('python')
    call add(g:pathogen_disabled, 'gundo' )
endif
call add( g:pathogen_disabled, 'bccalc' )
call add( g:pathogen_disabled, 'cctree' )
call add( g:pathogen_disabled, 'numbers' )
call add( g:pathogen_disabled, 'taghighlight' )
call add( g:pathogen_disabled, 'taglist-plus' )
call add( g:pathogen_disabled, 'vim-endwise' )
call add( g:pathogen_disabled, 'vis' )
call add( g:pathogen_disabled, 'zoomwin' )
call add( g:pathogen_disabled, 'cscope' )
call add( g:pathogen_disabled, 'matlab' )
call add( g:pathogen_disabled, 'jslint' )
call add( g:pathogen_disabled, 'unite' )

call pathogen#helptags()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Vimslime Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" To see the current session in Tmux
" Tmux display-session -p "#S"
"
" To see the current panes in Tmux
" ctrl-a q
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars
function! Get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! To_Debug_Tmux()
  let b:varToDisplay = expand("<cword>")
  call Send_to_Tmux("display ".b:varToDisplay."\n")
endfunction

function! Selected_To_Debug_Tmux()
  " drop a marker to get back to our spot
  normal! mZ
  let b:varToDisplay = Get_visual_selection()
  echom b:varToDisplay
  call Send_to_Tmux("display ".b:varToDisplay."\n")
  " go back to the spot from where we started
  normal! ~Z
endfunction

function! Debug_Restart_Tmux()
  echom "restarting debugger"
  call Send_to_Tmux("restart\n")
endfunction

function! Debug_Continue_Tmux()
  echom "continuing debug session"
  call Send_to_Tmux("continue\n")
endfunction

"cmap dd :call To_Debug_Tmux()<CR>
noremap <leader>d :call To_Debug_Tmux()<CR>
vmap <leader>d :call Selected_To_Debug_Tmux()<CR>
noremap <leader>r :call Debug_Restart_Tmux()<CR>
noremap <leader>c :call Debug_Continue_Tmux()<CR>

"" Workflow
" Navigate to the correct directory
" > tmux new -s session_name
" Split the pane
" > ctrl-a -
" Navigate to other pane
" ctrl-a n
" Start guard
" > guard
" Navigate to other pane
" ctrl-a k
" Open vim
" >vim
" When debugger has landed type <leader>d to diplay contents of the file in tmux


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Ctrl-P Configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
  set shell=cmd.exe
  " Ctrp settings for windows environment
  set wildignore+=*\\.git\\*,*\\doc\\*,*\\[tT]est.+\\*
  let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|\.hg|\doc|\CppUTest|\.svn|\doc)$',
  \ 'file': '\v(\.lst$|\.exe$\|\.so$\|\.dll$|\.obj$|tags$|\.py$|\.swp$|\.html$)',
  \ }
else
  set wildignore+=*/.git/*
endif
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_max = 250
let g:ctrlp_dotfiles = 0
let g:ctrlp_mruf_default_order = 0
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           YankStack Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This needs to be called before any of the copy/paste keybindings are made
" call yankstack#setup()
" this is set so that on the mac I can use the "option" key as the meta key in
" my keybindings, particularily with this plugin
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    set macmeta
  endif
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Gundo Configuration                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if has("python")
"  nnoremap <silent><leader>gg :GundoToggle <CR>
"endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Fugitive Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add the git branch to your status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" Keep the buffer clear of fugitive generated files
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd QuickFixCmdPost *grep* cwindow
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"          Search your local repository for the word under the cursor          "
" Ggrep findme         search for 'findme' in the working copy files           "
"                      ( excluding untracked files, which match the patterns in"
"                      your .gitignore file.                                   "
" Ggrep --cached findme   search for 'findme' in the index                     "
" Ggrep findme branchname search for 'findme' in branch 'branchname'           "
" Ggrep findme tagname    search for 'findme' in tag 'tagname'                 "
" Grep findme SHA         search for 'findme' in the commit/tag identified by  "
"                         by SHA                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gg :execute "Ggrep " . expand("<cword>")<CR>:copen<CR><CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"            Navigate to where a word was reference in a git commit            "
" Glog --grep=findme -- search for 'findme' in all ancestral commit messages   "
" Glog --grep=findme -- % search for 'findme' in all ancestral commit messages "
"                         that touch the current active file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gl :execute "Glog " . "--grep=" . expand("<cword>") . "--"<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                Navigate to where a thing was added or removed                "
"                Using the pickax symbol                                       "
" Examples:                                                                    "
" :Glog -Sfindme --	search for 'findme' in the diff for each ancestral commit  "
" :Glog -Sfindme -- %	search for 'findme' in the diff for each ancestral       "
"                     commit that touches the currently active file            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gs :execute "Glog " . "-S" .expand("<cword>") . " -- %"<CR> :copen<CR>

" press .. to step up one level while navigating trees with the fugitive command
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Cscope Configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let os = substitute(system('uname'),"\n","","")
if( match( system('uname -s'),"windows32" ) >= 0 )
  " Source the vimrc file after saving it
  set background=dark
  " for cctree - not used on your mac
  let g:CCTreeRecursiveDepth=2
  let g:CCTreeMinVisibileDepth=2
  let g:CCTreeOrientation="above"
else
  set background=dark
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Rainbow Parentheses Configuration                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au syntax * cal rainbow#load([['(',')'],['\[','\]'],['{','}'],['begin','end']])
au syntax * cal rainbow#activate()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Vimwiki Configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
    let s:path_to_this_file=expand("<sfile>:p:h")
    let s:path_to_vim_wikis = s:path_to_this_file . '\vimwiki\'
    let s:path_to_vim_wikis_html = s:path_to_this_file .'\vimwiki_html\'
else
    let s:path_to_this_file=expand("<sfile>:p:h:")
    let s:path_to_vim_wikis = s:path_to_this_file . '/vimwiki/'
    let s:path_to_vim_wikis_html = s:path_to_this_file .'/vimwiki_html/'
endif
nnoremap <leader><leader>dg :VimwikiMakeDiaryNote<CR>
nnoremap <leader><leader>d :VimwikiDiaryIndex<CR>
"echom "path to this file: " .s:path_to_this_file
"echom "path to vim wikis ". s:path_to_vim_wikis
"echom s:path_to_vim_wikis_html
"vimwiki
if has("win32")
    let g:vimwiki_list = [{
     \ 'path': s:path_to_vim_wikis,
     \ 'path_html': s:path_to_vim_wikis_html}, {
     \ 'path': 'C:\Code\Depots\Xantrex1\FSW_Backup_TI2812_3524-120-240_Prototype\Software\Code\wiki',
     \ 'path_html': 'C:\Code\Depots\Xantrex1\FSW_Backup_TI2812_3524-120-240_Prototype\Software\Code\wikis\wiki\public_html\'}, {
     \ 'path': 'G:\ruby\wikis',
     \ 'path_html': 'G:\ruby\wikis\public_html'}]
endif
let g:vimwiki_folding=1
let g:vimwiki_fold_lists=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Sessions Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:session_autoload = 'no'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Powerline Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Powerline_symbols = 'compatible'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Vim-Indent-Guide Configuration                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Solarized Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>
set background=dark
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Solarized and vim-indent-guide Configuration                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           EasyMotion Configuration                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Settings                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
"               Map MYVIMRC to correct location on all computers               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $MYVIMRC = expand("<sfile>:p")
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Comma Replacement                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" since we are using the comma as the leader, remap c-e as the comma
noremap <c-e> ,
vnoremap <c-e> ,
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Syntax Highlighting                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
" Cargo Culting
set nocompatible
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Set the Colour Scheme                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
  colorscheme solarized
else
  " solarized options
  let g:solarized_termcolors = 16
  let g:solarized_visibility = "normal"
  let g:solarized_contrast   = "normal"
  colorscheme solarized
endif

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
"                          Fonts Tabs and Whitespace                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Defaults
" Consolas supported on all computers
set guifont=consolas:h15
"  the width of a tab
set tabstop=2
"  how far to move with >> and <<
set shiftwidth=2
" how many tabs to use in insert mode
set softtabstop=2
set expandtab
set title
set ruler
set backspace=indent,eol,start
set shortmess=atI
set visualbell
set number
set encoding=utf8
set nocursorcolumn
set completeopt=menuone,preview
let g:cursorcolumn=80
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Abbreviations                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"dts" expands to date time stamp
iab <expr> dts strftime("%c")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            File Specific Options                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     Ruby                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType *.ruby setlocal ts=2 sts=2 sw=2
autocmd FileType *.rb setlocal ts=2 sts=2 sw=2 suffixesadd+=.rb
au BufNewFile,BufReadPost *.rb setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.ruby setl shiftwidth=2 expandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Coffeescript                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Matlab                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufEnter *.m compiler mlint
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Schneider                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For Schneider Code I am mandated to use tabs ( or space gaps ) with 4 spaces
if has("win32")
  set tabstop=2 softtabstop=2 shiftwidth=2
  "reduce the set list contrast for solarized
  let g:solarized_visibility ="normal"
  let g:solarized_contrast="normal"
  set background=dark
  set list
  try
    set listchars=tab:¦·,trail:.,extends:#,nbsp:.
  endtry
endif

if &term == "xterm"
  colorscheme desert
  set t_Co=256
endif
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
"                           Cargo Culting NextIndent                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Strip trailing whitespace                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leader>$
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Show a Functions Name                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leader>f
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Toggle the Cursor Column                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleCursorColumn()
  if(g:cursorcolumn)
    set nocursorcolumn
    set completeopt=menuone,preview
    let g:cursorcolumn=0
  else
    set cursorcolumn
    set completeopt=menuone
    let g:cursorcolumn=1
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Close Window or Kill the Buffer                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Q to intelligently close a window
" (if there are multiple windows into the same buffer)
" or kill the buffer entirely if it's the last window looking into that buffer
function! CloseWindowOrKillBuffer()
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

" We should never bdelete a nerd tree
  if matchstr(expand("%"), 'NERD') == 'NERD'
    wincmd c
    return
  endif

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Update the Function Header                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! UpdateFunctionHeader()
    " change this to change the author name
    let author = "Scott Volk"
    call search( "Version",'b')
    let old_version_line = getline(".")
    let start_line = line('.')
    call search("*")
    let end_line = line('.')
    execute "normal ".start_line."G"
    let end_code_tag_found = search('endcode','p',end_line)
    if( end_code_tag_found )
      let post_above_line = line(".")
    else
      let post_above_line = end_line
    endif
    "Example
    "Version: 1.00    Date: Wed 09/12/2012  By: Scott Volk
    let pattern = 'Version:\s*\(\d\{1,\}\)\.\(\d\{1,\}\s*\)'
    let major_version_number = matchlist(old_version_line, pattern )[1]
    let minor_version_number = matchlist(old_version_line, pattern )[2]
    let new_minor_version_number = 1
    let new_minor_version_number += minor_version_number
    let new_version_number = major_version_number
    let new_version_number .= "."
    let new_version_number .= new_minor_version_number
    let date = system('date /t')
    let date = substitute(date, '\(.\+20[0-9]\{2,\}\).\+', '\1', "" )
    let Version  = "Version: "
    let Version .= new_version_number
    let Version .= "    "
    let Version .= "Date: "
    let Version .= date
    let Version .= "  "
    let Version .= "By: "
    let Version .= author
    let Version .= "\n"
    let Version .= "    - "
    let Version .= "\n\n"
    execute "normal ".post_above_line."G"
    call setreg("n",Version)
    normal "nP
    call search("-")
    normal A
    startinsert!
endfunction
command! UpdateFunctionHeader call UpdateFunctionHeader()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Create a Schneider Copy Write                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CreateSchneiderCopyWrite()
  let message  = "/*============================================================================*\n"
  let message .= "*                                                                             *\n"
  let message .= "* Copyright COPY_WRITE DATE_TOKEN Schneider Electric Solar Inverters USA Inc.                *\n"
  let message .= "*                                                                             *\n"
  let message .= "* All Rights Reserved. All trademarks are owned by                            *\n"
  let message .= "* Schneider Electric Industries SAS or its affiliated companies.              *\n"
  let message .= "*                                                                             *\n"
  let message .= "==============================================================================*/\n"
  "echom year
  let message = substitute(message, 'DATE_TOKEN', strftime("%Y"), "")
  let message = substitute(message, 'COPY_WRITE', "©", "")
  "echom message
  call setreg('h',message)
  normal "hP
endfunction
command! DoxyCopywrite call CreateSchneiderCopyWrite()

function! CreateSchneiderFileHeader()
  let message = "/**\n"
  let message .= " * @file   FILE_TOKEN\n"
  let message .= " * @author NAME_TOKEN\n"
  let message .= " * @date   DATE_TIME_TOKEN\n"
  let message .= " * @brief:  \n"
  let message .= " * [Back to top level documentation](./index.html)\n"
  let message .= " *          \n"
  let message .= " */\n"
  let message = substitute(message, 'FILE_TOKEN', expand("%:t"), "")
  let message = substitute(message, 'NAME_TOKEN', "Scott Volk", "")
  let message = substitute(message, 'DATE_TIME_TOKEN', strftime("%a, %b %d, %Y"), "")
  echom message
  call setreg('h',message)
  normal "hP
  normal 4jA
endfunction

command! DoxyFileHeader call CreateSchneiderFileHeader()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Create the function header                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CreateCFunctionHeaderFunction()
  normal 0
  normal mz
  " capture the whole function into a string
  " we use the first { to grab the entire function definition
  silent! normal V/{€ku"ay
  " get the contents of the a register
  let function_expression = getreg("a")
  " remove two different new line characters if they exist
  let function_expression = substitute(function_expression, '\n','','')
  let function_expression = substitute(function_expression, '\n','','')
  " remove any 2-or-more-contiguous spaces from the string
  let function_expression = substitute(function_expression, '\s\{2,\}','','')
  " remove the last spaces if they exist
  let function_expression = substitute(function_expression, '\(+.\)\s*','\1',"")
  " remove the last ")"
  let function_expression = substitute(function_expression, ')$','',"")
  "echom function_expression
  " get the first half of the statement, based on the '(' character
  let output_and_function_name = split(function_expression, '(')[0]
  " get the last half of the statement, based on the '(' character
  let output = matchlist(output_and_function_name, '\v(.+) ')[1]
  "echo output
  " get the function name... it's the closest blob to the left of the endof line
  let function_name = matchlist(output_and_function_name, '\v ([a-zA-Z_0-9]+)$')[1]
  "echo function_name
  " now that we have the function name use it in our pattern to get the argument
  " list
  let argument_list_pattern = '\v'.function_name.'\((.+)$'
  "echo argument_list_pattern
  let argument_list = matchlist(function_expression,argument_list_pattern)[1]
  "echo argument_list
  let arguments = split(argument_list,",")
  let empty_stripped_arg_list = []
  for argument in arguments
    "remove the new line from our string if it has one
    let stripped = substitute(argument, '\n', '','' )
    "strip the spaces at the front and end of our string
    let stripped = substitute(stripped, '^\s*\(.\{-}\)\s*$', '\1', '')
    "remove the ) at the end of our string, if it has one
    let stripped = substitute(stripped, '\(.*\))','\1', "" )
    "remove the /n at the end of our string, if it has one
    let stripped = substitute(stripped, '\(.*\)\n','\1', "" )
    call add(empty_stripped_arg_list, stripped)
  endfor
  let arguments = empty_stripped_arg_list
  let bar = "/*============================================================================*/\n"
  let empty = "\n"
  let tab   = "    "
  let header = bar
  let header .= "/*!\n"
  let header .= empty
  let header .= "@brief      ### "
  let header .= function_name . "\n"
  let header .= empty
  "let header .= "\\brief\n"
  "let header .= tab . empty
  "let header .= empty
  let header .= "@param[in]  "
  for argument in arguments
    let header .= "" . argument . "\n"
  endfor
  let header .= empty
  let header .= "@return "
  let header .= tab . output
  let header .= empty
  let header .= empty
  let header .= "@details\n"
  "let header .= tab . empty
  let header .= empty
  let header .= "\\code{.c}\n"
  "let header .= tab . empty
  let header .= empty
  let header .= "REVISION HISTORY:\n"
  let header .= empty
  let header .= "Version: 1.0     Date: " . "DATE_TOKEN" . "  " . "By: " . "DEVELOPER_TOKEN" . "\n"
  let header .= tab . "- Created\n"
  let header .= empty
  let header .= "\\endcode\n"
  let header .= "*/\n"
  let header .= bar
  let date = system('date /t')
  let date   = substitute(date, '\(.\+20[0-9]\{2,\}\).\+', '\1', "" )
  let header = substitute(header, 'DATE_TOKEN', date ,"")
  let header = substitute(header, 'DEVELOPER_TOKEN',"Scott Volk", "")
  call setreg('h',header)
  normal 'z
  normal "hP
  normal 3j
  "normal /#<CR>
  "normal zz
  silent! startinsert!
  normal b
 " echom arguments
endfunction

command! CreateCFunctionHeader call CreateCFunctionHeaderFunction()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Create a c function header                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:GetToken()
    let token = "#"
    let file_name = expand("%:t:r")
    let file_ext  = expand("%:e")
    "echoerr file_name
    if file_name == ".vimrc"
        let token = "\""
    endif
    if file_ext == "c" || file_ext == "h" || file_ext == "cpp"
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
        normal mz
        let diagram_output_file_name = a:diagram_output_file_name
        let diagram_input_file_name  = a:file_in_which_to_write_trace
        call s:write_visual_selection_to_file(diagram_input_file_name)
        " write the trace to file
        let s:this_path = fnamemodify($MYVIMRC, ":h")
        let sequence_path = s:this_path . "/.ruby/sequence.rb"
        "call system("ruby 'C:/Program Files/Vim/.vim/.ruby/sequence.rb' -i ".diagram_input_file_name. " -o " .diagram_output_file_name )
        call system("ruby " . sequence_path . " -i ".diagram_input_file_name. " -o " .diagram_output_file_name )
        " write the trace to the @t register
        "let @t = system("ruby 'C:/Program Files/Vim/.vim/.ruby/sequence.rb' -i ".diagram_input_file_name )
        let @t = system("ruby " . sequence_path . " -i ".diagram_input_file_name )
        normal `>
        normal o
        put! t
        normal `z
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

command! -range TraceToSequenceDiagram call s:call_trace_to_sequence_diagram("trace.txt","sequence_diagram.txt")
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Mappings                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Clip Board Control                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>p "*p
noremap <leader>y "*y
vmap <leader>y "*y
nmap <leader>l 0v$
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Only! But Faster!                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>o :only!<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERDTree hotkeys                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader><leader><leader>f :NERDTreeFind<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Show a Function's Name                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>f :call ShowFuncName() <CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Toggle the tag list                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader><leader>t :TlistToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Book Marking Constrol                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader><leader>m :ToggleBookmark<CR>
nmap <leader><leader>. :NextBookmark<CR>
nmap <leader><leader>, :PreviousBookmark<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Toggle Highlighting                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>h :set hls!<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Change to this file's directory                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>cd :cd %:p:h<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              Controlling the Gvim/Macvim Gui Interface Widgets               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has( "gui_running") && has ("win32")
  nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
  nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
  nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
  :set go-=m
  :set go-=T
  :set go-=r
  au GUIENTER * simalt ~x
elseif has("win32")
  colorscheme darkblue
endif

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
"                            Spell Checker Control                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle spell checker
nmap <leader><C-s> :set spell!<CR>
" Assume that the first spelling is correct, you can uz= if it's not
"
" silent! before the nunmap <buffer> gf
nnoremap <leader>z 1z=<ESC>ea
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           Visually Select the Text that was the last edited/pasted           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap gV `[v`]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Rebuild your ctags tag file                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F12: Rebuild ctags databas:toggleBookmark
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Making a Box                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><leader>b :Boxit<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Line Numbering                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><leader>n :NumbersToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Toggle line wrapping                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
":map <leader><leader>w :set nowrap! <CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             Global Search and Replace for Word Under The Cursor              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F5> :set hls<CR> viwy/0:%s///gc
"nnoremap <F6> :set hls<CR> viwy/0:bufdo %s//change_this/ge \|update
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               Find Occurances of the Current Word In This File               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader><leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       See the most recently used files                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>m :MRU<CR>
"nnoremap <leader>m :b#<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Tabularize your white space                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <leader>ts :Tabularize /^[^ ]*\zs /l0<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          GQ your indented markdown                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vnoremap <leader>gq gqmagvo<<00V`a>><ESC>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Convert this file's markdown to html                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown convertion to html
nmap <leader>md :!maruku % <CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Dancing diff this                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader><leader>d :diffthis <CR><c-w>l :diffthis<CR><c-w>h<CR>gg
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Change this window height to 80                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>k :resize 80<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               Put the file name and path in your yank register               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap fp :let @" = expand("%:p")<CR>
nmap cp :let @" = expand("%")<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Expand and Collapse Folds                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nnoremap <Space> za
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Convert a Trace to a Sequence Diagram                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap <leader><c-t> :TraceToSequenceDiagram<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Source this vimrc file                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>s :source $MYVIMRC<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Strip all trailing whitespace in this file                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"         Automatically align tables using the '|' key in insert mode          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is for automatically aligning tables using the tabular plugin
" Taken from a Tim Pope gist, see https://gist.github.com/tpope/287147
"inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
"inoremap <silent> <Bar> <Bar>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Move Around Windows Quickly                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around windows quickly
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Toggle the Curser Column                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F11: Toggle cursorcolumn
imap <silent> <F11> <ESC>:call ToggleCursorColumn()<CR>a
map <silent> <F11> :call ToggleCursorColumn()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Update the Function Header                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><c-n> :UpdateFunctionHeader<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Close Window or Kill Buffer                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> Q :call CloseWindowOrKillBuffer()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Create C Function Header                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><c-f> :CreateCFunctionHeader<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Toggle the background Color                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F6> :call ToggleBackGroundColor()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Open this vimrc                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>e :e $MYVIMRC<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Select the last pasted text                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gp `[v`]oz.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       Change syntax to tiddlywiki, this is done after using itsalltext       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>t :set syntax=tiddlywiki<CR>
nmap Y v$y
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              NextIndent mapping                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(1, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>

vnoremap <leader><leader>e xi<C-r>=<C-r>"<CR><ESC>

nnoremap <leader>gq 0/*<CR>v/*<CR>k$

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

function! Invoice()
  let s:script_path = 'rake -f ~/.vim/bundle/invoices/Rakefile'
  let s:time_sheet = expand('%:p')
  let s:dollars_per_hour = input("Enter Hourly Rate: ")
  let s:po_number = input("Enter Po Number: ")
  let s:client = input('Enter Client (schneider/artona)" ')
  let s:invoice_number = input("Enter Invoice Number: ")

  if s:client == ""
    let s:client = "schneider"
  elseif s:client == "s"
    let s:client = "schneider"
  endif

  let s:current_directory = expand("%:p:h")
  execute "cd " .expand("%:p:h")
  let s:current_directory = s:current_directory . '/'
  let s:r_command = ""
  let s:r_command = s:r_command . s:script_path
  let s:r_command = s:r_command . " TIME_SHEET=\""
  let s:r_command = s:r_command . s:time_sheet
  let s:r_command = s:r_command . "\" CLIENT=\""
  let s:r_command = s:r_command . s:client
  let s:r_command = s:r_command . "\" PO="
  let s:r_command = s:r_command . s:po_number
  let s:r_command = s:r_command . " RATE_PER_HOUR="
  let s:r_command = s:r_command . s:dollars_per_hour
  let s:r_command = s:r_command . " INVOICE_NUMBER="
  let s:r_command = s:r_command . s:invoice_number

  let s:r_command = s:r_command . " INVOICE_FILE_BASE=\""
  let s:r_command = s:r_command . s:current_directory
  let s:r_command = s:r_command . "\""

  echom s:r_command
  execute "!" . s:r_command
endfunction
" noremap <leader>i :call Invoice()<CR>

" Create a yaml file for refactoring in the current working directory
noremap <leader>yy :call YamlForRefactor()<CR>
" From the current working directory refactor based on the yaml file
noremap <leader>rr :call Refactor()<CR>
nmap [c [czz
nmap ]c ]czz

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            ToggleBackGroundColor                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleBackGroundColor()

  if has("gui_running")
    if(g:colors_name == "solarized")
      if(&g:background=='dark')
        :set background=light
      else
        :set background=dark
      endif

      if(&g:background=='dark')
        :hi IndentGuidesEven  guibg=#002b36 ctermbg=3
        :hi IndentGuidesOdd guibg=#073642 ctermbg=4
      else
        :hi IndentGuidesEven guibg=#fdf6e3 ctermbg=4
        :hi IndentGuidesOdd  guibg=#eee8d5 ctermbg=3
      endif
    endif
  endif
endfunction

if has("gui_running")
  if g:colors_name  == "solarized"
    let g:indent_guides_auto_colors = 0
    let g:indentLine_char = '|'
    if (&g:background=='dark')
      autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=#002b36 ctermbg=3
      autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#073642 ctermbg=4
    else
      autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#fdf6e3 ctermbg=4
      autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#eee8d5 ctermbg=3
    endif
  endif
endif
highlight ColorColumn ctermbg=cyan
call matchadd('ColorColumn','\%81v',100)
nnoremap <leader><leader>b :execute "!cbeautify.py " . expand('%:p')<CR>

command! Path :echo join(split(&path, ","), "\n")
