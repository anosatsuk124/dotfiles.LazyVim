return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    lazy = false,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-]><C-]>",
          prev = "<C-]>[",
          next = "<C-]>]",
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
        gitrebase = true,
        hgcommit = true,
      },
      panel = { enabled = false },
    },
  },
}
