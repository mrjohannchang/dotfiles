set nocompatible

syntax on
filetype on
filetype plugin on
filetype indent on

set background=dark
set number        " always show line numbers

set hidden

behave xterm
set autoindent    " always set autoindenting on
set backspace=start,indent,eol
set softtabstop=4
"set copyindent    " copy the previous indentation on autoindenting
set nowrap
set expandtab
set shiftwidth=4
set tabstop=4

set fileencodings=utf-8,big5,gbk,cp936,iso-2022-jp,sjis,euc-jp,euc-kr,utf-bom,iso8859-1
set fileencoding=utf-8

set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set list
set listchars=tab:\»\ ,trail:░

set laststatus=2

set wildmenu
set wildmode=list:longest
