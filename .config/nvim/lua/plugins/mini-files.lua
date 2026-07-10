return {
  "nvim-mini/mini.files",
  version = false,
  opts = {
    windows = {
      preview = true,
      width_focus = 40,
      width_preview = 60,
    },
    options = {
      use_as_default_explorer = true,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf = args.data.buf_id
        vim.keymap.set("n", "gy", function()
          local entry = MiniFiles.get_fs_entry()
          if entry then
            vim.fn.setreg("+", entry.name)
            vim.notify("Yanked: " .. entry.name)
          end
        end, { buffer = buf, desc = "Yank filename" })
        vim.keymap.set("n", "gf", function()
          local entry = MiniFiles.get_fs_entry()
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
        local mf = require("mini.files")
        if not mf.close() then
          mf.open(vim.uv.cwd())
        end
      end,
      desc = "Explorer (mini.files)",
    },
    {
      "<leader>fE",
      function()
        local mf = require("mini.files")
        if not mf.close() then
          mf.open(vim.api.nvim_buf_get_name(0))
        end
      end,
      desc = "Explorer (reveal current file)",
    },
    {
      "-",
      function()
        local mf = require("mini.files")
        if not mf.close() then
          mf.open(vim.uv.cwd())
        end
      end,
      desc = "Open parent directory (mini.files)",
    },
  },
}
