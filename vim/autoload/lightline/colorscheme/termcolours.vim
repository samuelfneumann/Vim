" =============================================================================
" Filename: autoload/lightline/colorscheme/termcolours.vim
" Author: Samuel Neumann
" Last Change: 2021/12/15 06:16:00
"
" This lightline theme uses the terminal colours to colour the statusbar. For
" this to work properly, ensure that termguicolours is turned off in your
" .vimrc file, otherwise the colours will not appear properly.
" =============================================================================
let s:p = {'terminal': {}, 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" Set colours
let s:p.normal.left     = [ [  15, 4, 'bold' ], [ 15, 7 ] ]
let s:p.normal.middle   = [ [ 15, 7 ] ]
let s:p.normal.right   = [ [ 15, 4, 'bold' ], [ 15, 4, 'bold' ] ]
let s:p.normal.error   = [ [ 1, 11 ] ]
let s:p.normal.warning = [ [ 3, 15 ] ]

let s:p.inactive.left   = [ [ 251, 7 ], [ 251, 7 ] ]
let s:p.inactive.middle = [ [ 251, 7 ] ]
let s:p.inactive.right  = [ [ 251, 7 ], [ 251, 7 ] ]

let s:p.insert.left     = [ [ 15, 2, 'bold' ], [ 15, 7 ] ]
let s:p.insert.right   = [ [ 15, 2, 'bold' ], [ 15, 2, 'bold' ] ]

let s:p.replace.left    = [ [ 15, 1, 'bold' ], [ 15, 7] ]
let s:p.replace.right  = [ [ 15, 1, 'bold' ], [ 15, 7, 'bold' ] ]

let s:p.visual.left     = [ [ 15, 3, 'bold' ], [ 15, 7] ]
let s:p.visual.right   = [ [ 15, 3, 'bold' ], [ 15, 3, 'bold' ] ]

let s:p.terminal.left   = [ [ 15, 11, 'bold' ], [ 15, 7 ] ]
let s:p.terminal.right = [ [ 15, 11, 'bold' ], [ 15, 11, 'bold' ] ]

let s:p.tabline.left   = [ [ 15, 7 ] ]
let s:p.tabline.tabsel = [ [ 15, 9, 'bold' ] ]
let s:p.tabline.middle = [ [ 15, 7 ] ]
let s:p.tabline.right  = [ [ 15, 1, 'bold' ] ]

let g:lightline#colorscheme#termcolours#palette = lightline#colorscheme#fill(s:p)
