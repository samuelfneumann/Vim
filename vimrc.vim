set fileencodings=utf-8,ucs-bom,latin1 " Encodings to try when opening file
set termencoding=utf-8 " The encoding to use to type and display
set encoding=utf-8 " Encoding to use inside of Vim (e.g. in buffers)
set title " Set filename in window title bar

" Functions -----------------------------------------------------------------{{{
" LightOrDark returns if the operating system appearance on macOS is light
" (true) or dark (false)
function LightOrDark()

	" Dynamic colour on macOS
	let l:uname = trim(system("uname"))
	if l:uname==?"Darwin"
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
	endif

	return 0 " Default to dark
endfunction

"}}}

" Theme options ------------------------------------------------------------{{{
" Set termguicolours so that iTerm uses the fancy gui colours in the terminal
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Set the theme
if LightOrDark()
	colorscheme montereylight
else
	colorscheme montereydark
endif
" }}}

" VIMSCRIPT --------------------------------------------------------------- {{{
" Commands ----------------------------------------------------------------{{{
" command! W execute 'w !sudo tee % > /dev/null' <bar> edit! " :W sudo saves file
"}}}

" Maps ---------------------------------------------------------------------{{{
let mapleader="-"
let localleader='\'

" Terminal Navigation ----------------------------------------------------{{{
" Open the terminal using -[tT]
" <leader>t[hlkj] opens a terminal at the left, right, up, or down pane
" respectively
" <leader>T opens a terminal in a new tab
" <leader>tx exits the terminal
tnoremap <leader>tx <c-w>:q!<cr>
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
tnoremap <leader>N <c-w>N<cr>
"}}}

" Tab navigation -----------------------------------------------------------{{{
noremap <leader>tn :tabnew<cr>
noremap <leader>te :tabedit
noremap <c-p> gt
noremap <c-o> gT
noremap <leader><c-o> :tabfirst<cr>
noremap <leader><c-p> :tablast<cr>

tnoremap <leader>tn <c-w>:tabnew<cr>
tnoremap <leader>te <c-w>:tabedit
tnoremap <c-p> <c-w>:tabn<cr>
tnoremap <c-o> <c-w>:tabp<cr>
tnoremap <leader><c-p> <c-w>:tabfirst<cr>
tnoremap <leader><c-o> <c-w>:tablast<cr>
"}}}

" Window/Pane navigation ---------------------------------------------------{{{
" If using the vim-tmux-navigator plugin found here
" https://github.com/christoomey/vim-tmux-navigator, the keys <C-h/j/k/l> will
" also move the current pane.

" Pane resizing
tnoremap <leader>+ <c-w>+
noremap <leader>+ <c-w>+
tnoremap <leader>- <c-w>-
noremap <leader>- <c-w>-
tnoremap <leader>> <c-w>>
noremap <leader>> <c-w>>
tnoremap <leader>< <c-w><
noremap <leader>< <c-w><
tnoremap <leader>= <c-w>=
noremap <leader>= <c-w>=

" Pane navigation
tnoremap <c-h> <c-w>h
noremap <c-h> <c-w>h
tnoremap <c-j> <c-w>j
noremap <c-j> <c-w>j
tnoremap <c-k> <c-w>k
noremap <c-k> <c-w>k
tnoremap <c-l> <c-w>l
noremap <c-l> <c-w>l

" Pane swapping
tnoremap <leader><c-h> <c-w>H
noremap <leader><c-h> <c-w>H
tnoremap <leader><c-j> <c-w>J
noremap <leader><c-j> <c-w>J
tnoremap <leader><c-k> <c-w>K
noremap <leader><c-k> <c-w>K
tnoremap <leader><c-l> <c-w>L
noremap <leader><c-l> <c-w>L

" Pane splitting
"
" These hotkeys are similar to those defined for tmux in tmux.conf
" - for horizontal split
" \ for vertical split
tnoremap <leader>sp- <c-w>:split<cr>
nnoremap <leader>sp- :split<cr>
tnoremap <leader>sp\ <c-w>:vsplit<cr>
nnoremap <leader>sp\ :vsplit<cr>
"}}}

" Buffer navigation --------------------------------------------------------{{{
tnoremap <leader>bd <c-w>:bd
nnoremap <leader>bd :bd
tnoremap <c-i> <c-w>:bnext<cr>
noremap <c-i> :bnext<cr>
tnoremap <c-u> <c-w>:bprev<cr>
noremap <c-u> :bprev<cr>
tnoremap <leader><c-i> <c-w>:bfirst<cr>
noremap <leader><c-i> :bfirst<cr>
tnoremap <leader><c-u> <c-w>:blast<cr>
noremap <leader><c-u> :blast<cr>
tnoremap <leader>bls <c-w>:ls<cr>
noremap <leader>bls :ls<cr>
"}}}

" Remap the <esc> key
inoremap jk <esc>
vnoremap jk <esc>
tnoremap jk <esc>

" Edit and source vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Wrap text in `, ", ', (), [], or {} --------------------------------------{{{

" In visual mode <leader><symbol><symbol> wraps the selection in <symbol> from
" the beginning of the first selected line to the end of the last selected
" line. <leader><symbol> wraps only the selection (not the selected lines)
" in <symbol>
"
" In normal mode, <leader><symbol> wraps the current word in <symbol>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lell
nnoremap <leader>` viw<esc>a`<esc>bi`<esc>lell
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lell
nnoremap <leader>() viw<esc>a)<esc>bi(<esc>lell
nnoremap <leader>[] viw<esc>a]<esc>bi[<esc>lell
nnoremap <leader>{} viw<esc>a}<esc>bi{<esc>lell
vnoremap <leader>" <esc>'>A"<esc>'<I"<esc>
vnoremap <leader>` <esc>'>A`<esc>'<I`<esc>
vnoremap <leader>' <esc>'>A'<esc>'<I'<esc>
vnoremap <leader>"" c""<esc>P
vnoremap <leader>'' c''<esc>P
vnoremap <leader>`` c``<esc>P
vnoremap <leader>() c()<esc>P
vnoremap <leader>[] c[]<esc>P
vnoremap <leader>{} c{}<esc>P
"}}}

" Move to beginning or end of line
nnoremap <leader>a g_
nnoremap <leader>i _

" Place/remove semi-colon at line end without moving the cursor
nnoremap <leader>; :execute "normal! mqA;\e`q"<cr>
nnoremap <leader>;x :execute "normal! mq:s/;$//e\e`q"<cr>:nohlsearch<cr>

" Remove trailing whitespace, leaving cursor in-place
nnoremap <leader><space><space>x mq:s/\v\s+$//e<cr>:nohlsearch<cr>`q
nnoremap <leader><space>x mq:%s/\v\s+$//e<cr>:nohlsearch<cr>`q
vnoremap <leader><space>x mq:s/\v\s+$//e<cr>:nohlsearch<cr>`q

" Remove arrow keys and esc ------------{{{
inoremap <esc> <nop>
vnoremap <esc> <nop>
noremap <Down> <nop>
noremap <Up> <nop>
noremap <left> <nop>
noremap <right> <nop>
"}}}
"}}}

" Abbreviations ------------------------------------------------------------{{{
" Contact abbreviations -----------{{{
iabbrev @@ samuelfneumann@gmail.com
iabbrev u@@ sfneuman@ualberta.ca
iabbrev _name Samuel Frederick Neumann
iabbrev _fname Samuel
iabbrev _lname Neumann
iabbrev _mname Frederick
"}}}
"}}}

" General Settings ---------------------------------------------------------{{{

set nocompatible
set showcmd " Show partial commands you type in last line
set showmode " Show mode in last line
" set mouse=a " Allow mouse usage
set ttyfast " Increase scroll speed
set undofile " Use an undo file
set magic " Use magic for escape characters
set scrolloff=5 " Scroll 5 lines past cursor with mouse
set backspace=indent,eol,start " Allow backspacing over auto indents etc.

" Terminal settings --------------------------------------------------------{{{
augroup TerminalSettings
	autocmd!
	autocmd BufEnter * if &buftype==?"terminal" | setlocal nospell | endif
augroup end
" }}}

" Bracket matching ---------------------------------------------------------{{{
set matchpairs+=<:> " Highlight these kinds of brackets as well
set showmatch " Show matching brackets when cursor is over them
"}}}

" Searching ----------------------------------------------------------------{{{
set hlsearch " Use highlighting when searching
set incsearch " Highlight matching characters as you type
set smartcase " Use case insensitive search unless capital in search pattern
"}}}

" Syntax highlighting and line numbers -------------------------------------{{{
syntax on
set number
"}}}

" Auto read when files are changed outside vim -----------------------------{{{ set autoread
"au FocusGained,BufEnter * checktime
""}}}

" On Save -----------------------------------------------------------------{{{
function RemoveTrailingWhitespace()
	execute "normal! mq"
	execute "normal! :%s/\\s\\+$//e\r"
	execute "normal! `q"
endfunction
augroup OnSave
	" Autocommand group for events to happen on save
	autocmd!

	" Remove all trailing whitespace on save
	autocmd BufWritePre * call RemoveTrailingWhitespace()
augroup end
" }}}

" Wildmenu -----------------------------------------------------------------{{{
set wildmenu " Enable auto completion after pressing tab
set wildmode=list:longest " Behave similarly to bash completion
"}}}

" Ruler/StatusLine/Lightline ---------------------------------------------- {{{
" If using lightline, these setting are overridden after this file runs. To
" keep these default settings, remove lightline
set ruler
set rulerformat=%Y\ %=(%l,%c)%V%p%% " Disappears if statusline is on

" Lightline settings -------------------------------------------------------{{{
" If weird things happen, place this before setting the colourscheme
if has('gui_running') || (has('termguicolors') && &termguicolors)
	let g:lightline = {
				\ 'colorscheme': 'monterey',
				\ }
else
	" If not using termguicolours, use the terminal colours by default
	" (monterey theme also does this, but using termcolours to be explicit)
	let g:lightline = {
				\ 'colorscheme': 'termcolours',
				\ }
endif

let g:lightline.mode_map = {
		    \ 'n' : 'NORMAL',
		    \ 'i' : 'INSERT',
		    \ 'R' : 'REPLACE',
		    \ 'v' : 'VISUAL',
		    \ 'V' : 'V-LINE',
		    \ "\<C-v>": 'V-BLOCK',
		    \ 'c' : 'COMMAND',
		    \ 's' : 'SELECT',
		    \ 'S' : 'S-LINE',
		    \ "\<C-s>": 'S-BLOCK',
		    \ 't': 'TERMINAL',
		    \ }

" Enable the lightline status and tab lines
let g:lightline.enable = {
		    \ 'statusline': 1,
		    \ 'tabline': 1
		    \ }

" }}}

" Function: Colour statusLine based on macOS appearance --------------------{{{
" SetStatusLineColour sets the status line theme based on the appearance of
" macOS - light or dark. If not on macOS, then the dark theme is used by
" default.
function SetStatusLineColour()
	hi clear StatusLine " Clear status line of current window
	hi clear StatusLineNC " Clear status line of non-current window
	hi clear StatusLineTerm " Clear status line of current terminal
	hi clear StatusLineTermNC " Clear status line of non-current terminal

	let light_not_dark = LightOrDark()
	if light_not_dark
		hi StatusLine cterm=none gui=none term=none ctermbg=darkgray
					\ ctermfg=white guibg=darkgray guifg=white
		hi StatusLineNC cterm=none gui=none term=none ctermbg=gray
					\ ctermfg=white guibg=gray guifg=white

		"Manually set the statusline for the terminal, since still in beta in
		" vim 8.1
		hi StatusLineTerm cterm=none gui=none term=none ctermbg=darkgreen
					\ ctermfg=white guibg=darkgreen guifg=white
		hi StatusLineTermNC cterm=none gui=none term=none ctermbg=green
					\ ctermfg=white guibg=green guifg=white
		return
	else
		hi StatusLine cterm=none gui=none term=none ctermbg=gray ctermfg=black
					\ guibg=gray guifg=black
		hi StatusLineNC cterm=none gui=none term=none ctermbg=darkgray
					\ ctermfg=black guibg=darkgray guifg=black

		"Manually set the statusline for the terminal, since still in beta in
		" vim 8.1
		hi StatusLineTerm cterm=none gui=none term=none ctermbg=blue
					\ ctermfg=white guibg=blue guifg=white
		hi StatusLineTermNC cterm=none gui=none term=none ctermbg=darkblue
					\ ctermfg=white guibg=darkblue guifg=white
		return
	endif
endfunction
"}}}

" If lightline is disabled, set the statusline
if !g:lightline.enable.statusline
	" Theme the statusline
	if g:colors_name ==? "default"
		call SetStatusLineColour()
	endif

	let g:currentmode = {
				\ 'n' : 'NORMAL',
				\ 'i' : 'INSERT',
				\ 'r' : 'REPLACE',
				\ 'R' : 'REPLACE',
				\ 'Rv' : 'REPLACE',
				\ 'v' : 'VISUAL',
				\ 'V' : 'V-LINE',
				\ "\<C-v>": 'V-BLOCK',
				\ 'c' : 'COMMAND',
				\ 's' : 'SELECT',
				\ 'S' : 'S-LINE',
				\ "\<C-s>": 'S-BLOCK',
				\ 't': 'TERMINAL',
				\ }

	set statusline=
	set statusline+=\ %n		" buffer number

	set statusline+=\ ==%{toupper(g:currentmode[mode()])}==" mode
	set statusline+=\ %{&ff}	" file format
	set statusline+=%y			" file type
	set statusline+=\ %<%F		" full path
	set statusline+=%-5m		" modified flag
	set statusline+=%V       	" right align
	set statusline+=%=%5l    	" current line
	set statusline+=/%L      	" total lines
	set statusline+=%4v\     	" virtual column number
endif

" Show the statusline
set laststatus=2

" }}}

" TabLine ------------------------------------------------------------------{{{

" Function: Colour tabline based on macOS appearance ------------------------{{{
" SetTabLine sets the tab line theme based on the theme of macOS - light or
" dark. If not on macOS, then the dark theme is used by default
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
" }}}

if !g:lightline.enable.tabline && g.colors_name ==? "default"
	call SetTabLine()
endif

"}}}

" Cursorline -------------------------------------------------------{{{
if g:colors_name ==? "default"
	hi clear CursorLine
	highlight CursorLineNR cterm=bold term=bold gui=bold
	highlight CursorLine cterm=bold term=bold gui=bold
endif
set cursorline
"}}}

" Window Pane Splitter -----------------------------------------------------{{{
hi VertSplit cterm=bold gui=bold term=bold ctermbg=yellow guibg=yellow
"}}}

" Tabbing ------------------------------------------------------------------{{{
set noexpandtab
augroup ModifiedExpandTab
	autocmd!
	autocmd FileType python setlocal expandtab " PEP8 says to expand tabs
	autocmd FileType julia setlocal expandtab " Julia should have expanded tabs
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

	" LaTeχ can have longer text width
	autocmd FileType tex setlocal textwidth=120
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
if g:colors_name ==? "default"
	highlight ColorColumn ctermbg=cyan guibg=cyan
endif
set colorcolumn=+1
"}}}

" Julia-vim Options --------------------------------------------------------{{{
let g:latex_to_unicode_auto=1 " Allow some symbols to be auto-expanded
augroup LatexUnicode
	" Don't allow autoexpand if a tex or snippet file has been opened in a
	" buffer
	autocmd!
	autocmd FileType tex :let g:latex_to_unicode_auto=0
	autocmd FileType snippets :let g:latex_to_unicode_auto=0
augroup end
let g:latex_to_unicode_file_types=".*" " Allow LaTeX in all file types
let g:julia_blocks=0 " Don't allow the Julia block moving
"}}}

" Julia-formatter Options --------------------------------------------------{{{
augroup JuliaFormatter
	autocmd!
	" Remap = to use JuliaFormatter.vim
	autocmd FileType julia nnoremap =G :.,$JuliaFormatterFormat<cr>
	autocmd FileType julia nnoremap = :.,.JuliaFormatterFormat<cr>
	autocmd FileType julia vnoremap = :JuliaFormatterFormat<cr>
augroup end
let g:JuliaFormatter_options = {
			\ 'style' : 'blue',
			\ }
" let g:JuliaFormatter_always_launch_server=1
let g:JuliaFormatter_use_sysimage=1
" }}}

" UltiSnips Options --------------------------------------------------------{{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>" " Next snippet arg
let g:UltiSnipsJumpBackwardTrigger="<leader><tab>" " Previous snippet arg
let g:ultisnips_python_style="numpy"
let g:UltiSnipsNoPythonWarning=1

"" Only use snippets defined in my version of the vim-snippets repository, this
"" will be for Ulti and snipMate snippets
"let g:UltiSnipsSnippetDirectories=["~/.vim/pack/plugins/start/vim-snippets"]

" Disable snipMate snippets -- if needed, copy to UltiSnips
let g:UltiSnipsEnableSnipMate=0
" }}}

" Inkscape Figures ---------------------------------------------------------{{{
" https://github.com/gillescastel/inkscape-figures
" https://castel.dev/post/lecture-notes-2/
"
" Place this at top of LaTeχ file:
"
"	\usepackage{import}
"	\usepackage{pdfpages}
"	\usepackage{transparent}
"	\usepackage{xcolor}
"
"	\newcommand{\incfig}[2][1]{%
"		\def\svgwidth{#1\columnwidth}
"		\import{./Figures/}{#2.pdf_tex}
"	}
"
"	\pdfsuppresswarningpagegroup=1
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/Figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/Figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
" }}}

" VimTex -------------------------------------------------------------------{{{
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0

" Set how citations are concealed
let g:vimtex_syntax_conceal_cites = {
          \ 'type': 'icon',
          \ 'icon': '📖',
          \ 'verbose': v:true,
          \}

set conceallevel=2
hi clear Conceal
hi Conceal cterm=none gui=none
" }}}

" NerdCommenter ------------------------------------------------------------{{{
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Don't use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 0

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Remove trailing whitespace when uncommenting
let g:NERDRemoveExtraSpace = 1

" Set the default comments of Python and Julia to not include a space
let g:NERDCustomDelimiters = {
			\ 'python' : { 'left': '#' },
			\ 'julia'  : { 'left': '#' },
			\ }
" }}}

" Tmux-Vim-Navigator -------------------------------------------------------{{{
" Disable tmux navigator when zooming the vim pane
let g:tmux_navigator_disable_when_zoomed = 1
" }}}

" Spelling -----------------------------------------------------------------{{{
" Set spell check on
set spell spelllang=en_us

" Correct spelling on-the-fly with <c-l>
" <leader>cs (correct spelling) corrects the last spelling mistake
nnoremap <leader>fs mq[s1z=`q
inoremap <leader>fs <esc>mq[s1z=`qa

" " Change the spelling highlight groups
if g:colors_name ==? "default"
	highlight clear SpellBad
	highlight SpellBad cterm=underline gui=undercurl
	highlight clear SpellCap
	highlight SpellCap ctermbg=blue ctermfg=white guibg=blue guifg=white
	highlight clear SpellLocal
	highlight SpellLocal ctermbg=magenta ctermfg=white guibg=magenta guifg=white
	highlight clear SpellRare
	highlight SpellRare ctermbg=green ctermfg=white guibg=green guifg=white
endif
" }}}

" }}}
" }}}
