return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, _)
      vim.cmd([[colorscheme dracula]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.theme = "dracula-nvim"
    end,
  },
}
