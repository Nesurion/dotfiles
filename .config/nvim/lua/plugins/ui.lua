return {
  -- disable bufferline (tabline)
  -- { "akinsho/bufferline.nvim", enabled = false },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, {
        function()
          return vim.g.explorer_current_path or ""
        end,
        cond = function()
          return (vim.g.explorer_current_path or "") ~= ""
        end,
      })
    end,
  },
}
