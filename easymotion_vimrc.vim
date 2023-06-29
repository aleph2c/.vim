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
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><Leader>l <Plug>(easymotion-lineforward)
map <Leader><Leader>h <Plug>(easymotion-linebackward)
