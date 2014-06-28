execute pathogen#infect()

" Various display stuff
syntax on
filetype on
filetype plugin indent on
set rnu
set hlsearch
set background=dark
set t_Co=16
colorscheme solarized

au FileType python set tabstop=4
au FileType python set shiftwidth=4

" Fugitive bindings
map <leader>ggs :Gstatus<CR>
map <leader>ggc :Gcommit<CR>
map <leader>gga :Gwrite<CR>
map <leader>ggb :Gblame<CR>
map <leader>ggd :Gdiff<CR>

" Ack bindings
map <leader>ack <Esc>:Ack!

" Syntastic bindings
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_enable_highlighting = 1
let g:syntastic_python_checkers = ['pyflakes']

" ConqueTerm bindings
map <leader>vsb <Esc>:ConqueTermVSplit bash<CR>

" TaskList bindings
map <unique> <Leader>td <Plug>TaskList

" TagBar bindings
let g:tagbar_usearrows = 1
let g:tagbar_autoclose = 0
nnoremap <leader>l :TagbarToggle<CR>

" CtrlP
map <leader>p <Esc>:CtrlP<CR>

set foldmethod=indent
set foldlevel=99

set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

set bs=2 "set backspace to be able to delete previous characters

set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]\ %{fugitive#statusline()}

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

" Templating rules
autocmd BufNewFile test_*.py TSkeletonSetup django_test.py
autocmd BufNewFile */management/commands/*.py TSkeletonSetup django_manage.py
autocmd BufNewFile */templates/*/*.html TSkeletonSetup django_template.html
autocmd BufNewFile */static/*/*_views.js TSkeletonSetup backbone_views.js
