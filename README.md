# vim
Configuration files for vim.

This repository is structured in a way that if you clone it and rename the
appropriate files (outlined below), then your vim should be configured to work
exactly as outlined in this readme. No further adjustments should be necessary.

## Installation

```bash
cd ~/Documents
git clone git@github.com:samuelfneumann/vim.git
cd vim
ln -s vim ~/.vim
ln -s vimrc.vim ~/.vimrc
```

Then, if desired, install the plugins as outlined in the `Plugins` section
below. The plugins use git submodules, so most should come for free.

## Shortcuts
- Provide hotkeys here

## Plugins

All plugins use the built-in Vim plugin manager. They do not use Vundle, or
Vim-plug or any other complicated plugin manager. Rather, everything must be
done manually by hand using `git` and Vim's builtin plugin system.

### Julia-Vim

[Julia-Vim](https://github.com/JuliaEditorSupport/julia-vim/tree/master/keymap)
is used to get `LaTeΧ` symbols as-you-type as well as to support syntax
highlighting in `Julia`. The plugin options are defined in
`vimrc` under the relevant folding. To install this plugin:

```bash
cd ~/.vim
mkdir -p pack/plugins/start && cd pack/plugins/start
git clone git://github.com/JuliaEditorSupport/julia-vim.git
```
### JuliaFormatter
[JuliaFormatter](https://github.com/kdheepak/JuliaFormatter.vim) is used to
format `Julia` code, since the
[Julia-Vim](https://github.com/JuliaEditorSupport/julia-vim/tree/master/keymap)
plugin formats it in a very strange way. The plugin does not follow the Blue
style but instead adds some extra spacing for function arguments and the
closing `)` when function arguments are placed on sequential lines.
The JuliaFormatter plugin has a lot of
functionality for formatting `Julia` code according to different style guides,
and it conforms to the Blue style guide as well.
The formatting of this plugin is remapped to `=G` to format from the cursor to
the end of the file and `=` to format a selection, and `==` to format a line,
as is the usual case in vim.

This plugin has a few quirks. Because it's calling some `Julia` code
under-the-hood and it's not working just with vim scripts, it is slower
than running the built-in vim formatter. Additionally, when formatting a
selection or a single line, none of the surrounding context is taken into
account.

To install this plugin:
```bash
cd ~/.vim
mkdir -p pack/plugins/start && cd pack/plugins/start
git clone git@github.com:kdheepak/JuliaFormatter.vim.git
```

You should also create a sysimage in order to speed up the plugin. This process
is described on the plugin's github page in more details, but to create a
sysimage:

```bash
cd /path/to/JuliaFormatter.vim/
julia --project scripts/packagecompiler.jl
```

The `vimrc` file already has the option set to look for this sysimage. If you
would like to create a sysimage in a directory other than the default
directory, you will have to specify this in the `vimrc` file:

```bash
let g:JuliaFormatter_use_sysimage=1
let g:JuliaFormatter_sysimage_path="/path/to/julia_sysimage.so"
```

### UltiSnips
[UltiSnips](https://github.com/SirVer/ultisnips) is used for code snippets. To
install:

```bash
cd ~/.vim
mkdir -p pack/plugins/start && cd pack/plugins/start
git clone git@github.com:SirVer/ultisnips.git
```

You can use any snippets you would like, or even define your own. I use
[vim-snippets](https://github.com/honza/vim-snippets). To install:

```bash
cd ~/.vim
mkdir -p pack/plugins/start && cd pack/plugins/start
git clone git@github.com:samuelfneumann/vim-snippets.git
```

### VimTex
[VimTex](https://github.com/lervag/vimtex) is used for `LaTeχ`. To install:

```bash
cd ~/.vim
mkdir -p pack/plugins/start && cd pack/plugins/start
git clone git@github.com:lervag/vimtex.git
```

### NERDCommenter

[NERDCommenter](https://github.com/preservim/nerdcommenter) is used to provide
some nice commenting functionality. To install:

```bash
cd ~/.vim
mkdir -p pack/plugins/start && cd pack/plugins/start
git clone git@github.com:preservim/nerdcommenter.git
```

### Lightline

[Lightline](https://github.com/itchyny/lightline.vim) is used for the status
and tablines. If you use it, it will overwrite
the default statusline and tabline included in `vimrc.vim`. If you don't use
Lightline, then the default status line and tabling will be used. To install:

```bash
cd ~/.vim
mkdir -p pack/plugins/start && cd pack/plugins/start
git clone git@github.com:itchyny/lightline.vim.git

cd ~/.vim/autoload/lightline/colorscheme
ln -s pathToThisRepo/vim/autoload/lightline/colorscheme/monterey.vim .
```

This will also install the included lightline theme, called "Monterey" which
is based off the colours of the terminal. This theme file is located at:
```
vim/autoload/lightline/colorscheme/monterey.vim
```

### tmux-vim-navigator

[tmux-vim-navigator](https://github.com/christoomey/vim-tmux-navigator)
is used to allow seamless integration of vim and tmux. It
remaps the `<c-h/j/k/l>` keys so that these keys allow for pane switching
inside of tmux and inside of vim. This allows for seamless integration of vim
and tmux, as you can seamlessly go from a vim pane to a tmux pane, and back and
forth. If using this plugin in vim, ensure it is also installed for tmux as
well.

Actually, the above plugin does not work for vim's terminal mode. I have made a
fork of that plugin that addresses this issue. Installing my fork will ensure
that the tmux navigation works in all vim modes, including terminal mode.

To install tmux-vim-navigator:
```bash
cd ~/.vim
mkdir -p pack/plugins/start && cd pack/plugins/start
git clone git@github.com:samuelfneumann/vim-tmux-navigator.git
```
