" To run after ftplugin files are run, which modifies formatoptions

augroup GitCommitTextWidth
	" Git commit body should be only 72 characters long
	autocmd!
	autocmd FileType gitcommit setlocal textwidth=72
augroup end
augroup TextFormatting
	autocmd!
	" Automatic formatting of paragraphs
	autocmd FileType text setlocal formatoptions+=a 
augroup end
set formatoptions+=t " Auto wrap text using textwidth
set formatoptions+=c " Auto wrap comments using textwidth
set formatoptions+=r " Automatically insert comment leader on <ENTER>
set formatoptions+=n " Recognize numbered lists when formatting
set formatoptions-=l " Long lines should be broken in insert mode
set formatoptions+=j " Remove comment leader when joining lines
set formatoptions+=q " Allow formatting of comments with "gq"

