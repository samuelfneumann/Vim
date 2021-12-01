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
is used to get `LaTeΧ` symbols as-you-type. The plugin options are defined in 
`vimrc` under the relevant folding. To install this plugin:

```bash
cd ~/.vim
mkdir -p pack/plugins/start && cd pack/plugins/start
git clone git://github.com/JuliaEditorSupport/julia-vim.git
```

