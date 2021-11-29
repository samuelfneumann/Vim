set fileencodings=utf-8
set encoding=utf-8
set title " Set filename in window title bar


" RULER/STATUSLINE --------------------------------------------------------- {{{
set ruler
set rulerformat=%Y\ %=(%l,%c)%V%p%%

hi clear StatusLine " Status line of current window
hi clear StatusLineNC " Status line of non-current window
hi StatusLine cterm=none gui=none term=none
hi StatusLineNC cterm=reverse gui=reverse term=reverse

let g:currentmode={
       \ 'n'  : 'NORMAL',
       \ 'v'  : 'VISUAL',
       \ 'V'  : 'V·Line',
       \ "\<C-V>" : 'V·Block',
       \ 'i'  : 'INSERT',
       \ 'R'  : 'R',
       \ 'Rv' : 'V·Replace',
       \ 'c'  : 'Command',
       \}

set statusline=
set statusline+=\ %n		" buffer number
set statusline+=\ %1*==%{toupper(g:currentmode[mode()])}==\ %*  " mode
set statusline+=%{&ff}		" file format
set statusline+=%y			" file type
set statusline+=\ %<%F   " full path
set statusline+=%-5m		" modified flag
set statusline+=%V       	" right align
set statusline+=%=%5l    	" current line
set statusline+=/%L      	" total lines
set statusline+=%4v\     	" virtual column number
set laststatus=2

hi User1 cterm=bold term=bold gui=bold

"}}}

" VIMSCRIPT -------------------------------------------------------------- {{{
" Set spell check on
set spell spelllang=en_us

" Commands ----------------------------------------------------------------{{{
command! W execute 'w !sudo tee % > /dev/null' <bar> edit! " :W sudo saves file
"}}}

" Maps --------------------------------------------------------------------{{{
:let mapleader="-"
:let localleader="\\"

" inoremap <c-d> <esc>ddi
inoremap jk <esc>
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lell
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lell
nnoremap <leader>() viw<esc>a)<esc>bi(<esc>lell
nnoremap <leader>[] viw<esc>a]<esc>bi[<esc>lell
nnoremap <leader>{} viw<esc>a}<esc>bi{<esc>lell
nnoremap <leader>a g_
nnoremap <leader>i _
vnoremap jk <esc>
vnoremap <leader>" <esc>'>A"<esc>'<I"<esc>
vnoremap <leader>' <esc>'>A'<esc>'<I'<esc>
vnoremap <leader>"" c""<esc>P
vnoremap <leader>'' c''<esc>P
vnoremap <leader>() c()<esc>P
vnoremap <leader>[] c[]<esc>P
vnoremap <leader>{} c{}<esc>P

" Remove arrow keys and esc ------------{{{
inoremap <esc> <nop>
vnoremap <esc> <nop>
noremap <Down> <nop>
noremap <Up> <nop>
noremap <left> <nop>
noremap <right> <nop>
"}}}

" Comment shortcuts ----------------------------------------------------{{{
" In any file, <localleader>c comments line and <localleader>x uncomments line
augroup comments_tabs
    autocmd!
	autocmd FileType julia nnoremap <buffer> <localleader>c :s/^/#<cr>:nohlsearch<cr>
	autocmd FileType julia nnoremap <buffer> <localleader>x :s/^#//<cr>:nohlsearch<cr>
	autocmd FileType julia vnoremap <buffer> <localleader>c :s/^/#<cr>:nohlsearch<cr>
	autocmd FileType julia vnoremap <buffer> <localleader>x :s/^#//<cr>:nohlsearch<cr>
	autocmd FileType go nnoremap <buffer> <localleader>c :s!^!//<cr>:nohlsearch<cr>
	autocmd FileType go nnoremap <buffer> <localleader>x :s!^//!!<cr>:nohlsearch<cr>
	autocmd FileType go vnoremap <buffer> <localleader>c :s!^!//<cr>:nohlsearch<cr>
	autocmd filetype go vnoremap <buffer> <localleader>x :s!^//!!<cr>:nohlsearch<cr>
	autocmd FileType python nnoremap <buffer> <localleader>c :s/^/#<cr>:nohlsearch<cr>
	autocmd filetype python nnoremap <buffer> <localleader>x :s/^#//<cr>:nohlsearch<cr>
	autocmd FileType python vnoremap <buffer> <localleader>c :s/^/#<cr>:nohlsearch<cr>
	autocmd FileType python vnoremap <buffer> <localleader>x :s/^#//<cr>:nohlsearch<cr>
augroup end
"}}}
"}}}

" Abbreviations -----------------------------------------------------------{{{
" Contact abbreviations -----------{{{
iabbrev @@ samuelfneumann@gmail.com
iabbrev u@@ sfneuman@ualberta.ca
iabbrev _name Samuel Frederick Neumann
"}}}

" Syntax abbreviations --------------------------------------------------{{{
" Abbreviations iff -> if, then, else
augroup IfAbbrev
	autocmd!
	autocmd FileType python iabbrev <buffer> iff if:<left>
	autocmd FileType python iabbrev <buffer> eliff elif:<left>
	autocmd FileType python iabbrev <buffer> else else:<cr><left>
	autocmd FileType julia iabbrev <buffer> iff if<cr>end<up>
	autocmd FileType go iabbrev <buffer> iff if{<cr><cr>}<up><up><right>
	autocmd FileType go iabbrev <buffer> if use_iff
	autocmd FileType julia iabbrev <buffer> if use_iff
	autocmd FileType python iabbrev <buffer> if use_iff
	autocmd FileType python iabbrev <buffer> elif use_eliff
augroup end

" Abbreviations ffor -> for; wwh -> while
augroup ForAbbrev
	autocmd!
	autocmd FileType python iabbrev <buffer> ffor for:<left>
	autocmd FileType python iabbrev <buffer> wwh while:<left>
	autocmd FileType julia iabbrev <buffer> ffor for<cr>end<up>
	autocmd FileType julia iabbrev <buffer> wwh while<cr>end<up><right><right>
	autocmd FileType go iabbrev <buffer> ffor for{<cr>}<up><right><right>
	autocmd FileType go iabbrev <buffer> wwh for {<cr><cr>}<up>
	autocmd FileType go iabbrev <buffer> for use_ffor_wwh
	autocmd FileType julia iabbrev <buffer> for use_ffor_wwh
	autocmd FileType python iabbrev <buffer> for use_ffor_wwh
augroup end
	
" Abbreviations for ff -> function
augroup FuncAbbrev
	autocmd!
	autocmd FileType julia iabbrev <buffer> ff function_()<cr>end<cr><up>jk?_<cr>xi
	autocmd FileType python iabbrev <buffer> ff def:<left>
	autocmd FileType go iabbrev <buffer> ff func_() {<cr><cr>}jk?_<cr>xi
	autocmd FileType julia iabbrev <buffer> function use_ff
	autocmd FileType python iabbrev <buffer> def use_ff
	autocmd FileType go iabbrev <buffer> func use_ff
augroup end

" Abbreviations for Python imports
augroup PyImport
    autocmd FileType python iabbrev <buffer> iscipy import scipy
    autocmd FileType python iabbrev <buffer> inumpy import numpy as np
    autocmd FileType python iabbrev <buffer> imatplotlib import matplotlib.pyplot as plt
    autocmd FileType python iabbrev <buffer> ipickle import pickle
    autocmd FileType python iabbrev <buffer> ijson import json
    autocmd FileType python iabbrev <buffer> ijson import json
augroup end
"}}}
"}}}

" General settings -------------------------------------------------{{{
set nocompatible
set showcmd " Show partial commands you type in last line
set showmode " Show mode in last line
" set mouse=a " Allow mouse usage
set ttyfast " Increase scroll speed
set undofile " Use an undofile 

" Bracket matching
set matchpairs+=<:> " Highlight these kinds of brackets as well
set showmatch " Show matching brackets when cursor is over them

" Searching
set hlsearch " Use highlighting when searching
set incsearch " Highlight matching characters as you type

" Use syntax highlighting and line numbers
syntax on
set number

" Set the cursorline
hi clear CursorLine
hi CursorLineNR cterm=bold term=bold
highlight CursorLine cterm=bold term=bold
set cursorline

" Set tabbing
set noexpandtab 
autocmd FileType python set expandtab " PEP8 says to expand tabs
set smarttab
set tabstop=4 " Set tab width to 4 columns
set softtabstop=4
set shiftwidth=4 " Set shift width to 4 spaces
set autoindent
set smartindent

" Scroll N lines past the cursor when scrolling with mouse
set scrolloff=5

" Enable file type detection
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup end
filetype on
filetype plugin on " Use only plugins for this file's type
filetype indent on " Load an indent file for the detected file type

" Auto read when files are changed outside vim
"set autoread
"au FocusGained,BufEnter * checktime

" Enable wildmenu
set wildmenu " Enable auto completion after pressing tab
set wildmode=list:longest " Behave similarly to bash completion

" Set allowable text width
set textwidth=79
augroup GitCommitTextWidth
	" Git commit body should be only 72 characters long
	autocmd!
	autocmd FileType gitcommit setlocal textwidth=72
augroup end
set fo+=t
set fo-=l

" Set the column textwidth+1 to be coloured, and colour any text past this
" bound as red
set colorcolumn=+1
highlight ColorColumn ctermbg=gray guibg=gray ctermfg=red guifg=red
highlight User2 ctermfg=red guifg=red
call matchadd('User2', '\%>80v.\+', 100)
"}}}
"}}}

