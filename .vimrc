call plug#begin()
Plug 'tomasr/molokai'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-ruby/vim-ruby'
"Plug 'tpope/vim-rails'
"Plug 'slim-template/vim-slim'
Plug 'tpope/vim-endwise'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree', {'on' : 'NERDTreeToggle'}
Plug 'Raimondi/delimitMate'
Plug 'Shougo/neocomplcache.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
call plug#end()

"----------------------------------------------------------------
autocmd FileType text setlocal textwidth=78

autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

autocmd BufNewFile,BufRead *.coffee set filetype=javascript

"----------------------------------------------------------------
if has("gui_running")
    "set guifont=WenQuanYi\ Micro\ Hei\ Mono\ 12
    set guifont=Monaco:h13
endif
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
set fileencoding=utf-8
set nobomb 			"禁止插入bom(byte order mark)符

source $VIMRUNTIME/delmenu.vim "处理菜单及右键菜单乱码
source $VIMRUNTIME/menu.vim
"language messages zh_CN.UTF-8 "处理consle输出乱码

set nocompatible 	"去除vi兼容
set showcmd 		"显示命令输入
set backspace=indent,eol,start
set magic
set nu				"显示行号
set tabstop=4		"设置tab键的长度
set shiftwidth=4	"换行时缩进4个空格
set expandtab		"用空格代替tab
set autoindent		"自动对齐
set smartindent		"智能对齐方式
set ai				"设置自动缩进
set showmatch		"设置匹配模式，当输入一个左括号时会自动匹配右括号
set ruler 			"编辑过程中右下角显示光标位置的状态行
set incsearch		"方便查询，如查book当输入/b时，会自动找到/b开关
set hlsearch
set nobackup 		"禁止备份
set noswapfile 		"禁止备份
set dy=lastline		"显示最多行，不用@@
set ignorecase smartcase "智能匹配大小写
set clipboard=unnamed,unnamedplus "共享系统剪贴板
set go=
set fdm=marker
set laststatus=2	"总是显示状态类
set t_Co=256
let mapleader = ","
noremap \ ,
colo molokai

set autochdir
lcd %:p:h   		"进入打开文件的目录

set undofile
set undodir=~/.cache/vim/undo
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir),"p")
endif

" 显示tab和空格
"set list
set mouse=a

"----------------------------------------------------------------
"切换标签页快捷键
nnoremap H gT
nnoremap L gt
nnoremap <leader>t :tabnew<space>

"选择刚粘贴(或改变)的内容
nnoremap <leader>v V`]

"以下配置插入模式下快捷键:
inoremap <c-j> <esc>
vnoremap <c-j> <esc>
cnoremap <c-j> <c-c>

"打开水平分割窗口
nnoremap <leader>w <c-w>v<c-w>l

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <F2> :NERDTreeToggle<CR>

"----------------------------------------------------------------
"自动开启neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_max_list = 8
let g:neocomplcache_auto_completion_start_length = 3

"ctrlp
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_root_markers = ['config','license.txt']
