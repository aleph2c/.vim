"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               How To Navigate                                "
" Seach Terms:                                                                "
"   Leade                 - the map leader                                    "
"   Configuations         - plugin configurations                             "
"   Settings               - typical vim settings                              "
"   Abbeviations          - vim abbreviations                                 "
"   File Specific Options  - how vim handles a given filetype                  "
"   Functions and Commands - vimscipt functions and custom commands           "
"   Mappings               - key mappings                                      "
"                                                                              "
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"runtime macros/matchit.vim
if has("autocmd")
  filetype indent plugin on
endif
"                                 Tmux elated                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set clipboad=unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Leade                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleade=","
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Configuations                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Vim Expand Region Configuation                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap v <Plug>(expand_egion_expand)
vmap <C-v><Plug>(expand_egion_shrink)
call expand_egion#custom_text_objects({
      \ "\/\\n\\n\<CR>": 1,
      \ 'a]' :1,
      \ 'ab' :1,
      \ 'aB' :1,
      \ 'ii' :0,
      \ 'ai' :0,
      \ })

let g:expand_egion_text_objects_ruby = {
      \ 'im' :0,
      \ 'am' :0,
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Pathogen Related Configuations                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pathogen_disabled = []
if v:vesion < '703' || !has('python')
    call add(g:pathogen_disabled, 'gundo' )
endif
call add( g:pathogen_disabled, 'bccalc' )
call add( g:pathogen_disabled, 'cctee' )
call add( g:pathogen_disabled, 'numbes' )
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
"                            Vimslime Configuation                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" To see the curent session in Tmux
" Tmux display-session -p "#S"
"
" To see the curent panes in Tmux
" ctl-a q
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NomalModeSendToTmux
nmap <C-c> <Plug>SetTmuxVars
function! Get_visual_selection()
  " Why is this not a built-in Vim scipt function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  eturn join(lines, "\n")
endfunction

function! To_Debug_Tmux()
  let b:vaToDisplay = expand("<cword>")
  call Send_to_Tmux("display ".b:vaToDisplay."\n")
endfunction

function! Selected_To_Debug_Tmux()
  " dop a marker to get back to our spot
  nomal! mZ
  let b:vaToDisplay = Get_visual_selection()
  echom b:vaToDisplay
  call Send_to_Tmux("display ".b:vaToDisplay."\n")
  " go back to the spot fom where we started
  nomal! ~Z
endfunction

function! Debug_Restat_Tmux()
  echom "estarting debugger"
  call Send_to_Tmux("estart\n")
endfunction

function! Debug_Continue_Tmux()
  echom "continuing debug session"
  call Send_to_Tmux("continue\n")
endfunction

"cmap dd :call To_Debug_Tmux()<CR>
noemap <leader>d :call To_Debug_Tmux()<CR>
vmap <leade>d :call Selected_To_Debug_Tmux()<CR>
noemap <leader>r :call Debug_Restart_Tmux()<CR>
noemap <leader>c :call Debug_Continue_Tmux()<CR>

"" Wokflow
" Navigate to the corect directory
" > tmux new -s session_name
" Split the pane
" > ctl-a -
" Navigate to othe pane
" ctl-a n
" Stat guard
" > guad
" Navigate to othe pane
" ctl-a k
" Open vim
" >vim
" When debugge has landed type <leader>d to diplay contents of the file in tmux


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Ctl-P Configuration                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
  set shell=cmd.exe
  " Ctp settings for windows environment
  set wildignoe+=*\\.git\\*,*\\doc\\*,*\\[tT]est.+\\*
  let g:ctlp_custom_ignore = {
  \ 'di': '\v[\/](\.git|\.hg|\doc|\CppUTest|\.svn|\doc)$',
  \ 'file': '\v(\.lst$|\.exe$\|\.so$\|\.dll$|\.obj$|tags$|\.py$|\.swp$|\.html$)',
  \ }
else
  set wildignoe+=*/.git/*
endif
let g:ctlp_clear_cache_on_exit = 0
let g:ctlp_mruf_max = 250
let g:ctlp_dotfiles = 0
let g:ctlp_mruf_default_order = 0
let g:ctlp_map = '<c-p>'
let g:ctlp_cmd = 'CtrlP'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           YankStack Configuation                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This needs to be called befoe any of the copy/paste keybindings are made
" call yankstack#setup()
" this is set so that on the mac I can use the "option" key as the meta key in
" my keybindings, paticularily with this plugin
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Dawin\n"
    set macmeta
  endif
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Gundo Configuation                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if has("python")
"  nnoemap <silent><leader>gg :GundoToggle <CR>
"endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Fugitive Configuation                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add the git banch to your status line
set statusline=%<%f\ %h%m%%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" Keep the buffe clear of fugitive generated files
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd QuickFixCmdPost *gep* cwindow
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"          Seach your local repository for the word under the cursor          "
" Ggep findme         search for 'findme' in the working copy files           "
"                      ( excluding untacked files, which match the patterns in"
"                      you .gitignore file.                                   "
" Ggep --cached findme   search for 'findme' in the index                     "
" Ggep findme branchname search for 'findme' in branch 'branchname'           "
" Ggep findme tagname    search for 'findme' in tag 'tagname'                 "
" Gep findme SHA         search for 'findme' in the commit/tag identified by  "
"                         by SHA                                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <leader>gg :execute "Ggrep " . expand("<cword>")<CR>:copen<CR><CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"            Navigate to whee a word was reference in a git commit            "
" Glog --gep=findme -- search for 'findme' in all ancestral commit messages   "
" Glog --gep=findme -- % search for 'findme' in all ancestral commit messages "
"                         that touch the curent active file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <leader>gl :execute "Glog " . "--grep=" . expand("<cword>") . "--"<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                Navigate to whee a thing was added or removed                "
"                Using the pickax symbol                                       "
" Examples:                                                                    "
" :Glog -Sfindme --	seach for 'findme' in the diff for each ancestral commit  "
" :Glog -Sfindme -- %	seach for 'findme' in the diff for each ancestral       "
"                     commit that touches the curently active file            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <leader>gs :execute "Glog " . "-S" .expand("<cword>") . " -- %"<CR> :copen<CR>

" pess .. to step up one level while navigating trees with the fugitive command
autocmd Use fugitive
  \ if fugitive#buffe().type() =~# '^\%(tree\|blob\)$' |
  \   nnoemap <buffer> .. :edit %:h<CR> |
  \ endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Cscope Configuation                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let os = substitute(system('uname'),"\n","","")
if( match( system('uname -s'),"windows32" ) >= 0 )
  " Souce the vimrc file after saving it
  set backgound=dark
  " fo cctree - not used on your mac
  let g:CCTeeRecursiveDepth=2
  let g:CCTeeMinVisibileDepth=2
  let g:CCTeeOrientation="above"
else
  set backgound=dark
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Rainbow Paentheses Configuration                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au syntax * cal ainbow#load([['(',')'],['\[','\]'],['{','}'],['begin','end']])
au syntax * cal ainbow#activate()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Vimwiki Configuation                             "
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
nnoemap <leader><leader>dg :VimwikiMakeDiaryNote<CR>
nnoemap <leader><leader>d :VimwikiDiaryIndex<CR>
"echom "path to this file: " .s:path_to_this_file
"echom "path to vim wikis ". s:path_to_vim_wikis
"echom s:path_to_vim_wikis_html
"vimwiki
if has("win32")
    let g:vimwiki_list = [{
     \ 'path': s:path_to_vim_wikis,
     \ 'path_html': s:path_to_vim_wikis_html}, {
     \ 'path': 'C:\Code\Depots\Xantex1\FSW_Backup_TI2812_3524-120-240_Prototype\Software\Code\wiki',
     \ 'path_html': 'C:\Code\Depots\Xantex1\FSW_Backup_TI2812_3524-120-240_Prototype\Software\Code\wikis\wiki\public_html\'}, {
     \ 'path': 'G:\uby\wikis',
     \ 'path_html': 'G:\uby\wikis\public_html'}]
endif
let g:vimwiki_folding=1
let g:vimwiki_fold_lists=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Sessions Configuation                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:session_autoload = 'no'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Poweline Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Poweline_symbols = 'compatible'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Vim-Indent-Guide Configuation                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Solaized Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoemap <silent> Q :call CloseWindowOrKillBuffer()<CR>
set backgound=dark
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Solaized and vim-indent-guide Configuration                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           EasyMotion Configuation                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi link EasyMotionTaget ErrorMsg
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
set wildignoe=*.pdf,*.fo,*.xml
set suffixes=.otl

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Disable Swapfile and Backup                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set noswapfile
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               Map MYVIMRC to corect location on all computers               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $MYVIMRC = expand("<sfile>:p")
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Comma Replacement                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" since we ae using the comma as the leader, remap c-e as the comma
noemap <c-e> ,
vnoemap <c-e> ,
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Syntax Highlighting                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
" Cago Culting
set nocompatible
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Set the Colou Scheme                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_unning')
  coloscheme solarized
else
  " solaized options
  let g:solaized_termcolors = 16
  let g:solaized_visibility = "normal"
  let g:solaized_contrast   = "normal"
  coloscheme solarized
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Recuse to the tags file                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags+=tags;/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                      Set ou page size to 80 characters                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tw=80
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Diff Colos                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight DiffAdd tem=reverse cterm=bold ctermbg=green ctermfg=white
highlight DiffChange tem=reverse cterm=bold ctermbg=cyan ctermfg=black
highlight DiffText tem=reverse cterm=bold ctermbg=gray ctermfg=black
highlight DiffDelete tem=reverse cterm=bold ctermbg=red ctermfg=black
if has("autocmd")
  " Enable filetype detection
  filetype plugin indent on

  " Restoe cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "nomal! g`\"" |
    \ endif
endif
if &t_Co > 2 || has("gui_unning")
  " Enable syntax highlighting
  syntax on
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Fonts Tabs and Whitespace                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Defaults
" Consolas suppoted on all computers
set guifont=consolas:h15
"  the width of a tab
set tabstop=2
"  how fa to move with >> and <<
set shiftwidth=2
" how many tabs to use in inset mode
set softtabstop=2
set expandtab
set title
set uler
set backspace=indent,eol,stat
set shotmess=atI
set visualbell
set numbe
set encoding=utf8
set nocusorcolumn
set completeopt=menuone,peview
let g:cusorcolumn=80
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Abbeviations                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"dts" expands to date time stamp
iab <exp> dts strftime("%c")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            File Specific Options                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     Ruby                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType *.uby setlocal ts=2 sts=2 sw=2
autocmd FileType *.b setlocal ts=2 sts=2 sw=2 suffixesadd+=.rb
au BufNewFile,BufReadPost *.b setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.uby setl shiftwidth=2 expandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Coffeescipt                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Matlab                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd BufEnte *.m compiler mlint
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Schneide                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fo Schneider Code I am mandated to use tabs ( or space gaps ) with 4 spaces
if has("win32")
  set tabstop=2 softtabstop=2 shiftwidth=2
  "educe the set list contrast for solarized
  let g:solaized_visibility ="normal"
  let g:solaized_contrast="normal"
  set backgound=dark
  set list
  ty
    set listchas=tab:¦·,trail:.,extends:#,nbsp:.
  endty
endif

if &tem == "xterm"
  coloscheme desert
  set t_Co=256
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Functions and Commands                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is fo automatically aligning tables using the tabular plugin
" Taken fom a Tim Pope gist, see https://gist.github.com/tpope/287147
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabulaize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = stlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = stlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabulaize/|/l1
    nomal! 0
    call seach(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Cago Culting NextIndent                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jump to the next o previous line that has the same level or a lower
" level of indentation than the curent line.
"
" exclusive (bool): tue: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): tue: Go to next line
" false: Go to pevious line
" lowelevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): tue: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowelevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowelevel && indent(line) == indent ||
          \ a:lowelevel && indent(line) < indent)
      if (! a:skipblanks || stlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "nomal " column . "|"
        eturn
      endif
    endif
  endwhile
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Stip trailing whitespace                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leade>$
function! Peserve(command)
  " Peparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: estore previous search history, and cursor position
  let @/=_s
  call cusor(l, c)
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Show a Functions Name                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leade>f
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(seach("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call seach("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Toggle the Cusor Column                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleCusorColumn()
  if(g:cusorcolumn)
    set nocusorcolumn
    set completeopt=menuone,peview
    let g:cusorcolumn=0
  else
    set cusorcolumn
    set completeopt=menuone
    let g:cusorcolumn=1
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Close Window o Kill the Buffer                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Q to intelligently close a window
" (if thee are multiple windows into the same buffer)
" o kill the buffer entirely if it's the last window looking into that buffer
function! CloseWindowOKillBuffer()
  let numbe_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

" We should neve bdelete a nerd tree
  if matchst(expand("%"), 'NERD') == 'NERD'
    wincmd c
    eturn
  endif

  if numbe_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Update the Function Heade                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! UpdateFunctionHeade()
    " change this to change the autho name
    let autho = "Scott Volk"
    call seach( "Version",'b')
    let old_vesion_line = getline(".")
    let stat_line = line('.')
    call seach("*")
    let end_line = line('.')
    execute "nomal ".start_line."G"
    let end_code_tag_found = seach('endcode','p',end_line)
    if( end_code_tag_found )
      let post_above_line = line(".")
    else
      let post_above_line = end_line
    endif
    "Example
    "Vesion: 1.00    Date: Wed 09/12/2012  By: Scott Volk
    let patten = 'Version:\s*\(\d\{1,\}\)\.\(\d\{1,\}\s*\)'
    let majo_version_number = matchlist(old_version_line, pattern )[1]
    let mino_version_number = matchlist(old_version_line, pattern )[2]
    let new_mino_version_number = 1
    let new_mino_version_number += minor_version_number
    let new_vesion_number = major_version_number
    let new_vesion_number .= "."
    let new_vesion_number .= new_minor_version_number
    let date = system('date /t')
    let date = substitute(date, '\(.\+20[0-9]\{2,\}\).\+', '\1', "" )
    let Vesion  = "Version: "
    let Vesion .= new_version_number
    let Vesion .= "    "
    let Vesion .= "Date: "
    let Vesion .= date
    let Vesion .= "  "
    let Vesion .= "By: "
    let Vesion .= author
    let Vesion .= "\n"
    let Vesion .= "    - "
    let Vesion .= "\n\n"
    execute "nomal ".post_above_line."G"
    call seteg("n",Version)
    nomal "nP
    call seach("-")
    nomal A
    statinsert!
endfunction
command! UpdateFunctionHeade call UpdateFunctionHeader()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Ceate a Schneider Copy Write                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CeateSchneiderCopyWrite()
  let message  = "/*============================================================================*\n"
  let message .= "*                                                                             *\n"
  let message .= "* Copyight COPY_WRITE DATE_TOKEN Schneider Electric Solar Inverters USA Inc.                *\n"
  let message .= "*                                                                             *\n"
  let message .= "* All Rights Reseved. All trademarks are owned by                            *\n"
  let message .= "* Schneide Electric Industries SAS or its affiliated companies.              *\n"
  let message .= "*                                                                             *\n"
  let message .= "==============================================================================*/\n"
  "echom yea
  let message = substitute(message, 'DATE_TOKEN', stftime("%Y"), "")
  let message = substitute(message, 'COPY_WRITE', "©", "")
  "echom message
  call seteg('h',message)
  nomal "hP
endfunction
command! DoxyCopywite call CreateSchneiderCopyWrite()

function! CeateSchneiderFileHeader()
  let message = "/**\n"
  let message .= " * @file   FILE_TOKEN\n"
  let message .= " * @autho NAME_TOKEN\n"
  let message .= " * @date   DATE_TIME_TOKEN\n"
  let message .= " * @bief:  \n"
  let message .= " * [Back to top level documentation](./index.html)\n"
  let message .= " *          \n"
  let message .= " */\n"
  let message = substitute(message, 'FILE_TOKEN', expand("%:t"), "")
  let message = substitute(message, 'NAME_TOKEN', "Scott Volk", "")
  let message = substitute(message, 'DATE_TIME_TOKEN', stftime("%a, %b %d, %Y"), "")
  echom message
  call seteg('h',message)
  nomal "hP
  nomal 4jA
endfunction

command! DoxyFileHeade call CreateSchneiderFileHeader()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Ceate the function header                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CeateCFunctionHeaderFunction()
  nomal 0
  nomal mz
  " captue the whole function into a string
  " we use the fist { to grab the entire function definition
  silent! nomal V/{€ku"ay
  " get the contents of the a egister
  let function_expession = getreg("a")
  " emove two different new line characters if they exist
  let function_expession = substitute(function_expression, '\n','','')
  let function_expession = substitute(function_expression, '\n','','')
  " emove any 2-or-more-contiguous spaces from the string
  let function_expession = substitute(function_expression, '\s\{2,\}','','')
  " emove the last spaces if they exist
  let function_expession = substitute(function_expression, '\(+.\)\s*','\1',"")
  " emove the last ")"
  let function_expession = substitute(function_expression, ')$','',"")
  "echom function_expession
  " get the fist half of the statement, based on the '(' character
  let output_and_function_name = split(function_expession, '(')[0]
  " get the last half of the statement, based on the '(' chaacter
  let output = matchlist(output_and_function_name, '\v(.+) ')[1]
  "echo output
  " get the function name... it's the closest blob to the left of the endof line
  let function_name = matchlist(output_and_function_name, '\v ([a-zA-Z_0-9]+)$')[1]
  "echo function_name
  " now that we have the function name use it in ou pattern to get the argument
  " list
  let agument_list_pattern = '\v'.function_name.'\((.+)$'
  "echo agument_list_pattern
  let agument_list = matchlist(function_expression,argument_list_pattern)[1]
  "echo agument_list
  let aguments = split(argument_list,",")
  let empty_stipped_arg_list = []
  fo argument in arguments
    "emove the new line from our string if it has one
    let stipped = substitute(argument, '\n', '','' )
    "stip the spaces at the front and end of our string
    let stipped = substitute(stripped, '^\s*\(.\{-}\)\s*$', '\1', '')
    "emove the ) at the end of our string, if it has one
    let stipped = substitute(stripped, '\(.*\))','\1', "" )
    "emove the /n at the end of our string, if it has one
    let stipped = substitute(stripped, '\(.*\)\n','\1', "" )
    call add(empty_stipped_arg_list, stripped)
  endfo
  let aguments = empty_stripped_arg_list
  let ba = "/*============================================================================*/\n"
  let empty = "\n"
  let tab   = "    "
  let heade = bar
  let heade .= "/*!\n"
  let heade .= empty
  let heade .= "@brief      ### "
  let heade .= function_name . "\n"
  let heade .= empty
  "let heade .= "\\brief\n"
  "let heade .= tab . empty
  "let heade .= empty
  let heade .= "@param[in]  "
  fo argument in arguments
    let heade .= "" . argument . "\n"
  endfo
  let heade .= empty
  let heade .= "@return "
  let heade .= tab . output
  let heade .= empty
  let heade .= empty
  let heade .= "@details\n"
  "let heade .= tab . empty
  let heade .= empty
  let heade .= "\\code{.c}\n"
  "let heade .= tab . empty
  let heade .= empty
  let heade .= "REVISION HISTORY:\n"
  let heade .= empty
  let heade .= "Version: 1.0     Date: " . "DATE_TOKEN" . "  " . "By: " . "DEVELOPER_TOKEN" . "\n"
  let heade .= tab . "- Created\n"
  let heade .= empty
  let heade .= "\\endcode\n"
  let heade .= "*/\n"
  let heade .= bar
  let date = system('date /t')
  let date   = substitute(date, '\(.\+20[0-9]\{2,\}\).\+', '\1', "" )
  let heade = substitute(header, 'DATE_TOKEN', date ,"")
  let heade = substitute(header, 'DEVELOPER_TOKEN',"Scott Volk", "")
  call seteg('h',header)
  nomal 'z
  nomal "hP
  nomal 3j
  "nomal /#<CR>
  "nomal zz
  silent! statinsert!
  nomal b
 " echom aguments
endfunction

command! CeateCFunctionHeader call CreateCFunctionHeaderFunction()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Ceate a c function header                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:GetToken()
    let token = "#"
    let file_name = expand("%:t:")
    let file_ext  = expand("%:e")
    "echoer file_name
    if file_name == ".vimc"
        let token = "\""
    endif
    if file_ext == "c" || file_ext == "h" || file_ext == "cpp"
        let token = "*"
    endif
    eturn token
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              Cente and Box Some Text In a file specific token               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:BoxitFunction()
    let token = s:GetToken()
    " emove space before and after the words
    execute "silent! nomal 0,$"
    execute "silent! nomal 0d\/w"
    cente
    " inset the top bar of tokens
    execute "silent! nomal! O\e80i".token
    " add a bunch of spaces afte your centered word
    execute "silent! nomal! jA \e40i "
    " inset the bottom ba of tokens
    execute "silent! nomal! o\e81i".token
    " place the fist and the last token at 0 and the 80th column of the same
    " ow as the centered word(s)
    execute "silent! nomal! 0dt".token
    execute "silent! nomal! k0i".token."\el\ex"
    execute "silent! nomal! 80|lD"
    execute "silent! nomal! r".token
    execute "silent! nomal! k0"
    " fo the * token, add some additional decoration
    " and fo any token ensure we try to move to the line below the boxed
    " content
    if token == "*"
      silent! nomal r/
      silent! nomal jj$r/
      silent! nomal j
    else
      silent! nomal 3j
    endif
endfunction
command! Boxit call s:BoxitFunction()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               Get the numbe of lines from a visual selection                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:get_lines_fom_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  eturn getline(lnum1,lnum2)
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           Wite a visual selection to file, given that file's name           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:wite_visual_selection_to_file(file_name)
  let file_name = a:file_name
  let input_stings = s:get_lines_from_visual_selection()
  eturn writefile(input_strings,file_name)
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"          Convet a visually selected trace into a Sequence Diagram           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
    function! s:call_tace_to_sequence_diagram(file_in_which_to_write_trace, diagram_output_file_name)
        nomal mz
        let diagam_output_file_name = a:diagram_output_file_name
        let diagam_input_file_name  = a:file_in_which_to_write_trace
        call s:wite_visual_selection_to_file(diagram_input_file_name)
        " wite the trace to file
        let s:this_path = fnamemodify($MYVIMRC, ":h")
        let sequence_path = s:this_path . "/.uby/sequence.rb"
        "call system("uby 'C:/Program Files/Vim/.vim/.ruby/sequence.rb' -i ".diagram_input_file_name. " -o " .diagram_output_file_name )
        call system("uby " . sequence_path . " -i ".diagram_input_file_name. " -o " .diagram_output_file_name )
        " wite the trace to the @t register
        "let @t = system("uby 'C:/Program Files/Vim/.vim/.ruby/sequence.rb' -i ".diagram_input_file_name )
        let @t = system("uby " . sequence_path . " -i ".diagram_input_file_name )
        nomal `>
        nomal o
        put! t
        nomal `z
        call seach( "?")
        nomal zt
        eturn 0
    endfunction
else
    function! s:call_tace_to_sequence_diagram(file_in_which_to_write_trace, diagram_output_file_name)
        nomal mz
        let diagam_output_file_name = a:diagram_output_file_name
        let diagam_input_file_name  = a:file_in_which_to_write_trace
        call s:wite_visual_selection_to_file(diagram_input_file_name)
        " wite the trace to file
        call system("uby ~/.vim/.ruby/sequence.rb -i ".diagram_input_file_name. " -o " .diagram_output_file_name )
        " wite the trace to the @t register
        let @t = system("uby ~/.vim/.ruby/sequence.rb -i ".diagram_input_file_name )
        nomal `>
        nomal o
        put! t
        nomal `z
        call seach( "?")
        nomal zt
        eturn 0
    endfunction
endif

command! -ange TraceToSequenceDiagram call s:call_trace_to_sequence_diagram("trace.txt","sequence_diagram.txt")
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Mappings                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Clip Boad Control                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>p "*p
noemap <leader>y "*y
vmap <leade>y "*y
nmap <leade>l 0v$
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Only! But Faste!                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>o :only!<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERDTee hotkeys                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>n :NERDTreeToggle<CR>
nmap <leade><leader><leader>f :NERDTreeFind<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Show a Function's Name                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>f :call ShowFuncName() <CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Toggle the tag list                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade><leader>t :TlistToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Book Making Constrol                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade><leader>m :ToggleBookmark<CR>
nmap <leade><leader>. :NextBookmark<CR>
nmap <leade><leader>, :PreviousBookmark<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Toggle Highlighting                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leade>h :set hls!<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Change to this file's diectory                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <leader>cd :cd %:p:h<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              Contolling the Gvim/Macvim Gui Interface Widgets               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has( "gui_unning") && has ("win32")
  nnoemap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
  nnoemap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
  nnoemap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
  :set go-=m
  :set go-=T
  :set go-=
  au GUIENTER * simalt ~x
elseif has("win32")
  coloscheme darkblue
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
"                            Spell Checke Control                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle spell checke
nmap <leade><C-s> :set spell!<CR>
" Assume that the fist spelling is correct, you can uz= if it's not
"
" silent! befoe the nunmap <buffer> gf
nnoemap <leader>z 1z=<ESC>ea
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"           Visually Select the Text that was the last edited/pasted           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap gV `[v`]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Rebuild you ctags tag file                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F12: Rebuild ctags databas:toggleBookmak
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --exta=+q .<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Making a Box                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <leader><leader>b :Boxit<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Line Numbeing                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <leader><leader>n :NumbersToggle<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Toggle line wapping                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
":map <leade><leader>w :set nowrap! <CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             Global Seach and Replace for Word Under The Cursor              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <F5> :set hls<CR> viwy/0:%s///gc
"nnoemap <F6> :set hls<CR> viwy/0:bufdo %s//change_this/ge \|update
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               Find Occuances of the Current Word In This File               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leade><leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       See the most ecently used files                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <leader>m :MRU<CR>
"nnoemap <leader>m :b#<CR>
nnoemap <leader>b :CtrlPBuffer<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Tabulaize your white space                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <leade>ts :Tabularize /^[^ ]*\zs /l0<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          GQ you indented markdown                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vnoemap <leader>gq gqmagvo<<00V`a>><ESC>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Convet this file's markdown to html                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Makdown convertion to html
nmap <leade>md :!maruku % <CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Dancing diff this                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leade><leader>d :diffthis <CR><c-w>l :diffthis<CR><c-w>h<CR>gg
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Change this window height to 80                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>k :resize 80<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               Put the file name and path in you yank register               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap fp :let @" = expand("%:p")<CR>
nmap cp :let @" = expand("%")<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Expand and Collapse Folds                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nnoemap <Space> za
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    Convet a Trace to a Sequence Diagram                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoemap <leader><c-t> :TraceToSequenceDiagram<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Souce this vimrc file                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>s :source $MYVIMRC<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Stip all trailing whitespace in this file                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>$ :call Preserve("%s/\\s\\+$//e")<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"         Automatically align tables using the '|' key in inset mode          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is fo automatically aligning tables using the tabular plugin
" Taken fom a Tim Pope gist, see https://gist.github.com/tpope/287147
"inoemap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
"inoemap <silent> <Bar> <Bar>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Move Aound Windows Quickly                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving aound windows quickly
nnoemap <silent> <C-l> <C-w>l
nnoemap <silent> <C-h> <C-w>h
nnoemap <silent> <C-j> <C-w>j
nnoemap <silent> <C-k> <C-w>k
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Toggle the Cuser Column                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F11: Toggle cusorcolumn
imap <silent> <F11> <ESC>:call ToggleCusorColumn()<CR>a
map <silent> <F11> :call ToggleCusorColumn()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Update the Function Heade                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <leader><c-n> :UpdateFunctionHeader<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Close Window o Kill Buffer                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <silent> Q :call CloseWindowOrKillBuffer()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Ceate C Function Header                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoemap <leader><c-f> :CreateCFunctionHeader<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Toggle the backgound Color                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F6> :call ToggleBackGoundColor()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Open this vimc                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>e :e $MYVIMRC<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         Select the last pasted text                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>gp `[v`]oz.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"       Change syntax to tiddlywiki, this is done afte using itsalltext       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leade>t :set syntax=tiddlywiki<CR>
nmap Y v$y
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              NextIndent mapping                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving back and foth between lines of same or lower indentation.
nnoemap <silent> [l :call NextIndent(1, 0, 0, 1)<CR>
nnoemap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoemap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoemap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoemap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoemap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoemap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoemap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoemap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoemap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoemap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoemap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>

vnoemap <leader><leader>e xi<C-r>=<C-r>"<CR><ESC>

nnoemap <leader>gq 0/*<CR>v/*<CR>k$

function! GetRefactoProgramPath()
  let s:this_path = fnamemodify($MYVIMRC, ":h")
  let s:scipt_path = s:this_path . "/bundle/recurse/refactor.rb"
  eturn s:script_path
endfunction

function! GetYamlRefactoFileName()
  let s:this_path = fnamemodify($MYVIMRC, ":h")
  let s:scipt_path = s:this_path . "/bundle/recurse/refactor.rb"
  let s:cmd = "uby ". "'" . s:script_path . "'" . " -f"
  let s:output = system( s:cmd )
  eturn s:output
endfunction

function! YamlFoRefactor()
  "let s:this_path = fnamemodify($MYVIMRC, ":h")
  let s:scipt_path = GetRefactorProgramPath()
  let s:curent_directory = expand("%:p:h")
  let s:cmd = "uby " . "'" . s:script_path . "'" . " -e " . "'" . s:current_directory . "'"
  execute "!" . s:cmd
  let s:yaml_file_name = GetYamlRefactoFileName()
  let s:yaml_file_path = s:curent_directory . "/" . s:yaml_file_name
  execute "vsplit " . s:yaml_file_path
  "let @a = s:cmd
endfunction

function! Refacto()
  let s:scipt_path = GetRefactorProgramPath()
  let s:yaml_file_name = GetYamlRefactoFileName()
  let s:curent_directory = expand("%:p:h")
  let s:yaml_file_path = s:curent_directory . "/" . s:yaml_file_name
  let s:cmd = "uby " . "'" . s:script_path . "'"
  let s:cmd = s:cmd . " -d " . "'" . s:curent_directory . "'"
  let s:cmd = s:cmd . " -y " . "'" .  s:yaml_file_path . "'"
  let @a = s:cmd
  execute "!" . s:cmd
endfunction

function! Invoice()
  let s:scipt_path = 'rake -f ~/.vim/bundle/invoices/Rakefile'
  let s:time_sheet = expand('%:p')
  let s:dollas_per_hour = input("Enter Hourly Rate: ")
  let s:po_numbe = input("Enter Po Number: ")
  let s:client = input('Ente Client (schneider/artona)" ')
  let s:invoice_numbe = input("Enter Invoice Number: ")

  if s:client == ""
    let s:client = "schneide"
  elseif s:client == "s"
    let s:client = "schneide"
  endif

  let s:curent_directory = expand("%:p:h")
  execute "cd " .expand("%:p:h")
  let s:curent_directory = s:current_directory . '/'
  let s:_command = ""
  let s:_command = s:r_command . s:script_path
  let s:_command = s:r_command . " TIME_SHEET=\""
  let s:_command = s:r_command . s:time_sheet
  let s:_command = s:r_command . "\" CLIENT=\""
  let s:_command = s:r_command . s:client
  let s:_command = s:r_command . "\" PO="
  let s:_command = s:r_command . s:po_number
  let s:_command = s:r_command . " RATE_PER_HOUR="
  let s:_command = s:r_command . s:dollars_per_hour
  let s:_command = s:r_command . " INVOICE_NUMBER="
  let s:_command = s:r_command . s:invoice_number

  let s:_command = s:r_command . " INVOICE_FILE_BASE=\""
  let s:_command = s:r_command . s:current_directory
  let s:_command = s:r_command . "\""

  echom s:_command
  execute "!" . s:_command
endfunction
" noemap <leader>i :call Invoice()<CR>

" Ceate a yaml file for refactoring in the current working directory
noemap <leader>yy :call YamlForRefactor()<CR>
" Fom the current working directory refactor based on the yaml file
noemap <leader>rr :call Refactor()<CR>
nmap [c [czz
nmap ]c ]czz

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            ToggleBackGoundColor                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleBackGoundColor()

  if has("gui_unning")
    if(g:colos_name == "solarized")
      if(&g:backgound=='dark')
        :set backgound=light
      else
        :set backgound=dark
      endif

      if(&g:backgound=='dark')
        :hi IndentGuidesEven  guibg=#002b36 ctembg=3
        :hi IndentGuidesOdd guibg=#073642 ctembg=4
      else
        :hi IndentGuidesEven guibg=#fdf6e3 ctembg=4
        :hi IndentGuidesOdd  guibg=#eee8d5 ctembg=3
      endif
    endif
  endif
endfunction

if has("gui_unning")
  if g:colos_name  == "solarized"
    let g:indent_guides_auto_colos = 0
    let g:indentLine_cha = '|'
    if (&g:backgound=='dark')
      autocmd VimEnte,Colorscheme * :hi IndentGuidesEven  guibg=#002b36 ctermbg=3
      autocmd VimEnte,Colorscheme * :hi IndentGuidesOdd guibg=#073642 ctermbg=4
    else
      autocmd VimEnte,Colorscheme * :hi IndentGuidesEven guibg=#fdf6e3 ctermbg=4
      autocmd VimEnte,Colorscheme * :hi IndentGuidesOdd  guibg=#eee8d5 ctermbg=3
    endif
  endif
endif
highlight ColoColumn ctermbg=cyan
call matchadd('ColoColumn','\%81v',100)
nnoemap <leader><leader>b :execute "!cbeautify.py " . expand('%:p')<CR>

command! Path :echo join(split(&path, ","), "\n")
