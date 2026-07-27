
-- Dim nvim background when pane loses focus so tmux inactive-pane dimming works.
-- Requires `set -g focus-events on` in tmux.conf (already set).
vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#2d3149" }) -- @thm_surface
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#2d3149" })
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#222436" }) -- @thm_core
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#222436" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})

