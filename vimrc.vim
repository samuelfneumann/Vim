" Get the OS type
let s:os = trim(system("uname")) " Get the OS name
let s:darwin = s:os==?"Darwin"
let s:linux = s:os==?"Linux"


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
		if v:shell_error != 0 || output ==? "Light"
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
if has('gui_running') || (has('termguicolors') && s:darwin)
	set termguicolors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Set the theme
if s:linux
	colorscheme ubuntu
elseif s:darwin && LightOrDark()
	colorscheme montereylight
elseif s:darwin
	colorscheme montereydark
endif

" Cursor changes in insert mode to a bar
let dynamic_cursor = 1
if dynamic_cursor && &term =~ "xterm\\|rxvt"
	" let &t_SI = "\<Esc>]12;orange\x7"
	let &t_SI .= "\<Esc>[6 q"
	" let &t_EI = "\<Esc>]12;red\x7"
	let &t_EI .= "\<Esc>[2 q"
endif

" }}}

" VIMSCRIPT --------------------------------------------------------------- {{{
" Commands ----------------------------------------------------------------{{{
command! W execute 'w !sudo tee % > /dev/null' <bar> edit! " :W sudo saves file

com! CheckHighlightUnderCursor echo {l,c,n ->
        \   'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
        \  .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
        \  .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
        \ }(line("."), col("."), "name")
"}}}

" Abbreviations ------------------------------------------------------------{{{
" Contact abbreviations -----------{{{
iabbrev @@ samuelfneumann@gmail.com
iabbrev u@@ sfneuman@ualberta.ca
iabbrev _fullname Samuel Frederick Neumann
iabbrev _fname Samuel
iabbrev _lname Neumann
iabbrev _mname Frederick
"}}}
"}}}

" General Settings ---------------------------------------------------------{{{

" Leaders ------------------------------------------------------------------{{{
let mapleader="-"
let localleader='\'
" }}}

" Encodings to try when opening file
set fileencodings=utf-8,ucs-bom,latin1

" The encoding to use to type and display
set termencoding=utf-8

" Encoding to use inside of Vim (e.g. in buffers)
set encoding=utf-8

" Set filename in window title bar
set title

" Don't use vi compatability
set nocompatible

" Show partial commands you type in last line
set showcmd

" Don't show mode in last line, we use lightline
set noshowmode

" set mouse=a " Allow mouse usage

" Increase scroll speed"
set ttyfast

" Use magic for escape characters
set magic

" Scroll 5 lines past cursor with mouse
set scrolloff=5

set backspace=indent,eol,start " Allow backspacing over auto indents etc.

" Timeout for next-key-press in maps
set timeoutlen=300

" Write swap file only after half a second of inactivity
set updatetime=500

" Show infor for completion candidates in a popup menu
if has("patch-8.1.1904")
	set completeopt+=popup
	set completepopup=align:menu,border:off,highlight:Pmenu
endif
" Delay for popups
set balloondelay=200

" Allow the sign column for quickfixes
set signcolumn=number

" Wrap long lines
set wrap

" Set autocomplete options
set completeopt=longest,menuone,preview

" Undo files ---------------------------------------------------------------{{{
" Create the undo directory
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif

set undodir=~/.vim/undo-dir
set undofile

" You may want to add this to your crontab to ensure that the vim undo files
" get cleaned up after 90 days
" # m  h  dom mon dow   command
"   00 00 *   *   3     find /home/samuel/.vim/undo-dir -type f -mtime +90 -delete
"}}}

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
set shortmess-=S " Show the number of search matches at the bottom right
nnoremap <leader>nhs :nohlsearch<cr>

" Ignore case when search term contains only lowercase letters. Only take case
" into account when the search term has uppercase letters.
set ignorecase
set smartcase " Use case insensitive search unless capital in search pattern
"}}}

" Syntax highlighting and line numbers -------------------------------------{{{
syntax on
set number
"}}}

" Auto read when files are changed outside vim -----------------------------{{{
set autoread
" silent! here ensure no wierdness happens when ctrl-f is pressed in command
" mode.
au CursorHold,FocusGained,BufEnter * silent! checktime
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

" Remove trailing whitespace, leaving cursor in-place
nnoremap <leader><space><space>x mq:s/\v\s+$//e<cr>:nohlsearch<cr>`q
nnoremap <leader><space>x mq:%s/\v\s+$//e<cr>:nohlsearch<cr>`q
vnoremap <leader><space>x mq:s/\v\s+$//e<cr>:nohlsearch<cr>`q
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
if has('termguicolors') && s:darwin && &termguicolors
	let s:colours = 'monterey'
elseif has('termguicolors') && s:linux && &termguicolors
	let s:colours = 'ubuntu'
else
	let s:colours = 'termcolours'
endif

" Set the lightline textual elements
let g:lightline = {
			\ 'colorscheme': s:colours,
			\ 'active': {
				\ 'left': [ ['mode', 'paste'],
				\			['readonly', 'filename' ],
				\			['modified'] ]
				\ },
				\ 'component': {
					\ },
				\ 'component_function': {
					\ },
					\ }

" Enable the lightline status and tab lines
let g:lightline.enable = {
		    \ 'statusline': 1,
		    \ 'tabline': 1
		    \ }

" Set the default separator
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

" Set the default tabline spearator
let g:lightline.tabline_subseparator = g:lightline.subseparator
let g:lightline.tabline_separator = g:lightline.separator
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
	highlight CursorLineNR cterm=bold term=bold gui=bold ctermbg=8 guibg=8
	highlight CursorLine cterm=bold term=bold gui=bold ctermbg=8 guibg=8
endif
set cursorline
"}}}

" Tabbing ------------------------------------------------------------------{{{

" Sets the tab levels for nim files
function SetNimTabbing()
	set tabstop=2 " Set tab width to 2 columns
	set softtabstop=2
	set shiftwidth=2 " Set shift width to 2 spaces
endfunction

set noexpandtab
set smarttab
set tabstop=4 " Set tab width to 4 columns
set softtabstop=4
set shiftwidth=4 " Set shift width to 4 spaces
set autoindent
set smartindent
augroup ModifiedExpandTab
	autocmd!
	autocmd FileType python setlocal expandtab " PEP8 says to expand tabs
	autocmd FileType julia setlocal expandtab " Julia should have expanded tabs

	" Really, the nim.vim extension handles this, but explicitly set these
	" values in case the nim.vim extension is not installed
	autocmd FileType nim setlocal expandtab
	autocmd FileType nim call SetNimTabbing()
augroup end
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
" " Manually control LaTeΧ to Unicode if you want completefunc to work properly
" " in this case, uncomment these lines and comment out the blacklist line
" " below
" function! LaTeXUnicodeOff()
"     if &ft ==# "tex"
"         call LaTeXtoUnicode#Disable()
"     elseif &ft ==# "snippets"
"         call LaTeXtoUnicode#Disable()
"     endif
" endfunction

" function! LaTeXUnicodeOn()
"     if &ft ==# "tex"
"         call LaTeXtoUnicode#Enable()
"     elseif &ft ==# "snippets"
"         call LaTeXtoUnicode#Enable()
"     endif
" endfunction

" augroup LatexUnicode
"     " Don't allow autoexpand if a tex or snippet file has been opened in a
"     " buffer, because the g:latex_to_unicode_file_types doesn't work
"     autocmd!
"     autocmd BufEnter * call LaTeXUnicodeOff()
"     autocmd BufLeave * call LaTeXUnicodeOn()
" augroup end

let g:latex_to_unicode_auto=1 " Allow some symbols to be auto-expanded
let g:latex_to_unicode_file_types='.*'
let g:latex_to_unicode_file_types_blacklist = ["tex", "snippets"]
let g:julia_blocks=1 " Don't allow the Julia block moving
let g:julia_indent_align_brackets=0
let g:julia_indent_align_funcargs=0
let g:julia_highlight_operators=1
let g:julia_spellcheck_comments=1
let g:julia_spellcheck_docstrings=1

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
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
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

" Set PDF viewer
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_automatic = 0

augroup LaTeX
	autocmd!
	autocmd filetype tex nnoremap <localleader>v :VimtexView<cr>
augroup end

let g:vimtex_compiler_method = "latexmk"

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

" Python-Mode --------------------------------------------------------------{{{
" Turn on syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_exit_as_function = 1
let g:pymode_syntax_print_as_function = 1
let g:pymode_syntax_builtin_objs = 1
let g:pymode_syntax_builtin_types = 1
let g:pymode_highlight_execptions = 1
let g:pymode_syntax_docstrings = 1

" Python documentation
let g:pymode_doc = 1
let g:pymode_doc_bind = 'doc'

" Linting
let g:pymode_lint=1
let g:pymode_lint_checkers = ['pep8']
" }}}

" WinResizer ---------------------------------------------------------------{{{
" Use same map to start wince sizer for GUI and terminal
let g:winresizer_start_key = '<c-a>'
let g:winresizer_gui_start_key = g:winresizer_start_key

" Ensure that WinResizer works in vim terminal mode
tnoremap <c-a> <c-w>:WinResizerStartResize<cr>

" Disable in GUI since I never use a GUI
let g:winresizer_gui_enable = 0

" Number of points when residing
let g:winresizer_vert_resize=5
let g:winresizer_horiz_resize=3
" }}}

" Spelling -----------------------------------------------------------------{{{
" Set spell check on
set spell spelllang=en_ca

" <leader>cs (correct spelling) corrects the last spelling mistake
nnoremap <leader>fs mq[s1z=`q
inoremap <leader>fs <esc>mq[s1z=`qa

" Change the spelling highlight groups
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

" Syntastic ----------------------------------------------------------------{{{
" This is now covered by specific language plugins such as python-mode or govim
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" " Toggle Syntastic
" nnoremap -synt :SyntasticToggleMode<cr>
" }}}

" Vim-Go -------------------------------------------------------------------{{{
" Using GoVim rather than Vim-Go
" let g:go_highlight_operators = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_parameters = 0
" let g:go_highlight_function_calls = 1
" let g:go_highlight_types = 1

" " Change the documentation maps to 'doc', since 'K' is remapped below
" " Also, we need to disable 'K' to open documentation, since plugins are loaded
" " after this file. If we leave this setting enabled, then Vim-Go will overwrite
" " our mapping (below) of 'K' to join the current line with  that above.
" let g:go_doc_keywordprg_enabled = 0
" augroup Documentation
"     autocmd!
"     autocmd FileType go nnoremap doc :GoDoc<cr>
"     autocmd FileType go vnoremap doc :GoDoc<cr>
" augroup end

" " Enable gopls
" let g:go_def_mode = 'gopls'
" let g:go_info_mode = 'gopls'
" }}}

" GoVim --------------------------------------------------------------------{{{

" }}}

" Gutentags ----------------------------------------------------------------{{{
" And Gutentags+

" Enable gtags modules
let g:gutentags_modules = ['ctags']

" Config project root markers
let g:gutentags_project_root = ['.root']

" Hide tag files
let g:gutentags_ctags_tagfile = ".tags"

" Change focus to quickfix window after search
let g:gutentags_plus_switch = 1

" }}}

" Sub Mode --------------------------------------------------------------{{{
let g:submode_always_show_submode = 1
" }}}

" Window Mode --------------------------------------------------------------{{{
" With winresizer, this mode is obselete, since winresizer is better at
" resizing windows than this is! This would be good for creating new windows,
" but then a full mode is overkill
"
" call submode#enter_with('window', 'n', '', '<c-w>')
" call submode#heave_with('window', 'n', '', '<esc>')
" call submode#leave_with('window', 'n', '', 'jk')

" for key in ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
"             \'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
"     " Maps lowercase, uppercase, and <c-key>
"     call submode#map('window', 'n', '', key, '<c-w>' . key)
"     call submode#map('window', 'n', '', toupper(key), '<c-w>' . toupper(key))
"     call submode#map('window', 'n', '', '<c-' . key . '>', '<c-w>' . '<c-' .  key . '>')
" endfor

" " Go through symbols. '|' not supported by submode
" for key in ['=', '_', '+', '-', '<', '>']
"     call submode#map('window', 'n', '', key, '<c-w>' . key)
" endfor

" Access window mode the old way using leader
" nnoremap <leader>w <c-w>
" }}}

" }}}

" Maps ---------------------------------------------------------------------{{{

" Go to textwidth column
onoremap <localleader>\| :execute "normal! _" . &textwidth . "l"<cr>
nnoremap <localleader>\| :execute "normal! _" . &textwidth . "l"<cr>
vnoremap <localleader>\| :<c-u>call ToLastCol()<cr>
function ToLastCol()
	execute "normal! gv_" . &textwidth . "l"
endfunction

" Place/remove semi-colon at line end without moving the cursor
nnoremap <leader>; :execute "normal! mqA;\e`q"<cr>
nnoremap <leader>;x :execute "normal! mq:s/;$//e\e`q"<cr>:nohlsearch<cr>

" Increment and decrements numbers
nnoremap <leader>in <c-a>
nnoremap <leader>dn <c-x>

" Terminal navigation ----------------------------------------------------{{{
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
tnoremap <c-N> <c-w>N<cr>

nnoremap <c-s> :shell<cr>
"}}}

" Tab navigation -----------------------------------------------------------{{{
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>te :tabedit<space>
nnoremap <c-p> :tabn<cr>
nnoremap <c-o> :tabp<cr>
if s:os ==? "Darwin"
	nnoremap ø :tabm -1<cr>
	nnoremap π :tabm +1<cr>
elseif s:os ==? "Linux"
	" See :help map-alt-keys
	" https://vi.stackexchange.com/questions/2350/how-to-map-alt-key
	" http://www.leonerd.org.uk/hacks/fixterms/
	"
	" The following maps will work if your terminal emulator sends a key with
	" the 8th bit set when modifying the key with <Alt>. Most terminal
	" emulators do not do this by default, but instead send an <Esc> before the
	" key when modifying it with <Alt>. URxvt and xterm both support both
	" behaviours of <Alt>, but the <Esc> prefix is default.
	"
	" For the following maps to work in URxvt, we need set
	" termencoding=latin1 and the --meta8 flag to be set.
	" nnoremap <m-o> :tabm -1<cr>
	" nnoremap <m-p> :tabm +1<cr>
	"
	" Otherwise, if ~/.Xresources is configured as in my Dotfiles repo the
	" following will work with URxvt. Note that i3/sway should not capture
	" the alt+o and alt+p keybindings
	nnoremap [28~o :tabm -1<cr>
	nnoremap [28~p :tabm +1<cr>

	" If not using the ~/.Xresources file, then the following lines should work
	" for most terminal emulators that prefix a key with <Esc> when modifying
	" that key with <Alt>.
	nnoremap o :tabm -1<cr>
	nnoremap p :tabm +1<cr>
endif

noremap <leader><c-o> :tabfirst<cr>
noremap <leader><c-p> :tablast<cr>

tnoremap <leader>tn <c-w>:tabnew<cr>
tnoremap <leader>te <c-w>:tabedit
tnoremap <c-p> <c-w>:tabn<cr>
tnoremap <c-o> <c-w>:tabp<cr>
tnoremap <leader><c-p> <c-w>:tabfirst<cr>
tnoremap <leader><c-o> <c-w>:tablast<cr>
" }}}

" Window/Pane navigation ---------------------------------------------------{{{

" Pane navigation
" Use hotkeys similar to vim-tmux-navigator if the plugin is not used. If the
" plugin is used, these will be overridden
tnoremap <c-h> <c-w>h
noremap <c-h> <c-w>h
tnoremap <c-j> <c-w>j
noremap <c-j> <c-w>j
tnoremap <c-k> <c-w>k
noremap <c-k> <c-w>k
tnoremap <c-l> <c-w>l
noremap <c-l> <c-w>l

" Pane swapping
" Taken care of by WinResizer plugin

" Pane splitting
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
" tnoremap <c-i> <c-w>:bnext<cr> " Not sure why but this blocks tab auto-complete in the terminal
" noremap <c-i> :bnext<cr>
" tnoremap <c-u> <c-w>:bprev<cr>
" noremap <c-u> :bprev<cr>
" tnoremap <leader><c-i> <c-w>:bfirst<cr>
" noremap <leader><c-i> :bfirst<cr>
" tnoremap <leader><c-u> <c-w>:blast<cr>
" noremap <leader><c-u> :blast<cr>
tnoremap <leader>bls <c-w>:ls<cr>
noremap <leader>bls :ls<cr>
"}}}

" Line navigation ----------------------------------------------------------{{{
nnoremap ga g_i
nnoremap gi _a
nnoremap gl g_
nnoremap gh _
" }}}

" Join and move lines ------------------------------------------------------{{{
nnoremap doc K
vnoremap K <nop>
nnoremap K kJ
"}}}

" Remap the <esc> key ------------------------------------------------------{{{
inoremap jk <esc>
vnoremap jk <esc>
tnoremap jk <esc>
" }}}

" Edit and source vimrc ----------------------------------------------------{{{
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}

" Marks --------------------------------------------------------------------{{{
" Remap jump-to-mark to be closer to make-mark map
vnoremap ,, ``
vnoremap , `
nnoremap , `
nnoremap ,, ``
nnoremap ` ,
" }}}

" Wrap text in `, ", ', (), [], {}, or $$ ----------------------------------{{{

" In visual mode <leader><symbol><symbol> wraps the selection in <symbol> from
" the beginning of the first selected line to the end of the last selected
" line. <leader><symbol> wraps only the selection (not the selected lines)
" in <symbol>
"
" In normal mode, <leader><symbol> wraps the current word in <symbol>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lell
nnoremap <leader>` viw<esc>a`<esc>bi`<esc>lell
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lell
nnoremap <leader>) viw<esc>a)<esc>bi(<esc>lell
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lell
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lell
nnoremap <leader>] viw<esc>a]<esc>bi[<esc>lell
nnoremap <leader>} viw<esc>a}<esc>bi{<esc>lell
nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>lell
nnoremap <leader>$ viw<esc>a$<esc>bi$<esc>lell
vnoremap <leader>" c""<esc>P
vnoremap <leader>' c''<esc>P
vnoremap <leader>` c``<esc>P
vnoremap <leader>) c()<esc>P
vnoremap <leader>( c()<esc>P
vnoremap <leader>] c[]<esc>P
vnoremap <leader>[ c[]<esc>P
vnoremap <leader>} c{}<esc>P
vnoremap <leader>{ c{}<esc>P
vnoremap <leader>$ c$$<esc>P
"}}}

" Select inside symbols ---------------------------------------------------{{{
nnoremap vl) :<c-u>normal! f)vi)<cr>
onoremap l) :<c-u>normal! f)vi)<cr>
nnoremap vl( :<c-u>normal! f(vi(<cr>
onoremap l( :<c-u>normal! f(vi(<cr>
nnoremap vh( :<c-u>normal! F(vi(<cr>
onoremap h( :<c-u>normal! F(vi(<cr>
nnoremap vh) :<c-u>normal! F)vi)<cr>
onoremap h) :<c-u>normal! F)vi)<cr>

nnoremap vl] :<c-u>normal! f]vi]<cr>
onoremap l] :<c-u>normal! f]vi]<cr>
nnoremap vl[ :<c-u>normal! f[vi[<cr>
onoremap l[ :<c-u>normal! f[vi[<cr>
nnoremap vh[ :<c-u>normal! F[vi[<cr>
onoremap h[ :<c-u>normal! F[vi[<cr>
nnoremap vh] :<c-u>normal! F]vi]<cr>
onoremap h] :<c-u>normal! F]vi]<cr>

nnoremap vl} :<c-u>normal! f}vi}<cr>
onoremap l} :<c-u>normal! f}vi}<cr>
nnoremap vl{ :<c-u>normal! f{vi{<cr>
onoremap l{ :<c-u>normal! f{vi{<cr>
nnoremap vh{ :<c-u>normal! F{vi{<cr>
onoremap h{ :<c-u>normal! F{vi{<cr>
nnoremap vh} :<c-u>normal! F}vi}<cr>
onoremap h} :<c-u>normal! F}vi}<cr>

nnoremap vl" :<c-u>normal! f"vi"<cr>
onoremap l" :<c-u>normal! f"vi"<cr>
nnoremap vh" :<c-u>normal! F"vi"<cr>
onoremap h" :<c-u>normal! F"vi"<cr>

nnoremap vl' :<c-u>normal! f'vi'<cr>
onoremap l' :<c-u>normal! f'vi'<cr>
nnoremap vh' :<c-u>normal! F'vi'<cr>
onoremap h' :<c-u>normal! F'vi'<cr>

nnoremap vl$ :<c-u>normal! f$lvf$h<cr>
onoremap l$ :<c-u>normal! f$lvf$h<cr>
nnoremap vh$ :<c-u>normal! F$hvF$l<cr>
onoremap h$ :<c-u>normal! F$hvF$l<cr>

nnoremap vl` :<c-u>normal! f`vi`<cr>
onoremap l` :<c-u>normal! f`vi`<cr>
nnoremap vh` :<c-u>normal! F`vi`<cr>
onoremap h` :<c-u>normal! F`vi`<cr>
"}}}

" Page up and page down ----------------------------------------------------{{{
" Backward full screen, backward half screen
" forward full screen, forward half screen
nnoremap <c-b> <c-b>
nnoremap <c-u> <nop>
nnoremap <c-n> <c-u>
nnoremap <c-f> <c-f>
nnoremap <c-d> <nop>
nnoremap <c-g> <c-d>
"}}}

" Remove arrow keys and esc ------------{{{
inoremap <esc> <nop>
vnoremap <esc> <nop>
noremap <Down> <nop>
noremap <Up> <nop>
noremap <left> <nop>
noremap <right> <nop>
noremap <Down> <nop>
"}}}

" Pmenu --------------------------------------------------------------------{{{
" Use <c-j> and <c-k> to move through menu items and enter to select menu
" items if and only if the pmenu is visible, otherwise use the regular
" functionality of these keys
inoremap <expr><c-j> pumvisible() ? "\<c-n>" : "\<c-j>"
inoremap <expr><c-k> pumvisible() ? "\<c-p>" : "\<c-k>"
inoremap <expr><cr> pumvisible() ? "\<c-y>" : "\<cr>"
" }}}

" Netrw --------------------------------------------------------------------{{{
" https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
" https://gist.github.com/t-mart/610795fcf7998559ea80
" Look at adjusting this section with netrw#UserMaps
let g:netrw_banner = 0
let g:netrw_liststyle = 0
" let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:netrw_winsize = 17
let g:netrw_keepdir = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_special_syntax = 1
let g:netrw_fastbrowse = 2

nnoremap <leader>d :Lexplore<cr>

" NetrwMapping
"	Set mappings for netrw
"
"	Navigation
"		  H:		Go back up in history
"		  h: 	Go up a directory
"		  l: 	Open a directory or file
"		  .: 	Toggle the dotfiles
"		  P: 	Close the preview window
"		  L: 	Open a file and close netrw
" <leader>d: 	Close/open netrw
"		 ^r:	Refresh
"
"	File Managing
"		t:		Open file in new tab
"		f:		Create a file
"		d:		Create a directory
"		R:  	Rename a file
"		z:	 	List marked files
"		T:  	Show target directory
"	    x/^x:  	Open with default application
"		D:		Delete a file or an empty directory
"	   RD:		Recursively delete a directory
"
"	Bookmarks
"		bb:		Create bookmark in current directory
"		bd: 	Delete most recent bookmark
"		bj: 	Jump to most recent bookmark
function! NetrwMapping()
	" Navigation
	nmap <buffer> <c-r> :e .<cr>
	nmap <buffer> H u
	nmap <buffer> h -
	nmap <buffer> l <cr>
	nmap <buffer> . gh
	nmap <buffer> P <c-w>z
	nmap <buffer> <leader>d :Lexplore<cr>
	nmap <buffer> L <cr><c-w><c-p>:q<cr>

	" Keep similar navigation for pane switching
	nmap <buffer> <c-l> <c-w>l
	nmap <buffer> <c-h> <c-w>h
	nmap <buffer> <c-k> <c-w>k
	nmap <buffer> <c-j> <c-w>j
	nmap <buffer> <leader>nhs :nohlsearch<cr>

	" File managing
	nmap <buffer> f %:w<CR>:buffer #<CR>
	nmap <buffer> z :echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>
	nmap <buffer> T :echo 'Target:' . netrw#Expose("netrwmftgt")<CR>
	nmap <buffer> <c-x> gxA

	" Recursively delete directories
	nmap <buffer> RD :call NetrwRemoveRecursive()<cr>

	" Bookmark
	nmap <buffer> bb mb
	nmap <buffer> bd mB
	nmap <buffer> bj gbs

endfunction

function! NetrwRemoveRecursive()
	if &filetype ==# 'netrw'
		cnoremap <buffer> <CR> rm -r<CR>
		normal mu
		normal mf

	try
		normal mx
	catch
		echo "Cancelled"
	endtry

	cunmap <buffer> <CR>
	endif
endfunction

augroup netrw_mapping
	autocmd!
	autocmd filetype netrw call NetrwMapping()
augroup end
" }}}

"}}}
"}}}


