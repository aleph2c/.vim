""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Easymotion Configuration                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_keys             = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_verbose          = 0
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
nmap s <Plug>(easymotion-overwin-f)
"nmap t <Plug>(easymotion-t)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)
