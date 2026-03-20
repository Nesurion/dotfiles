return {
  "folke/snacks.nvim",
  opts = {
    bigfile = { line_length = 3000 },
    picker = {
      sources = {
        explorer = {
          layout = {
            preset = "sidebar",
            preview = false,
            layout = {
              width = 0.2,
              min_width = 40,
            },
          },
        },
      },
    },
  },
  keys = {
    -- Override the default <leader>e behavior to always open (not toggle)
    {
      "<leader>e",
      function()
        -- Check if explorer picker is already open
        local pickers = Snacks.picker.get({ source = "explorer" })
        if #pickers > 0 then
          -- If open, focus it instead of toggling
          pickers[1]:focus()
        else
          -- If not open, open it
          Snacks.explorer()
        end
      end,
      desc = "Explorer",
    },
    -- Reveal current buffer in explorer
    {
      "<leader>fE",
      function()
        Snacks.explorer({ cwd = vim.fn.expand("%:p:h") })
      end,
      desc = "Explorer (reveal current file)",
    },
  },
}
