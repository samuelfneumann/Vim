set background=dark
highlight clear
syntax reset

let g:colors_name="ubuntu"
let colors_name="ubuntu"

let s:black       = { "gui": "#1f1f1f", "cterm": "0" }
let s:red         = { "gui": "#fc5442", "cterm": "1" }
let s:green       = { "gui": "#4bdc5b", "cterm": "2" }
let s:yellow      = { "gui": "#ecbb37", "cterm": "3" }
let s:blue        = { "gui": "#4986cf", "cterm": "4" }
let s:purple      = { "gui": "#c051cd", "cterm": "5" }
let s:cyan        = { "gui": "#33c7de", "cterm": "6" }
let s:gray        = { "gui": "#6a6a6a", "cterm": "7" }
let s:darkgray    = { "gui": "#4e4e4e", "cterm": "8" }
let s:pink		  = { "gui": "#f35ca5", "cterm": "9" }
let s:brown		  = { "gui": "#b19069", "cterm": "10" }
let s:orange      = { "gui": "#ec7a26", "cterm": "11" }
let s:teal        = { "gui": "#33deab", "cterm": "12" }
let s:indigo      = { "gui": "#835cb1", "cterm": "13" }
let s:mint        = { "gui": "#5ad9d1", "cterm": "14" }
let s:white       = { "gui": "#ffffff", "cterm": "15" }

let s:fg		  = { "gui": "#f6f6f5", "cterm": "15" }
let s:bg          = { "gui": "#2c2c2c", "cterm": "none" }

let s:comment_fg  = { "gui": "#6a6a6a", "cterm": "7", "attr": "bold" }
let s:linenr_bg   = s:bg
let s:linenr_fg   = { "gui": "#6a6a6a", "cterm": "7", "attr": "bold" }
let s:non_text    = s:indigo
let s:cursor_line = { "gui": "#4e4e4e", "cterm": "8", "attr": "bold" }
let s:color_col   = s:teal
let s:status_line = s:darkgray
let s:status_line_nc = s:gray
let s:selection   = s:darkgray
let s:vertsplit   = s:gray
let s:gutter_bg   = s:bg


" Highlight trailing whitespace
exec "hi _UbuntuExtraWhitespace" . " guibg=" . s:red.gui . " ctermbg=" . s:red.cterm
match _UbuntuExtraWhitespace /\s\+$/
augroup TrailingWhiteSpace
	autocmd!
	autocmd BufWinEnter * match _UbuntuExtraWhitespace /\s\+$/
	autocmd InsertEnter * match _UbuntuExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match _UbuntuExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()
augroup end

" Set the terminal colours if termguicolors is set or in a GUI
if has('gui_running') || has('termguicolors') && &termguicolors
	let g:terminal_ansi_colors = [
				\ s:black.gui,
				\ s:red.gui,
				\ s:green.gui,
				\ s:yellow.gui,
				\ s:blue.gui,
				\ s:purple.gui,
				\ s:cyan.gui,
				\ s:gray.gui,
				\ s:darkgray.gui,
				\ s:pink.gui,
				\ s:brown.gui,
				\ s:orange.gui,
				\ s:teal.gui,
				\ s:indigo.gui,
				\ s:mint.gui,
				\ s:white.gui,
				\]
endif

" Function to auto-highlight
function! s:h(group, fg, bg, attr)
	exec "hi clear " . a:group
  if type(a:fg) == type({})
    exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" . a:fg.cterm
  else
    exec "hi " . a:group . " guifg=NONE cterm=NONE"
  endif
  if type(a:bg) == type({})
    exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" . a:bg.cterm
  else
    exec "hi " . a:group . " guibg=NONE ctermbg=NONE"
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  else
    exec "hi " . a:group . " gui=NONE cterm=NONE"
  endif
endfun

" Theme settings
" User interface colors {
" call s:h("Normal", s:fg, s:bg, "")
call s:h("Normal", s:fg, "", "")

call s:h("Cursor", s:bg, s:blue, "")
call s:h("CursorColumn", "", s:cursor_line, "")
call s:h("CursorLine", "", s:cursor_line, s:cursor_line.attr)

" call s:h("LineNr", s:linenr_fg, s:linenr_bg, "")
call s:h("LineNr", s:linenr_fg, "", "")
call s:h("CursorLineNr", s:fg, "", s:linenr_fg.attr)

call s:h("DiffAdd", s:green, "", "")
call s:h("DiffChange", s:yellow, "", "")
call s:h("DiffDelete", s:red, "", "")
call s:h("DiffText", s:blue, "", "")

call s:h("IncSearch", s:black, s:yellow, "")
call s:h("Search", s:black, s:yellow, "")

call s:h("ErrorMsg", s:fg, "", "")
call s:h("ModeMsg", s:fg, "", "")
call s:h("MoreMsg", s:fg, "", "")
call s:h("WarningMsg", s:red, "", "")
call s:h("Question", s:purple, "", "")

call s:h("Pmenu", s:bg, s:fg, "")
call s:h("PmenuSel", s:fg, s:blue, "")
call s:h("PmenuSbar", "", s:selection, "")
call s:h("PmenuThumb", "", s:fg, "")

call s:h("SpellBad", "", "", "underline")
call s:h("SpellCap", s:blue, "", "")
call s:h("SpellLocal", s:indigo, "", "")
call s:h("SpellRare", s:orange, "", "")

call s:h("StatusLine", s:fg, s:status_line, "")
call s:h("StatusLineNC", s:fg, s:status_line_nc, "")
call s:h("TabLine", s:fg, s:status_line, "")
call s:h("TabLineFill", s:fg, s:status_line, "")
call s:h("TabLineSel", s:fg, s:bg, "bold")

if has('gui_running') || (has('termguicolors') && &termguicolors)
	call s:h("Visual", "", s:selection, "")
	call s:h("VisualNOS", "", s:selection, "")
else
	call s:h("Visual", "", s:selection, "")
	call s:h("VisualNOS", "", s:selection, "")
endif

call s:h("ColorColumn", "", s:color_col, "")
call s:h("Conceal", s:fg, "", "")
call s:h("Directory", s:blue, "", "")
call s:h("VertSplit", s:vertsplit, s:vertsplit, "")
call s:h("Folded", s:fg, "", "")
call s:h("FoldColumn", s:fg, "", "")
call s:h("SignColumn", s:fg, "", "")

call s:h("MatchParen", s:green, "", "underline")
call s:h("SpecialKey", s:fg, "", "")
call s:h("Title", s:green, "", "")
call s:h("WildMenu", s:fg, "", "")

call s:h("Folded", s:indigo, "", "italic")
" }


" Syntax colors {
" Whitespace is defined in Neovim, not Vim.
" See :help hl-Whitespace and :help hl-SpecialKey
call s:h("Whitespace", s:non_text, "", "")
call s:h("NonText", s:non_text, "", "")
call s:h("Comment", s:comment_fg, "", s:comment_fg.attr)
call s:h("Constant", s:cyan, "", "")
call s:h("String", s:green, "", "")
call s:h("Character", s:orange, "", "")
call s:h("Number", s:yellow, "", "")
call s:h("Boolean", s:pink, "", "")
call s:h("Float", s:indigo, "", "")

call s:h("Identifier", s:purple, "", "")
call s:h("Function", s:cyan, "", "")
call s:h("Statement", s:indigo, "", "")

call s:h("Conditional", s:purple, "", "")
call s:h("Repeat", s:brown, "", "")
call s:h("Label", s:mint, "", "")
call s:h("Operator", s:cyan, "", "")
call s:h("Keyword", s:pink, "", "")
call s:h("Exception", s:orange, "", "")

call s:h("PreProc", s:cyan, "", "")
call s:h("Include", s:purple, "", "")
call s:h("Define", s:pink, "", "")
call s:h("Macro", s:teal, "", "")
call s:h("PreCondit", s:mint, "", "")

call s:h("Type", s:indigo, "", "")
call s:h("StorageClass", s:purple, "", "")
call s:h("Structure", s:indigo, "", "")
call s:h("Typedef", s:indigo, "", "")

call s:h("Special", s:pink, "", "")
call s:h("SpecialChar", s:fg, "", "")
call s:h("Tag", s:fg, "", "")
call s:h("Delimiter", s:fg, "", "")
call s:h("SpecialComment", s:fg, "", "")
call s:h("Debug", s:fg, "", "")
call s:h("Underlined", s:fg, "", "")
call s:h("Ignore", s:fg, "", "")
call s:h("Error", s:red, s:gutter_bg, "")
call s:h("Todo", s:purple, "", "")

" Python syntax
call s:h("pythonDecoratorName", s:indigo, "", "")

" }


" Plugins {
" GitGutter
call s:h("GitGutterAdd", s:green, s:gutter_bg, "")
call s:h("GitGutterDelete", s:red, s:gutter_bg, "")
call s:h("GitGutterChange", s:yellow, s:gutter_bg, "")
call s:h("GitGutterChangeDelete", s:red, s:gutter_bg, "")
" Fugitive
call s:h("diffAdded", s:green, "", "")
call s:h("diffRemoved", s:red, "", "")
" Julia-vim
call s:h("juliaFunctionCall", s:blue, "", "")
call s:h("juliaSemicolon", s:mint, "", "")
call s:h("juliaColon", s:mint, "", "")
call s:h("juliaParDelim", s:teal, "", "")
call s:h("juliaRangeKeyword", s:yellow, "", "")
" }



" Git {
call s:h("gitcommitSummary", s:pink, "", "")
call s:h("gitcommitComment", s:comment_fg, "", "")
call s:h("gitcommitUnmerged", s:red, "", "")
call s:h("gitcommitOnBranch", s:fg, "", "")
call s:h("gitcommitBranch", s:purple, "", "")
call s:h("gitcommitDiscardedType", s:red, "", "")
call s:h("gitcommitSelectedType", s:green, "", "")
call s:h("gitcommitHeader", s:fg, "", "")
call s:h("gitcommitUntrackedFile", s:cyan, "", "")
call s:h("gitcommitDiscardedFile", s:red, "", "")
call s:h("gitcommitSelectedFile", s:green, "", "")
call s:h("gitcommitUnmergedFile", s:yellow, "", "")
call s:h("gitcommitFile", s:fg, "", "")
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile
" }

" Fix colors in neovim terminal buffers {
  if has('nvim')
    let g:terminal_color_0 = s:black.gui
    let g:terminal_color_1 = s:red.gui
    let g:terminal_color_2 = s:green.gui
    let g:terminal_color_3 = s:yellow.gui
    let g:terminal_color_4 = s:blue.gui
    let g:terminal_color_5 = s:purple.gui
    let g:terminal_color_6 = s:cyan.gui
    let g:terminal_color_7 = s:white.gui
    let g:terminal_color_8 = s:black.gui
    let g:terminal_color_9 = s:red.gui
    let g:terminal_color_10 = s:green.gui
    let g:terminal_color_11 = s:yellow.gui
    let g:terminal_color_12 = s:blue.gui
    let g:terminal_color_13 = s:purple.gui
    let g:terminal_color_14 = s:cyan.gui
    let g:terminal_color_15 = s:white.gui
    let g:terminal_color_background = s:bg.gui
    let g:terminal_color_foreground = s:fg.gui
  endif
" }
