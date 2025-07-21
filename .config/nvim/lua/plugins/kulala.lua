return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Ro", "<cmd>lua require('kulala').open()<cr>", desc = "Open UI", ft = "http" },
  },
  opts = {
    ui = {
      show_icons = "signcolumn",
    },
  },
}
