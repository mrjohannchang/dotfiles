set nocompatible

" NeoBundle's configs (1/2) {{{
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}

NeoBundle 'changyuheng/color-scheme-solarized-for-vim'
NeoBundle 'changyuheng/cscope.vim'
NeoBundleLazy 'davidhalter/jedi-vim', {'filetypes': ['python']}
NeoBundle 'honza/vim-snippets'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim'}
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'SirVer/ultisnips'

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
set cursorline

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
noremap <silent><Leader>/ :nohls<CR>
" }}}

" Saving files as root {{{
cmap w!! %!sudo tee > /dev/null %
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
noremap <Leader>t :TagbarToggle<CR>
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

" NeoComplete configs {{{
let g:neocomplete#enable_at_startup = 1
" }}}

" jedi-vim configs {{{
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#popup_select_first = 0
autocmd FileType python setlocal completeopt-=preview
" }}}

" vim-easy-align configs {{{
vnoremap <Enter> :EasyAlign<Enter>
vnoremap <Leader>a <Plug>(EasyAlign)
" }}}

" Unite configs {{{
let g:unite_source_rec_max_cache_files = 0
call unite#custom#source('file_rec,file_rec/async',
            \ 'max_candidates', 0)
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
" }}}

" Tagbar configs {{{
let g:tagbar_left = 1
let g:tagbar_width = 30
noremap <Leader>t :TagbarToggle<CR>
" }}}

" NeoBundle's configs (2/2) {{{
" Should be always at the end
NeoBundleCheck
" }}}
