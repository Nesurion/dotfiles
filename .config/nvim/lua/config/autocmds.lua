-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Dim background when tmux focus is lost (works with tmux focus-events on)
vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#191926" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#191926" })
  end,
})
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "#1e2030" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1e2030" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    vim.diagnostic.enable(false, { bufnr = args.buf })
  end,
})
