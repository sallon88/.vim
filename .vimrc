call pathogen#infect()
syntax on
filetype plugin indent on

autocmd FileType text setlocal textwidth=78

autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"----------------------------------------------------------------
if has("gui_running")
	set guifont=WenQuanYi\ Micro\ Hei\ Mono\ 11
endif

if has('mouse')
  set mouse=a
endif

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
set fileencoding=utf-8  
set nobomb 			"禁止插入bom(byte order mark)符

source $VIMRUNTIME/delmenu.vim "处理菜单及右键菜单乱码
source $VIMRUNTIME/menu.vim
language messages zh_CN.UTF-8 "处理consle输出乱码

set nocompatible 	"去除vi兼容
set showcmd 		"显示命令输入
set backspace=indent,eol,start
set magic	
set nu				"显示行号
set tabstop=4		"设置tab键的长度 
set shiftwidth=4	"换行时缩进4个空格
"set expandtab		"用空格代替tab
set autoindent		"自动对齐
set smartindent		"智能对齐方式
set ai				"设置自动缩进
set showmatch		"设置匹配模式，当输入一个左括号时会自动匹配右括号
set ruler 			"编辑过程中右下角显示光标位置的状态行
set incsearch		"方便查询，如查book当输入/b时，会自动找到/b开关
set hlsearch
set nobackup 		"禁止备份
set dy=lastline		"显示最多行，不用@@
set ignorecase smartcase "智能匹配大小写
set go=
set fdm=marker
let mapleader = ","
colo molokai

set autochdir
lcd %:p:h   		"进入打开文件的目录

"----------------------------------------------------------------
"切换标签页快捷键
:nmap H gT
:nmap L gt

"禁用<F1>, 防止误按出帮助
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

inoremap <F2> <ESC>:tabnew ~/.vimrc<CR>
nnoremap <F2> <ESC>:tabnew ~/.vimrc<CR>
vnoremap <F2> <ESC>:tabnew ~/.vimrc<CR>

"复制或粘贴到系统缓存
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p

"选择刚粘贴(或改变)的内容
nnoremap <leader>v V`]

"以下配置插入模式下快捷键:
:inoremap <c-j> <ESC>
:vnoremap <c-j> <ESC>
:inoremap <c-l> <right>
:inoremap <c-h> <left>


"打开水平分割窗口
nnoremap <leader>w <c-w>v<c-w>l
nnoremap <leader>s <c-w>s<c-w>j

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l


"默认浏览器打开当前编辑的文档
:nnoremap ;f :update<CR>:silent !firefox %:p &<CR>
:nnoremap ;c :update<CR>:silent !/opt/google/chrome/google-chrome %:p &<CR>

"自动插入匹配括号
:inoremap ( ()<ESC>i
:inoremap { {<CR>}<ESC>O
"插入后不回车
:inoremap <leader>{ {}<ESC>i
:inoremap [ []<ESC>i
:inoremap "" ""<ESC>i
:inoremap '' ''<ESC>i

"----------------------------------------------------------------
nnoremap <Leader>nt :NERDTreeToggle<CR>

"改变sparkup的字义快捷键,默认为<c-e>
let g:sparkupExecuteMapping = '<leader><tab>'
let g:sparkupNextMapping = '<c-e>'

"自动开启neocomplcache
let g:neocomplcache_enable_at_startup = 1 
let g:neocomplcache_enable_auto_select = 1 
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_max_list = 8

"ctrlp
set runtimepath^=~/.vim/bundle/ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 1
let g:ctrlp_root_markers = ['config', '.git']
