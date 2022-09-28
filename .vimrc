call plug#begin('~/.vim/plugged')
Plug 'amdt/vim-niji'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'previm/previm'
Plug 'vim-python/python-syntax'
"Plug 'vim-latex/vim-latex'
"Plug 'plasticboy/vim-markdown'
call plug#end()

"let g:airline_theme = 'base16_adwaita'
"let g:airline_theme = 'deus'

autocmd BufRead,BufNewFile *.pl set filetype=prolog

colorscheme ron

set encoding=utf-8
set fileencoding=utf-8
set noswapfile
set noerrorbells

set expandtab
set notitle
set number

"syntax on
syntax enable

set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan


"inoremap <silent> jj <esc>
inoremap <silent> jk <esc>

if has('mac')
    inoremap <A-h> <Left>
else
    inoremap <c-h> <Left>
    inoremap <c-j> <Down>
    inoremap <c-k> <Up>
    inoremap <c-l> <Right>
endif

inoremap {<cr> {}<left><cr><esc><s-o>
inoremap (<cr> ()<left><cr><esc><s-o>
inoremap [<cr> []<left><cr><esc><s-o>

inoremap " ""<left>
"inoremap ' ''<left>

noremap <space>h ^
noremap <space>l $

" 行末スペース除く関数
function! Rstrip()
  let s:tmppos = getpos(".")
  if &filetype == "markdown"
    " 行末に2Space以上ある場合は、2spaceまで切り詰める。1spaceなら消去。
    %s/\v(\s{2})?(\s+)?$/\1/e
    match Underlined /\s\{2}$/
  else
    " 行末のspaceを消去
    %s/\v\s+$//e
  endif
  call setpos(".", s:tmppos)
endfunction

" 保存時に行末スペースを取り除く
autocmd BufWritePre * :call Rstrip()
set visualbell
"set laststatus=2
"set t_Co=256

nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

"左側に使用されるセパレータ
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
"右側に使用されるセパレータ
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.crypt = '🔒'		"暗号化されたファイル
let g:airline_symbols.linenr = '¶'			"行
let g:airline_symbols.maxlinenr = '㏑'		"最大行
let g:airline_symbols.branch = '⭠'		"gitブランチ
let g:airline_symbols.paste = 'ρ'			"ペーストモード
let g:airline_symbols.spell = 'Ꞩ'			"スペルチェック
let g:airline_symbols.notexists = '∄'		"gitで管理されていない場合
let g:airline_symbols.whitespace = 'Ξ'	"空白の警告(余分な空白など)
let g:airline_theme = 'papercolor'
set ttimeoutlen=50

set hidden

"let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"execute "set rtp+=" . g:opamshare . "/merlin/vim"

if expand("%:r") == 'Makefile'
  set noexpandtab
endif

autocmd BufNewFile,BufRead *.ino set cindent


let g:previm_open_cmd = '/usr/bin/vivaldi-stable'

" GVim option
set clipboard+=unnamed

set backspace=indent,start,eol

" scroll offset (最終行でなく，その前からスクロール開始)
set scrolloff=5

" vim-python/python-syntax
let g:python_highlight_all = 1

