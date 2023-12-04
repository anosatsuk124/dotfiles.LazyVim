-- NOTE: an util for replacing

return {
  {
    "nvim-pack/nvim-spectre",
    build = "sh ./build.sh",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
  -- stylua: ignore
  keys = {
    { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
  },
  },
}
