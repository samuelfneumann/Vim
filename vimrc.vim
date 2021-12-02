set fileencodings=utf-8,ucs-bom,latin1 " Encodings to try when opening file
set termencoding=utf-8 " The encoding to use to type and display
set encoding=utf-8 " Encoding to use inside of Vim (e.g. in buffers)
set title " Set filename in window title bar


" VIMSCRIPT -------------------------------------------------------------- {{{
" Set spell check on
set spell spelllang=en_us


" Commands ----------------------------------------------------------------{{{
command! W execute 'w !sudo tee % > /dev/null' <bar> edit! " :W sudo saves file
"}}}

" Maps --------------------------------------------------------------------{{{
:let mapleader="-"
:let localleader="\\"

" Terminal Navigation ----------------------------------------------------{{{
" Open the terminal using -[tT]
" <leader>t[hlkj] opens a terminal at the left, right, up, or down pane
" respectively
" <leader>T opens a terminal in a new tab
" <leader>xt exits the terminal
tnoremap <leader>xt exit<cr>
nnoremap <leader>th :term ++close<cr><c-w>H
nnoremap <leader>tl :term ++close<cr><c-w>L
nnoremap <leader>tk :term ++close<cr><c-w>K
nnoremap <leader>tj :term ++close<cr><c-w>J
tnoremap <leader>th <c-w>:term ++close<cr><c-w>H
tnoremap <leader>tl <c-w>:term ++close<cr><c-w>L
tnoremap <leader>tk <c-w>:term ++close<cr><c-w>K
tnoremap <leader>tj <c-w>:term ++close<cr><c-w>J
vnoremap <leader>T :tab term ++close<cr>
nnoremap <leader>T :tab term ++close<cr>
"}}}

" Tab navigation ----------------------------------------------------------{{{
noremap <leader>tn :tabn<cr>
noremap <leader>tp :tabp<cr> 
noremap <leader>tg :tabfirst<cr> 
noremap <leader>tG :tablast<cr>
tnoremap <leader>tn <c-w>:tabn<cr>
tnoremap <leader>tp <c-w>:tabp<cr>
tnoremap <leader>tg <c-w>:tabfirst<cr>
tnoremap <leader>tG <c-w>:tablast<cr>
"}}}

" Window navigation
noremap <leader>+ <c-w>+
noremap <leader>- <c-w>-
noremap <leader>> <c-w>>
noremap <leader>< <c-w><
noremap <leader>= <c-w>=

" Remap the <esc> key
inoremap jk <esc>
vnoremap jk <esc>
tnoremap jk <esc>

" Edit and source vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Wrap text in ", ', (), [], or {}
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lell
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lell
nnoremap <leader>() viw<esc>a)<esc>bi(<esc>lell
nnoremap <leader>[] viw<esc>a]<esc>bi[<esc>lell
nnoremap <leader>{} viw<esc>a}<esc>bi{<esc>lell
vnoremap <leader>" <esc>'>A"<esc>'<I"<esc>
vnoremap <leader>' <esc>'>A'<esc>'<I'<esc>
vnoremap <leader>"" c""<esc>P
vnoremap <leader>'' c''<esc>P
vnoremap <leader>() c()<esc>P
vnoremap <leader>[] c[]<esc>P
vnoremap <leader>{} c{}<esc>P

" Move to beginning or end of line
nnoremap <leader>a g_
nnoremap <leader>i _

" Place/remove semi-colon at line end without moving the curson
nnoremap <leader>; :execute "normal! mqA;\e`q"<cr>
nnoremap <leader>x; :execute "normal! mq:s/;$//\e`q"<cr>:nohlsearch<cr>

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
augroup CommentsAndTabs
    autocmd!
	autocmd FileType julia nnoremap <buffer> <localleader>c :execute "normal! mqI# \e`q"<cr>
	autocmd FileType julia nnoremap <buffer> <localleader>x :s/\v# {0,1}//<cr>:nohlsearch<cr>
	autocmd FileType julia vnoremap <buffer> <localleader>c :s/^/#<cr>:nohlsearch<cr>
	autocmd FileType julia vnoremap <buffer> <localleader>x :s/^#/ /<cr>:nohlsearch<cr>
	autocmd FileType go nnoremap <buffer> <localleader>c :execute "normal!mqI// \e`q"<cr>
	autocmd FileType go nnoremap <buffer> <localleader>x :s!\v// {0,1}!!<cr>:nohlsearch<cr>
	autocmd FileType go vnoremap <buffer> <localleader>c :s!^!//<cr>:nohlsearch<cr>
	autocmd Filetype go vnoremap <buffer> <localleader>x :s!^//!  !<cr>:nohlsearch<cr>
	autocmd FileType python nnoremap <buffer> <localleader>c :execute "normal! mqI# \e`q"<cr>
	autocmd Filetype python nnoremap <buffer> <localleader>x :s/\v# {0,1}//<cr>:nohlsearch<cr>
	autocmd FileType python vnoremap <buffer> <localleader>c :s/^/#<cr>:nohlsearch<cr>
	autocmd FileType python vnoremap <buffer> <localleader>x :s/^#/ /<cr>:nohlsearch<cr>
	autocmd FileType vim nnoremap <buffer> <localleader>c :execute "normal! mqI\" \e`q"<cr>
	autocmd Filetype vim nnoremap <buffer> <localleader>x :s/\v" {0,1}//<cr>:nohlsearch<cr>
	autocmd FileType vim vnoremap <buffer> <localleader>c :s/^/"<cr>:nohlsearch<cr>
	autocmd FileType vim vnoremap <buffer> <localleader>x :s/^"/ /<cr>:nohlsearch<cr>
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
	autocmd FileType julia iabbrev <buffer> if if<cr>end<up>
	autocmd FileType julia iabbrev <buffer> elseif else if<cr><up>
	autocmd FileType go iabbrev <buffer> if if{<cr><cr>}<up><up><right>
	autocmd FileType python iabbrev <buffer> if if:<left>
	autocmd FileType python iabbrev <buffer> elif elif:<left>
	autocmd FileType python iabbrev <buffer> else else:<cr><left>
	autocmd FileType vim iabbrev <buffer> if if<cr>endif<up>
augroup end

" Abbreviations ffor -> for; wwh -> while
augroup ForAbbrev
	autocmd!
	autocmd FileType julia iabbrev <buffer> for use_ffor_wwh
	autocmd FileType julia iabbrev <buffer> ffor for<cr>end<up>
	autocmd FileType julia iabbrev <buffer> wwh while<cr>end<up><right><right>
	autocmd FileType go iabbrev <buffer> ffor for{<cr>}<up><right><right>
	autocmd FileType go iabbrev <buffer> wwh for {<cr><cr>}<up>
	autocmd FileType go iabbrev <buffer> for use_ffor_wwh
	autocmd FileType python iabbrev <buffer> for use_ffor_wwh
	autocmd FileType python iabbrev <buffer> ffor for:<left>
	autocmd FileType python iabbrev <buffer> wwh while:<left>
	autocmd FileType vim iabbrev <buffer> ffor for<cr>endfor<up>
	autocmd FileType vim iabbrev <buffer> for use_ffor
augroup end
	
" Abbreviations for ff -> function
augroup FuncAbbrev
	autocmd!
	autocmd FileType julia iabbrev <buffer> function use_ff
	autocmd FileType julia iabbrev <buffer> ff function_()<cr>end<up>jk?_<cr>xi
	autocmd FileType go iabbrev <buffer> ff func_() {<cr><cr>}jk?_<cr>xi
	autocmd FileType go iabbrev <buffer> func use_ff
	autocmd FileType python iabbrev <buffer> ff def:<left>
	autocmd FileType python iabbrev <buffer> def use_ff
	autocmd FileType vim iabbrev <buffer> ff function_()<cr>endfunction<up>jk?_<cr>xi
	autocmd FileType vim iabbrev <buffer> function use_ff
augroup end

" Abbreviations for Python imports -----------------------------{{{
augroup PyImport
	autocmd!
    autocmd FileType python iabbrev <buffer> iscipy import scipy
    autocmd FileType python iabbrev <buffer> inumpy import numpy as np
    autocmd FileType python iabbrev <buffer> imatplotlib import matplotlib.pyplot as plt
    autocmd FileType python iabbrev <buffer> ipickle import pickle
    autocmd FileType python iabbrev <buffer> ijson import json
	autocmd FileType python iabbrev <buffer> ios import os
	autocmd FileType python iabbrev <buffer> iosp from os import path
	autocmd FileType python iabbrev <buffer> iseaborn import seaborn as sns
augroup end
"}}}

"}}}
"}}}

" General settings -------------------------------------------------{{{
set nocompatible 
set showcmd " Show partial commands you type in last line
set showmode " Show mode in last line
" set mouse=a " Allow mouse usage
set ttyfast " Increase scroll speed
set undofile " Use an undofile 
set magic " Use magic for escape characters

" Bracket matching
set matchpairs+=<:> " Highlight these kinds of brackets as well
set showmatch " Show matching brackets when cursor is over them

" Searching
set hlsearch " Use highlighting when searching
set incsearch " Highlight matching characters as you type

" Use syntax highlighting and line numbers
syntax on
set number

" Auto read when files are changed outside vim
"set autoread
"au FocusGained,BufEnter * checktime

" Enable wildmenu
set wildmenu " Enable auto completion after pressing tab
set wildmode=list:longest " Behave similarly to bash completion

" Scroll N lines past the cursor when scrolling with mouse
set scrolloff=5

" Ruler/StatusLine -------------------------------------------------------- {{{
set ruler
set rulerformat=%Y\ %=(%l,%c)%V%p%% " Disappears if statusline is on

" Set colour of statusLine based on macOS appearance -----------------------{{{

" LightOrDark returns if the operating system appearance on macOS is light
" (true) or dark (false)
function LightOrDark()
	let output =  system("defaults read -g AppleInterfaceStyle")

	" Set if OS appearance is light or dark
	let light_not_dark=1
	if v:shell_error != 0
		" Light theme
		let light_not_dark=1
	else    
		" Dark theme
		let light_not_dark=0
	endif
	return light_not_dark
endfunction

" SetStatusLineColour sets the status line colour based on the appearance of
" the operating system
function SetStatusLineColour()
	hi clear StatusLine " Clear status line of current window
	hi clear StatusLineNC " Clear status line of non-current window
	hi clear StatusLineTerm " Clear status line of current terminal
	hi clear StatusLineTermNC " Clear status line of non-current terminal

	let light_not_dark = LightOrDark()
	if light_not_dark
		hi StatusLine cterm=none gui=none term=none ctermbg=darkgray
			\ ctermfg=white guibg=darkgray "guifg=white
		hi StatusLineNC cterm=none gui=none term=none

		" Set User1 colour, used for the current mode in the statusline
		hi User1 cterm=bold term=bold gui=bold ctermbg=darkgray ctermfg=white
			\ guibg=darkgray guifg=white
		
		"Manually set the statusline for the terminal, since still in beta in
		" vim 8.1
		hi StatusLineTerm cterm=none gui=none term=none ctermbg=green 
			\ ctermfg=white guibg=green guifg=white
		hi StatusLineTermNC cterm=none gui=none term=none ctermbg=darkgreen 
			\ ctermfg=white guibg=darkgreen guifg=white
		return
	else
		hi StatusLine cterm=none gui=none term=none ctermbg=gray ctermfg=black
			\ guibg=gray guifg=black
		hi StatusLineNC cterm=none gui=none term=none
		
		" Set User1 colour, used for the current mode in the statusline
		hi User1 cterm=bold term=bold gui=bold ctermbg=gray ctermfg=black
		
		"Manually set the statusline for the terminal, since still in beta in
		" vim 8.1
		hi StatusLineTerm cterm=none gui=none term=none ctermbg=blue 
			\ ctermfg=white guibg=blue guifg=white
		hi StatusLineTermNC cterm=none gui=none term=none ctermbg=darkblue 
			\ ctermfg=white guibg=darkblue guifg=white
		return
	endif
endfunction

" Only set statusline colour if on macOS (vim version >= 8.0.1630)
let s:uname = trim(system("uname"))
if s:uname==?"Darwin"
	autocmd VimEnter * call SetStatusLineColour()
endif
"}}}

let g:currentmode={
		\ 'n'  : 'NORMAL',
		\ 'v'  : 'VISUAL',
		\ 'V'  : 'V·Line',
		\ "\<C-V>" : 'V·Block',
		\ 'i'  : 'INSERT',
		\ 'R'  : 'R',
		\ 'Rv' : 'V·Replace',
		\ 'c'  : 'Command',
		\ 't'  : 'Terminal',
		\}

set statusline=
set statusline+=\ %n		" buffer number
set statusline+=\ %1*==%{toupper(g:currentmode[mode()])}==\%*" mode
set statusline+=\ %{&ff}	" file format
set statusline+=%y			" file type
set statusline+=\ %<%F		" full path
set statusline+=%-5m		" modified flag
set statusline+=%V       	" right align
set statusline+=%=%5l    	" current line
set statusline+=/%L      	" total lines
set statusline+=%4v\     	" virtual column number
set laststatus=2

"}}}

" TabLine ------------------------------------------------------------------{{{
" SetTabLine sets the tab line theme
function SetTabLine()
	hi clear TabLine
	hi clear TabLineFill
	hi clear TabLineSel

	let light_not_dark = LightOrDark()
	if light_not_dark
		hi TabLine cterm=none term=none gui=none ctermbg=darkgray ctermfg=white
			\ guibg=darkgray guifg=white
		hi TabLineFill ctermbg=darkgray guibg=darkgray
		hi TabLineSel cterm=bold term=bold gui=bold ctermfg=black
		return
	else
		hi TabLine cterm=none term=none gui=none ctermbg=gray ctermfg=black
			\ guibg=gray guifg=black
		hi TabLineFill ctermbg=gray guibg=gray
		hi TabLineSel cterm=bold term=bold gui=bold ctermfg=white
		return
	endif
endfunction

" Only set tabline colour if on macOS (vim version >= 8.0.1630)
let s:uname = trim(system("uname"))
if s:uname==?"Darwin"
	autocmd VimEnter * call SetTabLine()
endif
"}}}

" Cursorline -------------------------------------------------------{{{
hi clear CursorLine
hi CursorLineNR cterm=bold term=bold
highlight CursorLine cterm=bold term=bold
set cursorline
"}}}

" Window Pane Splitter -----------------------------------------------------{{{
hi VertSplit cterm=none gui=none term=none
"}}}

" Tabbing ------------------------------------------------------------------{{{
set noexpandtab 
augroup ModifiedExpandTab
	autocmd!
	autocmd FileType python set expandtab " PEP8 says to expand tabs
	autocmd FileType julia set expandtab " Julia should have expanded tabs
augroup end
set smarttab
set tabstop=4 " Set tab width to 4 columns
set softtabstop=4
set shiftwidth=4 " Set shift width to 4 spaces
 set autoindent
 set smartindent
"}}}

" File Type Detection ------------------------------------------------------{{{
augroup FiletypeVim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup end
filetype on
filetype plugin on " Use only plugins for this file's type
filetype indent on " Load an indent file for the detected file type
"}}}

" Textwidth ----------------------------------------------------------------{{{
set textwidth=79
augroup ModifiedTextWidth
	" Git commit body should be only 72 characters long
	autocmd!
	autocmd FileType gitcommit setlocal textwidth=72
	
	" Julia text width is 92 characters
	autocmd FileType julia setlocal textwidth=92
augroup end

augroup TextFormatting
	autocmd!
	" Automatic formatting of paragraphs
	autocmd FileType text setlocal formatoptions+=a 
augroup end
"}}}

" Format options -----------------------------------------------------------{{{
set formatoptions+=t " Auto wrap text using textwidth
set formatoptions+=c " Auto wrap comments using textwidth
set formatoptions+=r " Automatically insert comment leader on <ENTER>
set formatoptions+=n " Recognize numbered lists when formatting
set formatoptions-=l " Long lines should be broken in insert mode
set formatoptions+=j " Remove comment leader when joining lines
set formatoptions+=q " Allow formatting of comments with "gq"
"}}}

" Colorcolumn --------------------------------------------------------------{{{
highlight ColorColumn ctermbg=gray guibg=gray
set colorcolumn=+1
"}}}

" Julia-vim Options --------------------------------------------------------{{{
let g:latex_to_unicode_auto=1 " Allow some symbols to be auto-expanded
let g:latex_to_unicode_file_types=".*" " Allow LaTeX in all file types
let g:julia_blocks=0 " Don't allow the Julia block moving
"}}}

" Julia-formatter Options --------------------------------------------------{{{
augroup JuliaFormatter
	autocmd!
	" Remap = to use JuliaFormatter.vim instead of Julia-vim, which is dumb
	autocmd FileType julia noremap gg=G :JuliaFormatterFormat<cr>
	autocmd FileType julia vnoremap = :JuliaFormatterFormat<cr>
augroup end
let g:JuliaFormatter_options = {
        \ 'style' : 'blue',
        \ }
let g:JuliaFormatter_always_launch_server=1
" }}}

"}}}
"}}}
