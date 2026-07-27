return {
  "FylerOrg/fyler.nvim",
  opts = {
    kind = "split_left_most",
    use_as_default_explorer = true,
    follow_current_file = true,
    ui = {
      hidden_items = {
        switches = {},
        patterns = {},
        always_visible = {},
        always_hidden = {},
      },
      indent_guides = true,
    },
  },
  init = function()
    local function fyler_entry()
      local finder = require("fyler.finder")
      local inst = finder.instance_get_or_nil()
      if not inst then return end
      return finder.parse_cursor_line(inst)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fyler_finder",
      callback = function(args)
        local buf = args.buf
        vim.keymap.set("n", "<leader>y", function()
          local entry = fyler_entry()
          if entry then
            vim.fn.setreg("+", entry.name)
            vim.notify("Yanked: " .. entry.name)
          end
        end, { buffer = buf, desc = "Yank filename" })
        vim.keymap.set("n", "<leader>f", function()
          local entry = fyler_entry()
          if entry then
            vim.fn.setreg("+", entry.path)
            vim.notify("Yanked: " .. entry.path)
          end
        end, { buffer = buf, desc = "Yank full path" })
      end,
    })
  end,
  keys = {
    {
      "<leader>e",
      function()
        require("fyler").open({ kind = "split_left_most" })
      end,
      desc = "Explorer (fyler)",
    },
    {
      "<leader>E",
      function()
        require("fyler").open({ kind = "split_left_most", root_path = vim.fn.expand("%:p:h") })
      end,
      desc = "Explorer (reveal current file)",
    },
    {
      "-",
      function()
        require("fyler").open({ kind = "split_left_most" })
      end,
      desc = "Open parent directory (fyler)",
    },
  },
}
