-- NOTE: an util for replacing

return {
  {
    "nvim-pack/nvim-spectre",
    build = "sh ./build.sh",
    dependencies = { "noib3/nvim-oxi" },
    cmd = "Spectre",
    opts = {
      open_cmd = "noswapfile vnew",
      default = {
        replace = {
          cmd = "oxi",
        },
      },
      find_engine = {
        ["rg"] = {
          args = {
            -- default args
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            --
            -- additional args
            "--pcre2",
          },
        },
      },
    },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },
}
