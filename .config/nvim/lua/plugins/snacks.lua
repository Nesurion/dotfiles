return {
  "folke/snacks.nvim",
  opts = {
    bigfile = { line_length = 3000 },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          on_change = function(_, item)
            vim.g.explorer_current_path = (item and item.file) or ""
          end,
          actions = {
            confirm = function(picker, item)
              if picker.layout.opts.fullscreen then
                picker.layout:maximize()
              end
              require("snacks.explorer.actions").actions.confirm(picker, item)
            end,
          },
          on_show = function(picker)
            local winid = picker.list.win.win
            vim.keymap.set("n", "<cr>", function()
              local item = picker:current()
              if picker.layout.opts.fullscreen then
                picker.layout:maximize()
              end
              require("snacks.explorer.actions").actions.confirm(picker, item, {})
            end, { buffer = vim.api.nvim_win_get_buf(winid), nowait = true })
          end,
          win = {
            list = {
              keys = {
                ["<cr>"] = "confirm",
              },
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
