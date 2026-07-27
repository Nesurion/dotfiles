return {
  -- disable bufferline (tabline)
  -- { "akinsho/bufferline.nvim", enabled = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, {
        function()
          local name = vim.api.nvim_buf_get_name(0)
          local path = name:match("^fyler%-%w+://(.+)$")
          return path and vim.fn.fnamemodify(path, ":~") or ""
        end,
        cond = function()
          local name = vim.api.nvim_buf_get_name(0)
          return name:match("^fyler%-%w+://") ~= nil
        end,
      })
    end,
  },
}
