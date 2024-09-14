require('nvim-treesitter').setup({
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "asm", "bash", "cmake", "cpp", "gitcommit", "gitignore", "json", "nasm", "objdump", "python", "verilog", "zig"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
})
