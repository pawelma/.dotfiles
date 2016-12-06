set shell=/bin/bash
set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'Lokaltog/vim-easymotion'
Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'

" ruby, rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
Plug 'jgdavey/vim-blockle'
Plug 'p0deje/vim-ruby-interpolation'

" nginx
Plug 'evanmiller/nginx-vim-syntax'

"Plug 'wakatime/vim-wakatime'

" Interface and colors
Plug 'flazz/vim-colorschemes'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kristijanhusak/vim-hybrid-material'

Plug 'tpope/vim-commentary'

call plug#end()

" set tab width
set softtabstop=2
set shiftwidth=2
set tabstop=2

" Use spaces instead of tabs
set expandtab

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch

" color scheme
" colorscheme desert
set background=dark
colorscheme hybrid_reverse
set guifont="Source Code Pro"\ 12
set number
set ignorecase
set vb " turns off visual bell

" set relative line numbering
set rnu

" Airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "hybrid"

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=100		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

map Q gq

set noswapfile                " disable fucking swapfile
