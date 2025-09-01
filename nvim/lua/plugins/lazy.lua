require('lazy').setup({
  {'mfussenegger/nvim-dap'},
  {'L3MON4D3/LuaSnip'},
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
  {
      "ray-x/lsp_signature.nvim",
      -- event = "VeryLazy",
      -- opts = {
      --
      --   },
      -- config = function(_, opts) require'lsp_signature'.setup(opts) end
  },
})

