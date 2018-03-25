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
"          Convert a visually selected trace into a Sequence Diagram           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
  function! s:call_trace_to_sequence_diagram(file_in_which_to_write_trace, diagram_output_file_name)
      let s:path_to_sequence = 'C:/github/sequence/sequence.rb'
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

