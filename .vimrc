set nocompatible

if (has("gui_running"))
    highlight normal guifg=gray guibg=black
    set guifont=Inconsolata\ Medium\ 11

    set diffexpr=MyDiff()
    function MyDiff()
        let opt = '-a --binary '
        if (&diffopt =~ 'icase') | let opt = opt . '-i ' | endif
        if (&diffopt =~ 'iwhite') | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if (arg1 =~ ' ') | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if (arg2 =~ ' ') | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if (arg3 =~ ' ') | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if ($VIMRUNTIME =~ ' ')
            if (&sh =~ '\<cmd')
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

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
