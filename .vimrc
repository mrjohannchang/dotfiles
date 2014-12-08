set nocompatible

" Vundle's configs (1/2) {{{
"
" required
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugin on GitHub repo
Plugin 'bling/vim-airline'
Plugin 'changyuheng/color-scheme-holokai-for-vim'
Plugin 'changyuheng/color-scheme-solarized-for-vim'
" Plugin 'changyuheng/cscope.vim'
Plugin 'dsolstad/vim-wombat256i'
Plugin 'fatih/vim-go'
Plugin 'honza/vim-snippets'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'junegunn/vim-easy-align'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'milkypostman/vim-togglelist'
Plugin 'tomasr/molokai'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim'}

Plugin 'sayuan/vimwiki'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'tfnico/vim-gradle'
Plugin 'thinca/vim-template'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line, required
call vundle#end()

" }}}

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
if ($TERM == "screen-256color" || $TERM == "xterm-256color")
    set t_Co=256
endif

if (&t_Co > 255 || has("gui_running"))
    let g:solarized_termcolors = 256
    let g:solarized_termtrans = 1
    set background=light
    colorscheme solarized
endif

set number        " always show line numbers

set hidden

behave xterm
set autoindent    " always set autoindenting on
set autoread
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

set cursorcolumn

" Status bar (Shared by pct) {{{
let s:fancy_status_line_enabled = 0
if s:fancy_status_line_enabled
    set statusline=%4*%<\ %1*[%F]
    set statusline+=%4*\ %5*[%{&encoding}, " encoding
    set statusline+=%{&fileformat}
    set statusline+=%{\"\".((exists(\"+bomb\")\ &&\ &bomb)?\",BOM\":\"\").\"\"}
    set statusline+=]%m%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
    highlight User1 ctermfg=red
    highlight User2 term=underline cterm=underline ctermfg=green
    highlight User3 term=underline cterm=underline ctermfg=yellow
    highlight User4 term=underline cterm=underline ctermfg=white
    highlight User5 ctermfg=cyan
    highlight User7 ctermfg=white
endif
unlet s:fancy_status_line_enabled
" }}}

" Cscope database auto-loading {{{
function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
    endif
endfunction
au BufEnter /* call LoadCscope()
" }}}

" Reselect visual block after indent/outdent {{{
vnoremap < <gv
vnoremap > >gv
" }}}

" Make Y behave like other capitals {{{
map Y y$
" }}}

" Improve up/down movement on wrapped lines {{{
nnoremap j gj
nnoremap k gk
" }}}

" Toggling search highlights {{{
noremap <silent> <Leader>/ :nohls<CR>
" }}}

" Saving files as root {{{
cnoremap w!! %!sudo tee > /dev/null %
" }}}

" Easy split navigation {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" Tagbar configs {{{
let g:tagbar_left = 1
let g:tagbar_width = 30
noremap <silent> <Leader>t :TagbarToggle<CR>
" }}}

" Toggle invisibles (list) {{{
noremap <Leader>i :set list!<CR>
" }}}

" Paste mode toggling configs {{{
" Toggling paste mode outside insert mode "
map <Leader>v :set invpaste<CR>:set paste?<CR>
" Toggling paste mode inside insert mode "
set pastetoggle=<Leader>v
" Turning off paste mode when leaving insert
autocmd InsertLeave * set nopaste
" }}}

" Vimwiki {{{
let g:vimwiki_list = [{
    \ 'path': '~/wikidata/',
    \ 'syntax': 'pandoc',
    \ 'ext': '.page',
    \ 'nested_syntaxes': {
        \ 'c': 'c',
        \ 'cpp': 'cpp',
        \ 'java': 'java',
        \ 'python': 'python',
        \ 'scala': 'scala',
    \ },
\ }]
" }}}

" vim-easy-align configs {{{
vnoremap <Enter> :EasyAlign<Enter>
vnoremap <Leader>a <Plug>(EasyAlign)
" }}}

" vimwiki {{{
let g:vimwiki_list = [{
    \ 'path': '~/wikidata/',
    \ 'syntax': 'pandoc',
    \ 'ext': '.page',
    \ 'nested_syntaxes': {
        \ 'c': 'c',
        \ 'cpp': 'cpp',
        \ 'java': 'java',
        \ 'python': 'python',
        \ 'scala': 'scala',
    \ },
\ }]
" }}}

" NERD Commenter configs {{{
let NERDSpaceDelims=1
" }}}

" vim-airline's configs {{{
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
" }}}

" UltiSnips configs {{{
let g:UltiSnipsExpandTrigger="<c-j>"
" }}}

" Gundo configs {{{
nnoremap U :GundoToggle<CR>
" }}}

" CtrlP configs {{{
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_max_files = 0
let g:ctrlp_regexp = 1
" }}}

" syntastic {{{
let g:syntastic_java_checkers=['checkstyle']
" }}}

" bufExplorer {{{
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSplitBelow=1        " Split new window below current.
" }}}

" Protect your fat fingers from the evils of <F1> {{{
" I can type :help on my own, thanks.
noremap <F1> <Esc>
" }}}

" Better comand-line editing {{{
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" }}}

" Buffergator config {{{
" let g:buffergator_autodismiss_on_select = 0
" let g:buffergator_autoupdate = 1
let g:buffergator_show_full_directory_path = 0
let g:buffergator_suppress_keymaps = 1
let g:buffergator_viewport_split_policy = 'R'
nnoremap <silent> <Leader>b :BuffergatorToggle<CR>
" }}}
