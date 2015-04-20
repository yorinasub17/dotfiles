" Vundle Setup
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle Plugins

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Basic
Plugin 'tpope/vim-fugitive'               " Git wrapper in vim
Plugin 'mileszs/ack.vim'                  " Vim Ack
Plugin 'altercation/vim-colors-solarized' " Solarized color
Plugin 'scrooloose/syntastic'             " Syntax checker
Plugin 'scrooloose/nerdtree'              " Package navigator
Plugin 'kien/ctrlp.vim'                   " Fuzzy search
Plugin 'majutsushi/tagbar'                " Class lister
Plugin 'pthrasher/conqueterm-vim'         " Vim Buffer Terminal

" Language support
"Plugin 'rust-lang/rust.vim'
"Plugin 'phildawes/racer'

" Load Plugins
call vundle#end()
filetype plugin indent on
" End Vundle

" Start Settings

" Display settings
syntax on
filetype on
set number
set hlsearch
set background=dark
set t_Co=16
colorscheme solarized
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]\ %{fugitive#statusline()}

" Navigation/Input rules
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Ack
if executable('ag')
    let g:ackprg = 'ag'
endif

"" Racer
"set hidden
"let g:racer_cmd = "/home/yoriy/Packages/racer/target/release/racer"
"let $RUST_SRC_PATH="/home/yoriy/Packages/rustc-nightly/src"

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Aliases
nnoremap <leader>n <Esc>:NERDTree<CR>
nnoremap <leader>p <Esc>:CtrlP<CR>
nnoremap <leader>l <Esc>:TagbarToggle<CR>
nnoremap <leader>s <Esc>:Ack<space>
nnoremap <leader>tv <Esc>:ConqueTermVSplit bash -l<CR>
nnoremap <leader>tt <Esc>:ConqueTermTab bash -l<CR>
nnoremap <leader>ts <Esc>:ConqueTermSplit bash -l<CR>
