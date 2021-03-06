"
" ~/.vimrc (niels)
"

set nocompatible		" This option stops vim from behaving in a strongly
						" vi-compatible way. It should be at the start of any
						" vimrc file as it can affect lots of other options
						" which you may want to override.

syntax on

set background=dark
set hlsearch
set diffopt+=iwhite
set autoindent			" does the right thing (mostly) in programs
set ruler				" this makes vim show the current row and column at the bottom
						" right of the screen.

"filetype plugin indent on
set textwidth=76
set tabstop=4			" show existing tab with 4 spaces width
set shiftwidth=4		" when indenting with '>', use 4 spaces width
"set expandtab			" On pressing tab, insert 4 spaces
set noexpandtab			" donot convert tab to spaces
"retab					" forcefully recreate spaces

" Make files require tabs to separate the targets from the commands.
" ansible's yaml require spaces...

set wrapmargin=6		" This is the number of characters from the right
						" window border where wrapping starts. 

" for ansible and/or yaml filetypes:
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

".
