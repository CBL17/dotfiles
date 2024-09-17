      require("nvim-treesitter.configs").setup({
          ensure_installed = { "c", "asm", "bash", "cmake", "cpp", "gitcommit", "gitignore", "json", "nasm", "objdump", "python", "verilog", "zig"},
          auto_install = true,
          sync_install = false,
          highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
          },
          indent = { enable = true },
        })
