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
Plugin 'bling/vim-airline'                " Super status line
Plugin 'ervandew/supertab'                " Tab for autocomplete trigger
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Language support
" Rust
"Plugin 'rust-lang/rust.vim'
"Plugin 'phildawes/racer'
" Python
Plugin 'davidhalter/jedi-vim'
" Elixir
Plugin 'elixir-lang/vim-elixir'

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

" Navigation/Input rules
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set nofoldenable
set bs=2

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

" CtrlP
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set wildignore+=*/migrations/*
set wildignore+=*/bower_components/*
set wildignore+=*/node_modules/*
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" Syntastic bindings
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': [] }
let g:syntastic_enable_highlighting = 1
let g:syntastic_python_checkers = ['flake8']

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 0

" Aliases
nnoremap <leader>n <Esc>:NERDTree<CR>
nnoremap <leader>p <Esc>:CtrlP<CR>
nnoremap <leader>l <Esc>:TagbarToggle<CR>
nnoremap <leader>s <Esc>:Ack<space>
nnoremap <leader>tv <Esc>:ConqueTermVSplit bash -l<CR>
nnoremap <leader>tt <Esc>:ConqueTermTab bash -l<CR>
nnoremap <leader>ts <Esc>:ConqueTermSplit bash -l<CR>

" Allow project safe vim files
set exrc

let g:ctrlp_lazy_update = 100
let g:ctrlp_clear_cache_on_exit = 1
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --ignore ''bower_components'' --ignore ''media'' --ignore ''.pyc'' --hidden -g ""'
endif

" Always start nerdtree
let NERDTreeIgnore = ['\.pyc$']
autocmd VimEnter * NERDTree 
autocmd VimEnter * wincmd p

" Custom syntax highlighting
au BufRead,BufNewFile *.tac set ft=python
