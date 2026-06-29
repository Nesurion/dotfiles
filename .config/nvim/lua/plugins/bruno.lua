return {
  "romek-codes/bruno.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "bru", "yaml" },
  keys = {
    { "<leader>Br", "<cmd>BrunoRun<cr>", desc = "Run request" },
    { "<leader>Be", "<cmd>BrunoEnv<cr>", desc = "Select environment" },
    { "<leader>Bs", "<cmd>BrunoSearch<cr>", desc = "Search collection" },
    { "<leader>Bf", "<cmd>BrunoToggleFormat<cr>", desc = "Toggle format" },
  },
  opts = {
    picker = "snacks",
    show_formatted_output = true,
  },
}
