-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable system clipboard integration
-- vim.opt.clipboard = "unnamedplus"

-- Allow gf / mkdnflow to find .md files recursively
vim.opt.path:append("**")
vim.opt.suffixesadd:append(".md")
