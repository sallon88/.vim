call pathogen#infect()
syntax on
filetype plugin indent on

"以下三条拷自vimrc_example
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
"以下为新的自定义设置
"设置字体

if has("gui_running")
	set guifont=WenQuanYi\ Micro\ Hei\ Mono\ 11
endif

if has('mouse')
  set mouse=a
endif

"去除vi兼容
set nocompatible
set showcmd "显示命令输入
set backspace=indent,eol,start
set magic	
set nu			"显示行号
set tabstop=4		"设置tab键的长度 
set shiftwidth=4	"换行时缩进4个空格
"set expandtab		"用空格代替tab
set autoindent		"自动对齐
set smartindent		"智能对齐方式
set ai			"设置自动缩进
set showmatch		"设置匹配模式，当输入一个左括号时会自动匹配右括号
set ruler 		"编辑过程中右下角显示光标位置的状态行
set incsearch		"方便查询，如查book当输入/b时，会自动找到/b开关
"set hlsearch
set nobackup 	"禁止备份
set dy=lastline	"显示最多行，不用@@
set ignorecase smartcase "智能匹配大小写
set gdefault "默认本行内替换全部
set go=
"set foldcolumn=3 "左侧四行, 用于显示缩进信息
let mapleader = ","
colo molokai
"colo wombat256
"切换标签页快捷键
:nmap H gT
:nmap L gt

"括号间切换
nnoremap <tab> %
vnoremap <tab> %

"禁用<F1>, 防止误按出帮助
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

inoremap <F2> <ESC>:tabnew ~/.vimrc<CR>
nnoremap <F2> <ESC>:tabnew ~/.vimrc<CR>
vnoremap <F2> <ESC>:tabnew ~/.vimrc<CR>

"nnoremap ; :
nnoremap } <C-]>
nnoremap { <C-t>
nnoremap / /\v
vnoremap / /\v

"查找函数定义处及跳回
nnoremap <leader>f <C-]>
nnoremap <leader>t <C-t>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p

"选择刚粘贴(或改变)的内容
nnoremap <leader>v V`]
"以下两行配置插入模式下快捷键:
",,可快捷退回至normal模式。
"..可快捷将光标移出配对符号如(){}[]""等
:inoremap jj <ESC><Right><Right>
:cnoremap jj <ESC>
:inoremap .. <Right>
:inoremap ,. ..

inoremap <C-o> <C-x><C-o>
"打开水平分割窗口
nnoremap <leader>w <C-w>v<C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-o> <C-x><C-o>


"默认浏览器打开当前编辑的文档
:nnoremap ;f :update<CR>:silent !firefox %:p &<CR>
:nnoremap ;c :update<CR>:silent !/opt/google/chrome/google-chrome %:p &<CR>

"自动插入匹配括号
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
"插入后不回车
:inoremap <leader>{ {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap "" ""<ESC>i
:inoremap '' ''<ESC>i

function! ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
     return "\<Right>"
 else
     return a:char
 endif
endfunction

"设置编码
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,big5,latin1
set fileencoding=utf-8  
set nobomb 					"禁止插入bom(byte order mark)符

source $VIMRUNTIME/delmenu.vim "处理菜单及右键菜单乱码
source $VIMRUNTIME/menu.vim
language messages zh_CN.UTF-8 "处理consle输出乱码

"启用html标签自动补全脚本
":au Filetype html,xhtml,xml,xsl source ~/.vim/closetag.vim
":au Filetype php setlocal dict+=~/.vim/dict/php_function_list.txt

"设置taglist配置 autochdir开启时会影响CommandT的使用
"set tags=tags;
"set autochdir
"首先搜索打开文件所在的目录, 然后搜索当前目录
:set tags=./tags,tags

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1

"winmanager
"let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWindowLayout='NERDTree|TagList'
nnoremap <Leader>wm :WMToggle<CR>

"改变sparkup的字义快捷键,默认为<c-e>
let g:sparkupExecuteMapping = '<leader><tab>'
let g:sparkupNextMapping = '<c-e>'

"supertab 补全方式
let g:SuperTabDefaultCompletionType = 'context'

"加载nerdtree到winmanager
let g:NERDTree_title = "[NERD TREE]"
function! NERDTree_Start()
	exe 'NERDTree'
endfunction

function! NERDTree_IsValid()
	return 1
endfunction

"commandt 快捷键
nnoremap <Leader>g :CommandT<CR>
nnoremap <Leader>c :CommandT<CR>
nnoremap T :CommandT<CR>

"进入打开文件的目录
lcd %:p:h   

"自动开启neocomplcache
let g:neocomplcache_enable_at_startup = 1 
let g:neocomplcache_enable_auto_select = 1 
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_max_list = 8
