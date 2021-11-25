" https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/
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

set statusline=
set statusline +=%1*\ %n\ %*            " buffer number
set statusline +=%5*%{&ff}%*            " file format
set statusline +=%3*%y%*                " file type
set statusline +=%4*\ %<%F%*            " full path
set statusline +=%2*%m%*                " modified flag
set statusline +=\ \ \                  " blank space
set statusline +=%V                     " right align
set statusline +=%1*%=%5l%*             " current line
set statusline +=%2*/%L%*               " total lines
set statusline +=%1*%4v\ %*             " virtual column number
"set statusline +=%2*0x%04B\ %*         " character under cursor
set laststatus=2

"}}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" Commands
command! W execute 'w !sudo tee % > /dev/null' <bar> edit! " :W sudo saves file

set nocompatible
set showcmd " Show partial commands you type in last line
set showmode " Show mode in last line
set mouse=a " Allow mouse usageA
set ttyfast " Increase scroll speed

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
set expandtab " Use spaces instead of tabs
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
set fo+=t
set fo-=l

" }}}

