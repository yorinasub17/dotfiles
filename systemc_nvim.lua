-- ----------------------------------------------
-- ALE
-- ----------------------------------------------
local systemc_root = vim.env.SYSTEMC_ROOT or "/usr/local/systemc"
local systemc_include = systemc_root .. "/include"

vim.g.ale_fixers = {
  c = { "clang-format" },
  cpp = { "clang-format" },
}
vim.g.ale_c_clangformat_style_option = "Google"
vim.g.ale_linters = {
  c = { "cc" },
  cpp = { "cc" },
}
vim.g.ale_c_cc_options = "-std=c17 -Wall"
vim.g.ale_cpp_cc_options = "-std=c++17 -Wall -isystem " .. systemc_include

-- ----------------------------------------------
-- LSP
-- ----------------------------------------------
vim.g.yori_lsp_on_attach = on_attach
if vim.lsp and vim.lsp.config and vim.lsp.enable then
  vim.lsp.config("clangd", {
    on_attach = on_attach,
    cmd = { "clangd", "--background-index" },
    init_options = {
      fallbackFlags = {
        "-std=c++17",
        "-isystem",
        systemc_include,
      },
    },
  })
  vim.lsp.enable("clangd")
end
