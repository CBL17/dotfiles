require('plugins.dap.cpp')
require('plugins.dap.python')

local dap = require 'dap'
local dapui = require 'dapui'
dapui.setup()

local map = vim.keymap.set

-- Start / Continue
map('n', '<F5>', dap.continue,     { desc = "DAP: Start/Continue" })

-- Stepping
map('n', '<F10>', dap.step_over,    { desc = "DAP: Step Over" })
map('n', '<F11>', dap.step_into,    { desc = "DAP: Step Into" })
map('n', '<F12>', dap.step_out,     { desc = "DAP: Step Out" })

-- Breakpoints
map('n', '<Leader>db', dap.toggle_breakpoint,
    { desc = "DAP: Toggle Breakpoint" })
map('n', '<Leader>dB', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = "DAP: Set Conditional Breakpoint" })
map('n', '<Leader>dr', dap.clear_breakpoints,
    { desc = "DAP: Clear All Breakpoints" })

-- REPL and UI
map('n', '<Leader>de', dap.repl.open,    { desc = "DAP: Open REPL" })
map('n', '<Leader>dh', dap.run_last,     { desc = "DAP: Run Last" })

-- Evaluate in floating window
map({'n', 'v'}, '<Leader>dp', function()
  dap.repl.toggle({ height = 10 })
end, { desc = "DAP: Toggle REPL Panel" })
map('n', '<Leader>dq', dap.terminate,    { desc = "DAP: Terminate Debugging" })

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
