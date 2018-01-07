""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              This code links the sequence.rb program into nvim.              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Consider the following trace: 
"
" [2013-3-24 12:15:5:201] [00] cTrig->g() d211->d11 
" [2013-3-24 12:15:5:201] [00] cTrig->f() d11->d211 
" [2013-3-24 12:15:5:205] [00] cTrig->e() d211->d11 
" [2013-3-24 12:15:5:206] [00] cTrig->d() d11->d11 
" [2013-3-24 12:15:5:206] [00] cTrig->c() d11->d211 
" [2013-3-24 12:15:5:208] [00] cTrig->b() d211->d211 
" [2013-3-24 12:15:5:209] [00] cTrig->a(Erker!) d211->d211 
"
" Uncomment the above, then select it and type <leader><ctrl-t>
" The following output will be displayed:
"
"[ Chart: 00 ] (?)
"    d211          d11     
"      +----g()---->|
"      |    (?)     |
"      +<---f()-----|
"      |    (?)     |
"      +----e()---->|
"      |    (?)     |
"      |            +            
"      |             \ (?)       
"      |             d()         
"      |             /           
"      |            <            
"      +<---c()-----|
"      |    (?)     |
"      +            |
"       \ (?)       |
"       b()         |
"       /           |
"      <            |
"      +            |
"       \ (?)       |
"       a(Erker!)   |
"       /           |
"      <            |
"


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
function! s:call_trace_to_sequence_diagram(file_in_which_to_write_trace, diagram_output_file_name)
    normal mz
    let diagram_output_file_name = a:diagram_output_file_name
    let diagram_input_file_name  = a:file_in_which_to_write_trace
    call s:write_visual_selection_to_file(diagram_input_file_name)
    " write the trace to file
    call system("ruby '" .$VIMRCHOME.".ruby/sequence.rb' -i ".diagram_input_file_name. " -o " .diagram_output_file_name )
    " write the trace to the @t register
    let @t = system("ruby '".$VIMRCHOME. ".ruby/sequence.rb' -i ".diagram_input_file_name )
    normal `>
    normal o
    put! t
    normal `z
    call search( "?")
    normal zt
    return 0
endfunction

command! -range TraceToSequenceDiagram call s:call_trace_to_sequence_diagram("trace.txt","sequence_diagram.txt")
vnoremap <leader><c-t> :TraceToSequenceDiagram<CR>

