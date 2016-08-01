# localindent.vim

A tiny plugin that helps you respect different indent policy across your
various projects.
It works simply by looking for a file named '.vimrc.local' in the '.git'
repository at the root of your project.

You can load any custom rules that you please, my only intended use was for
indent settings.

## Installation

Use your favorite plugin manager and simply clone the repository where it
should go :).
I recommend '([pathogen](https://github.com/tpope/vim-pathogen)' for the simple
reason that I am using it.

```
cd ~/.vim/bundle
git clone git://github.com/maximeh/localindent.vim.git
```

## Usage

Simply create a '.vimrc.local' file in your '.git' directory and open any
source file.

## Configuration

### `g:localindent_git_executable'

Set this variable if 'git' is not available in your path for some reason.

### `g:localindent_file_name'

Set this variable to override the file name. Default is '.vimrc.local'.
