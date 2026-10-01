-- Breadcrumbs for setting up java with neovim

-- Plugin
-- { "gipo355/nvim-intellij-lsp", opts = { server_dir = "~/.local/share/intellij-server" } }

-- spring properties
vim.filetype.add({
  pattern = {
    [".*/application.*%.yaml"] = "springyaml",
    [".*/application.*%.yml"] = "springyaml",
    [".*/application%.yaml"] = "springyaml",
    [".*/application%.yml"] = "springyaml",
  },
})
vim.treesitter.language.register("yaml", "springyaml")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "springyaml",
  callback = function(args)
    vim.treesitter.start(args.buf, "yaml")
  end,
})

-- nvim-dap
local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

vim.keymap.set("n", "<leader>dn", dap.continue, { desc = "Debug: continue" })
vim.keymap.set("n", "<leader>de", dap.step_over, { desc = "Debug: step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: step into" })
vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Debug: step out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: conditional breakpoint" })
vim.keymap.set("n", "<leader>lp", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Debug: log point" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: run last" })

-- nvim lsp
require("intellij-lsp").setup({
})
vim.lsp.config("intellij", {
  on_attach = on_attach,
  jvm_args = {
    '-Didea.max.intellisense.filesize=20000',
  },
  filetypes = {
    "java",
    "kotlin",
    "springyaml",
  },
})
vim.lsp.enable("intellij")
