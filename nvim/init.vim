call plug#begin()

Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'wesQ3/vim-windowswap'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Display settings
syntax on
filetype on
set number
set hlsearch
set background=light
set t_Co=16
colorscheme solarized

" Navigation/Input rules
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set nofoldenable
set bs=2
set cursorcolumn

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 0
