-- ----------------------------------------------
-- lazy.nvim bootstrap and plugin registration
-- ----------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
if vim.loop.fs_stat(lazypath) then
  vim.opt.rtp:prepend(lazypath)
end

local ok_lazy, lazy = pcall(require, "lazy")
if ok_lazy then
  lazy.setup({
    "overcache/NeoSolarized",
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",
    "majutsushi/tagbar",
    "godlygeek/tabular",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "nvim-neo-tree/neo-tree.nvim",
      rev = "v2.x",
      dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    },
    "neovim/nvim-lspconfig",
    "dense-analysis/ale",
    "tpope/vim-fugitive",
    { "junegunn/fzf", build = "./install --all" },
    { "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
    "wesQ3/vim-windowswap",
    "dhruvasagar/vim-table-mode",

    -- Language plugins
  })
else
  vim.notify("lazy.nvim not found; plugin manager bootstrap failed", vim.log.levels.WARN)
end

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- ----------------------------------------------
-- Display settings
-- ----------------------------------------------
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.background = "light"
vim.opt.termguicolors = false
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.foldenable = false
vim.opt.backspace = "2"
vim.opt.cursorcolumn = true
vim.opt.textwidth = 120

vim.filetype.add({
  extension = {
    ["v"] = "verilog",
    ["sv"] = "systemverilog",
  }
})

-- ----------------------------------------------
-- Solarized settings
-- ----------------------------------------------
pcall(vim.cmd, "colorscheme NeoSolarized")
vim.cmd("highlight ExtraWhitespace ctermbg=red guibg=red")
vim.cmd([[match ExtraWhitespace /\s\+$/]])

-- ----------------------------------------------
-- Navigation/Input rules
-- ----------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "bzl", "rs" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.g.airline_powerline_fonts = 1
vim.g["airline#extensions#tagbar#enabled"] = 0

-- ----------------------------------------------
-- fzf
-- ----------------------------------------------
vim.env.FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git"
vim.keymap.set("n", "<C-p>", "<cmd>Rg<cr>", { silent = true })
vim.keymap.set("n", "<leader>l", "<cmd>Lines<cr>", { silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>Buffers<cr>", { silent = true })
vim.keymap.set("n", "<leader>/", "<cmd>BLines<cr>", { silent = true })

-- ----------------------------------------------
-- ALE
-- ----------------------------------------------
vim.g.ale_fixers = {
  ["*"] = { "remove_trailing_lines", "trim_whitespace" },

}
vim.g.ale_fix_on_save = 1
vim.g.ale_completion_enabled = 0

-- ----------------------------------------------
-- NeoTree
-- ----------------------------------------------
vim.g.neo_tree_remove_legacy_commands = 1
vim.g.neo_tree_close_if_last_window = 1
local ok_neotree, neo_tree = pcall(require, "neo-tree")
if ok_neotree then
  neo_tree.setup({
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
  })
end

-- Start automatically
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("Neotree")
    vim.cmd("wincmd w")
  end,
})

-- ----------------------------------------------
-- LSP
-- ----------------------------------------------
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

vim.g.yori_lsp_on_attach = on_attach
if vim.lsp and vim.lsp.config and vim.lsp.enable then
  -- vim.lsp.config("rust_analyzer", { on_attach = on_attach })
  -- vim.lsp.enable("rust_analyzer")
end

-- ----------------------------------------------
-- Git project specific configuration
-- This will attempt to load ./vimrc, and then .git/vimrc if it exists.
-- ----------------------------------------------
local rel_vimrc = vim.fn.getcwd() .. "/vimrc"
local git_path_rel = vim.fn.system("git rev-parse --git-dir 2>/dev/null")
local git_path = vim.fn.system("realpath " .. string.gsub(git_path_rel, "\n", ""))
local git_vimrc = string.gsub(git_path, "\n", "") .. "/vimrc"
if vim.fn.filereadable(rel_vimrc) == 1 then
  vim.cmd("source " .. rel_vimrc)
elseif vim.fn.filereadable(git_vimrc) == 1 then
  vim.cmd("source " .. git_vimrc)
end
