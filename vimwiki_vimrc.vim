"let s:path_to_this_file=expand("<sfile>:p:h")
"let s:path_to_vim_wikis = '~\legend\doc\wiki\'
"
" To collapse all headings into the fold: zm
" To expand all headings: zi
" To toggle a fold: <space>
"let g:vimwiki_list = [{ 'path': '~\legend\doc\wiki\' }]
"let g:vimwiki_folding = 1
"
"let g:vimwiki_list = [ { 'syntax': 'markdown', 'ext': '.md', 'path': '/home/pi/projects/confidante/time_tracking/diary.md' } ]

" Vimwiki settings
let g:vimwiki_list          = [
  \ {'syntax' : 'markdown',
  \ 'ext': '.md' ,
  \ 'path': '~/projects/confidante/time_tracking/diary'},
  \ ]
let g:vimwiki_use_calendar=0
