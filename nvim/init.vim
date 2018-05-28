" Plugins
call plug#begin()

Plug 'lifepillar/vim-solarized8'
Plug 'scrooloose/nerdtree'
Plug 'wesQ3/vim-windowswap'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'

" Language Specific
" Typescript
Plug 'leafgarland/typescript-vim'
" Scala
Plug 'derekwyatt/vim-scala'
" Elixir
Plug 'elixir-editors/vim-elixir'
" Thrift
Plug 'solarnz/thrift.vim'

call plug#end()


let current_term=$TERM


" Display settings
syntax on
filetype on
set number
set hlsearch

" Solarized settings
let g:solarized_use16     =   1
if current_term == 'screen-16color'
set background=dark
else
set background=light
endif
set t_Co=16
colorscheme solarized8_flat


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


" Start NERDTree automatically
autocmd vimenter * NERDTree
