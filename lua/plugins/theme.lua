return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },
  --  {
  --    "Mofiqul/dracula.nvim",
  --    lazy = false,
  --    priority = 1000,
  --    config = function(_, _)
  --      vim.cmd([[colorscheme dracula]])
  --    end,
  --  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.theme = "dracula-nvim"
    end,
  },
}
