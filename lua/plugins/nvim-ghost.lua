return {
  {
    "wallpants/ghost-text.nvim",
    cmd = { "GhostTextStart" },
    tag = "v2.0.1",
    opts = {
      port = 4000, -- default: 4001
      log_level = "verbose",

      autostart = false,

      filetype_domains = {
        -- markdown = { "*.openai.com*", "*.reddit.com*" },
        markdown = { "*hackmd.io*" },
      },
    },
  },
}
