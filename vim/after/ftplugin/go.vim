" Textwidth ----------------------------------------------------------------{{{
autocmd FileType go setlocal textwidth=79
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
