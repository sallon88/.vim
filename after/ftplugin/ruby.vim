source ~/.vim/after/ftplugin/eruby.vim
nnoremap <leader><space> :!ruby %<cr>
set foldmethod=syntax
set foldnestmax=5
autocmd BufEnter * exe "normal zR"
