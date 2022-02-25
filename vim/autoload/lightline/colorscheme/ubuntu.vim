" =============================================================================
" Filename: autoload/lightline/colorscheme/ubuntu.vim
" Author: Samuel Neumann adapted from Lokesh Krishna
" Last Change: 2021/12/15 06:16:00
"
" =============================================================================
let s:p = {'terminal': {}, 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

if lightline#colorscheme#background() ==# 'light'
  " Light variant
  let s:fg     = '#f6f6f5' " Text colour active window
  let s:bg     = '#aaaaaa' " Text colour inactive window
  let s:gray1  = '#6a6a6a'
  let s:gray2  = '#6a6a6a'
  let s:gray3  = '#6a6a6a'

  let s:blue   = '#4986cf'
  let s:green  = '#4bdc5b'
  let s:purple = '#c051cd'
  let s:red1   = '#fc5442'
  let s:red2   = '#fc5442'
  let s:pink   = '#f35ca5'
  let s:orange = '#ec7a26'
  let s:indigo = '#835cb1'
  let s:yellow = '#4986cf'
  let s:cyan   = '#33c7de'
else
  " Dark variant
  let s:fg     = '#f6f6f5' " Text colour active window
  let s:bg     = '#aaaaaa' " Text colour inactive window
  let s:gray1  = '#6a6a6a'
  let s:gray2  = '#6a6a6a'
  let s:gray3  = '#6a6a6a'

  let s:blue   = '#4986cf'
  let s:green  = '#4bdc5b'
  let s:purple = '#c051cd'
  let s:red1   = '#fc5442'
  let s:red2   = '#fc5442'
  let s:pink   = '#f35ca5'
  let s:orange = '#ec7a26'
  let s:indigo = '#835cb1'
  let s:yellow = '#4986cf'
  let s:cyan   = '#33c7de'
endif

" Set colours
let s:p.normal.left     = [ [ s:fg, s:blue, 15, 4, 'bold' ], [ s:fg, s:gray3, 15, 7] ]
let s:p.normal.middle   = [ [ s:fg, s:gray2, 15, 7 ] ]
let s:p.normal.right   = [ [ s:fg, s:blue, 15, 4, 'bold' ], [ s:fg, s:blue, 15, 4, 'bold' ] ]
let s:p.normal.error   = [ [ s:red2,   s:fg, 1, 11 ] ]
let s:p.normal.warning = [ [ s:yellow, s:fg, 3, 15 ] ]

let s:p.inactive.left   = [ [ s:bg,  s:gray1, 251, 7 ], [ s:bg, s:gray1, 251, 7 ] ]
let s:p.inactive.middle = [ [ s:bg, s:gray2, 251, 7] ]
let s:p.inactive.right  = [ [ s:bg, s:gray1, 251, 7 ], [ s:bg, s:gray1, 251, 7 ] ]

let s:p.insert.left     = [ [ s:fg, s:green, 15, 2, 'bold' ], [ s:fg, s:gray3, 15, 7] ]
let s:p.insert.right   = [ [ s:fg, s:green, 15, 2, 'bold' ], [ s:fg, s:green, 15, 2, 'bold' ] ]

let s:p.replace.left    = [ [ s:fg, s:red1, 15, 1, 'bold' ], [ s:fg, s:gray3, 15, 7] ]
let s:p.replace.right  = [ [ s:fg, s:red1, 15, 1, 'bold' ], [ s:fg, s:red1, 15, 7, 'bold' ] ]

let s:p.visual.left     = [ [ s:fg, s:cyan, 15, 6, 'bold' ], [ s:fg, s:gray3, 15, 7] ]
let s:p.visual.right   = [ [ s:fg, s:cyan, 15, 6, 'bold' ], [ s:fg, s:cyan, 15, 6, 'bold' ] ]

let s:p.terminal.left   = [ [ s:fg, s:orange, 15, 11, 'bold' ], [ s:fg, s:gray3, 15, 7 ] ]
let s:p.terminal.right = [ [ s:fg, s:orange, 15, 11, 'bold' ], [ s:fg, s:orange, 15, 11, 'bold' ] ]

let s:p.tabline.left   = [ [ s:fg, s:gray3, 15, 7 ] ]
let s:p.tabline.tabsel = [ [ s:fg, s:pink, 15, 9, 'bold' ] ]
let s:p.tabline.middle = [ [ s:fg, s:gray2, 15, 7 ] ]
let s:p.tabline.right  = [ [ s:fg, s:red1, 15, 1, 'bold' ] ]

let g:lightline#colorscheme#ubuntu#palette = lightline#colorscheme#fill(s:p)
