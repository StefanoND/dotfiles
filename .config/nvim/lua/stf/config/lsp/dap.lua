local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
require("nvim-dap-virtual-text").setup()

vim.fn.sign_define(
  "DapBreakpoint",
  { text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<leader>dt", "<cmd>DapUiToggle<CR>", { remap = false })
vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { remap = false })
vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { remap = false })
vim.keymap.set("n", "<leader>dr", "<cmd>require('dapui').open({reset = true})<CR>", { remap = false })
