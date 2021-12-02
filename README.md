# vim
Configuration files for vim

## Installation

```bash
cd ~/Documents
git clone git@github.com:samuelfneumann/vim.git
cd vim
ln -s vim ~/.vim
ln -s vimrc.vim ~/.vimrc
```

Then, if desired, install the plugins as outlined in the `Plugins` section
below.

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
