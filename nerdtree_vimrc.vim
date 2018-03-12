""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERDTree hotkeys                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>n :NERDTreeToggle <CR>
nmap <leader><leader>h :NERDTree .<CR>
nmap <leader><leader>f :NERDTreeFind<CR>
"let NERDTreeShowLineNumbers=1
"make sure relative line numbers are used
"autocmd FileType nerdtree setlocal relativenumber

let NERDTreeIgnore = ['\.pyc$', '\.listing$', '\.aux$', '\.maf$' , '\.mtc0$', '\.mtc1$', '\.mtc2$', '\.mtc3$', '\.mtc4$', '\.mtc5$', '\.mtc6$', '\.mtc7$',  '\.mtc8$', '\.mtc9$', '\.mtc10$', '\.mtc11$', '\.mtc12$', '\.mtc13$', '\.mtc14$', '\.mtc15$']

"nmap <leader>l :NERDTreeFromBookmark legend<CR>
