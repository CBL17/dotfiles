local dap = require 'dap'

local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"

dap.adapters.lldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
    {
        name = "codelldb debug",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        preRunCommands = {
            "breakpoint set --name main",
        },
    },
}

dap.configurations.c = dap.configurations.cpp
