if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/yoriy/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/yoriy/.cache/dein')
  call dein#begin('/Users/yoriy/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/yoriy/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Global plugins
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('majutsushi/tagbar')
  call dein#add('godlygeek/tabular')
  call dein#add('scrooloose/nerdtree')
  call dein#add('dense-analysis/ale')
  call dein#add('Shougo/deoplete.nvim')

  " Language based plugins
  " Go
  call dein#add('fatih/vim-go')
  " Terraform
  call dein#add('hashivim/vim-terraform')
  " markdown
  call dein#add('shime/vim-livedown')
  call dein#add('lvht/tagbar-markdown')

  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" Display settings
filetype plugin on
set number
set hlsearch

" Solarized settings
colorscheme solarized
set background=light
set t_Co=16

" Navigation/Input rules
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set nofoldenable
set bs=2
set cursorcolumn
set tw=120
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2
autocmd Filetype yml setlocal tabstop=2 shiftwidth=2
autocmd Filetype sh setlocal tabstop=2 shiftwidth=2
autocmd Filetype typescript setlocal tabstop=2 shiftwidth=2
autocmd Filetype pony setlocal tabstop=2 shiftwidth=2
autocmd Filetype tf setlocal tabstop=2 shiftwidth=2
autocmd Filetype hcl setlocal tabstop=2 shiftwidth=2
autocmd Filetype tfvars setlocal tabstop=2 shiftwidth=2

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 0

" Add shortcut for toggling the tag bar
nnoremap <F3> :TagbarToggle<cr>

" Set python executables to that in pyenv for neovim
let g:python_host_prog = $HOME.'/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/neovim3/bin/python'

"----------------------------------------------
" ALE
"----------------------------------------------

let g:ale_linters = {
\   'go': ['golangci-lint'],
\   'terraform': ['terraform-lsp'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['goimports'],
\   'terraform': ['terraform'],
\}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0 " turn off native completion in favor of deoplete

"----------------------------------------------
" deoplete
"----------------------------------------------

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

"----------------------------------------------
" NERDTree
"----------------------------------------------

" Start automatically
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd vimenter * wincmd w

" Files to ignore
let NERDTreeIgnore = [
    \ '\~$',
    \ '\.pyc$',
    \ '^\.DS_Store$',
    \ '^node_modules$',
    \ '^.ropeproject$',
    \ '^__pycache__$'
\]

" Show hidden files by default.
let NERDTreeShowHidden = 1


"----------------------------------------------
" Golang
"----------------------------------------------

let g:go_fmt_autosave = 0
let g:go_auto_type_info = 1

" deoplete configuration
let g:deoplete#sources#go#gocode_binary = $HOME.'/go/bin/gocode'

" Ale configuration
let g:ale_go_golangci_lint_executable = $HOME.'/go/bin/golangci-lint'
let g:ale_go_golangci_lint_options = '--disable-all -E typecheck -E govet -E deadcode -E errcheck -E ineffassign -E structcheck -E unused -E varcheck -E goconst -E gosec'
let g:ale_go_golangci_lint_package = 1
let g:ale_go_goimports_executable = $HOME.'/go/bin/goimports'

" Tagbar configuration for Golang
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : $HOME.'/go/bin/gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


"----------------------------------------------
" Terraform
"----------------------------------------------

function! GetTFProjectRoot(buffer)
  let l:tf_dir = ale#path#FindNearestDirectory(a:buffer, '.terraform')
  return !empty(l:tf_dir) ? fnamemodify(l:tf_dir, ':h') : ''
endfunction

call ale#linter#Define('terraform', {
\   'name': 'terraform-lsp',
\   'lsp': 'stdio',
\   'executable': 'terraform-lsp',
\   'command': '%e',
\   'project_root': function('GetTFProjectRoot'),
\   'language': 'terraform',
\})
