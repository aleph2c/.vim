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
nnoremap <c-n> :UpdateFunctionHeader<CR>
nnoremap <leader>w :source $VIM/.vim/working.vim<CR>

