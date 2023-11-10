if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
execute 'set runtimepath+=' . $HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim'

" Required:
if dein#load_state( $HOME . '/.cache/dein' )
  call dein#begin( $HOME . '/.cache/dein' )

  " Let dein manage dein
  " Required:
  call dein#add( $HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim' )

  " Global plugins
  call dein#add('overcache/NeoSolarized')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('majutsushi/tagbar')
  call dein#add('godlygeek/tabular')
  call dein#add('nvim-lua/plenary.nvim')
  call dein#add('kyazdani42/nvim-web-devicons')
  call dein#add('MunifTanjim/nui.nvim')
  call dein#add('nvim-neo-tree/neo-tree.nvim', {
    \ 'rev': 'v2.x',
    \ 'depends': ['nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'MunifTanjim/nui.nvim'],
    \ })
  call dein#add('dense-analysis/ale')
  call dein#add('tpope/vim-fugitive')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('wesQ3/vim-windowswap')
  call dein#add('neovim/nvim-lspconfig')
  call dein#add('wsdjeg/dein-ui.vim')
  call dein#add('dhruvasagar/vim-table-mode')

  " Language based plugins
  " Go
  call dein#add('fatih/vim-go')
  " Terraform
  call dein#add('hashivim/vim-terraform')
  " Jsonnet
  call dein#add('google/vim-jsonnet')
  " Bazel
  call dein#add('google/vim-maktaba')
  call dein#add('bazelbuild/vim-bazel')
  " Frontend
  call dein#add('othree/html5.vim')
  call dein#add('pangloss/vim-javascript')
  call dein#add('evanleck/vim-svelte')
  " Python
  call dein#add('petobens/poet-v')
  " markdown
  call dein#add('shime/vim-livedown')
  call dein#add('lvht/tagbar-markdown')

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
colorscheme NeoSolarized
set background=light
set t_Co=16
set termguicolors

" Navigation/Input rules
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set nofoldenable
set bs=2
set cursorcolumn
set tw=120
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd Filetype python setlocal tabstop=4 shiftwidth=4
autocmd Filetype bzl setlocal tabstop=4 shiftwidth=4
autocmd Filetype rs setlocal tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.jlark set ft=python
autocmd BufNewFile,BufRead *.libjlark set ft=python
autocmd BufNewFile,BufRead *.jhcl set ft=hcl
autocmd BufNewFile,BufRead *.libjhcl set ft=hcl

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tagbar#enabled = 0

" Add shortcut for toggling the tag bar
nnoremap <F3> :TagbarToggle<cr>

" Fix gx
nnoremap <silent> gx :execute 'silent! !open ' . shellescape(expand('<cWORD>'), 1)<cr>

"----------------------------------------------
" Git project specific configuration
" This will attempt to load .git/vimrc if it exists.
"----------------------------------------------
let git_path = system("git rev-parse --git-dir 2>/dev/null")
let git_vimrc = substitute(git_path, '\n', '', '') . "/vimrc"
if !empty(glob(git_vimrc))
    exec ":source " . git_vimrc
endif

"----------------------------------------------
" fzf
"----------------------------------------------

let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
nnoremap <silent> <C-p> :Rg<cr>
nnoremap <silent> <leader>l :Lines<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>/ :BLines<cr>

"----------------------------------------------
" ALE
"----------------------------------------------

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['goimports'],
\   'rust': ['rustfmt'],
\   'terraform': ['terraform'],
\   'python': ['black'],
\   'typescript': ['prettier'],
\   'json': ['prettier'],
\   'yaml': ['prettier'],
\   'jsonnet': ['jsonnetfmt'],
\ }
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0 " turn off native completion in favor of deoplete

"----------------------------------------------
" NeoTree
"----------------------------------------------

let g:neo_tree_remove_legacy_commands = 1
let g:neo_tree_close_if_last_window = 1

" Start automatically
autocmd vimenter * Neotree
autocmd vimenter * wincmd w

" Show hidden files by default.
lua require("neo-tree").setup({
\   filesystem = {
\       filtered_items = {
\           visible = true,
\           hide_dotfiles = false,
\           hide_gitignored = true,
\       },
\   },
\ })

"----------------------------------------------
" Golang
"----------------------------------------------

let g:go_fmt_autosave = 0
let g:go_auto_type_info = 1

" Ale configuration
let g:ale_go_golangci_lint_package = 1

" Custom function to toggle tags for golangci
let s:golang_build_tags_set = 0
let s:base_golangci_args = '--disable-all -E typecheck -E govet -E deadcode -E errcheck -E ineffassign -E structcheck -E unused -E varcheck -E goconst -E gosec'
function! ToggleGolangCIBuildTags()
    if s:golang_build_tags_set
        let g:ale_go_golangci_lint_options = s:base_golangci_args.' --build-tags all'
        let s:golang_build_tags_set = 0
    else
        let g:ale_go_golangci_lint_options = s:base_golangci_args
        let s:golang_build_tags_set = 1
    endif
endfunction
call ToggleGolangCIBuildTags()

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
" Python
"----------------------------------------------

let g:poetv_executables = ['poetry']
let g:poetv_auto_activate = 1

"----------------------------------------------
" Svelte
"----------------------------------------------

let g:svelte_preprocessors = ['typescript']

"----------------------------------------------
" LSP
"----------------------------------------------

nnoremap <silent> <leader>t :lua vim.lsp.buf.hover()<cr>

lua <<EOF
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  require'lspconfig'.jsonnet_ls.setup{
    on_attach = on_attach,
  	formatting = {
  		-- default values
  		Indent              = 2,
  		MaxBlankLines       = 2,
  		StringStyle         = 'single',
  		CommentStyle        = 'slash',
  		PrettyFieldNames    = true,
  		PadArrays           = false,
  		PadObjects          = true,
  		SortImports         = true,
  		UseImplicitPlus     = true,
  		StripEverything     = false,
  		StripComments       = false,
  		StripAllButComments = false,
  	},
  }

  require'lspconfig'.rust_analyzer.setup{
    on_attach = on_attach,
  }

  require'lspconfig'.pyright.setup{
    on_attach = on_attach,
  }

EOF
