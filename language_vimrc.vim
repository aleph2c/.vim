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
