" =============================================================================
" Filename: autoload/lightline/colorscheme/monterey.vim
" Author: Samuel Neumann adapted from Lokesh Krishna
" Last Change: 2021/12/15 06:16:00
"
" Looks best if using the iTerm2 colour scheme included in my Dotfies GitHub
" repository. These two colour schemes are based off Apple's human interface
" design colour palette:A
"
" https://developer.apple.com/design/human-interface-guidelines/macos/visual-design/color/
" =============================================================================

let s:p = {'terminal': {}, 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

if lightline#colorscheme#background() ==# 'light'
  " Light variant
  let s:fg     = '#ffffff' " Text colour active window
  let s:bg     = '#cccccc' " Text colour inactive window
  let s:gray1  = '#8e8e93'
  let s:gray2  = '#8e8e93'
  let s:gray3  = '#8e8e93'

  let s:blue   = '#007bff'
  let s:green  = '#28cd40'
  let s:purple = '#af52de'
  let s:red1   = '#ff3b30'
  let s:red2   = '#ff3126'
  let s:pink   = '#ff2d55'
  let s:orange = '#ff9500'
  let s:indigo = '#af52de'
  let s:yellow = '#ffcc00'
  let s:cyan   = '#55bff0'
else
  " Dark variant
  let s:fg     = '#ffffff' " Text colour active window
  let s:bg     = '#cccccc' " Text colour inactive window
  let s:gray1  = '#8e8e93'
  let s:gray2  = '#8e8e93'
  let s:gray3  = '#8e8e93'

  let s:blue   = '#0a84ff'
  let s:green  = '#32d74b'
  let s:purple = '#bf5af2'
  let s:red1   = '#ff443a'
  let s:red2   = '#ff4f44'
  let s:pink   = '#ff375f'
  let s:orange = '#ff9f0a'
  let s:indigo = '#bf5af2'
  let s:yellow = '#ffd60a'
  let s:cyan   = '#5ac9f5'
endif

" Set colours
let s:p.normal.left     = [ [ s:fg, s:blue, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.normal.middle   = [ [ s:fg, s:gray2 ] ]
let s:p.normal.right   = [ [ s:fg, s:blue, 'bold' ], [ s:fg, s:blue, 'bold' ] ]
let s:p.normal.error   = [ [ s:red2,   s:fg ] ]
let s:p.normal.warning = [ [ s:yellow, s:fg ] ]
let s:p.inactive.left   = [ [ s:bg,  s:gray1 ], [ s:bg, s:gray1 ] ]
let s:p.inactive.middle = [ [ s:bg, s:gray2 ] ]
let s:p.inactive.right  = [ [ s:bg, s:gray1 ], [ s:bg, s:gray1 ] ]

let s:p.insert.left     = [ [ s:fg, s:green, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.insert.right   = [ [ s:fg, s:green, 'bold' ], [ s:fg, s:green, 'bold' ] ]

let s:p.replace.left    = [ [ s:fg, s:red1, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.replace.right  = [ [ s:fg, s:red1, 'bold' ], [ s:fg, s:red1, 'bold' ] ]

let s:p.visual.left     = [ [ s:fg, s:purple, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.visual.right   = [ [ s:fg, s:purple, 'bold' ], [ s:fg, s:purple, 'bold' ] ]

let s:p.terminal.left   = [ [ s:fg, s:orange, 'bold' ], [ s:fg, s:gray3 ] ]
let s:p.terminal.right = [ [ s:fg, s:orange, 'bold' ], [ s:fg, s:orange, 'bold' ] ]

let s:p.tabline.left   = [ [ s:fg, s:gray3 ] ]
let s:p.tabline.tabsel = [ [ s:fg, s:purple, 'bold' ] ]
let s:p.tabline.middle = [ [ s:fg, s:gray2 ] ]
let s:p.tabline.right  = [ [ s:fg, s:red1, 'bold' ] ]

let g:lightline#colorscheme#monterey#palette = lightline#colorscheme#fill(s:p)
