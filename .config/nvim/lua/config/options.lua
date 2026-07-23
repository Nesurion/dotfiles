-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable system clipboard integration
-- vim.opt.clipboard = "unnamedplus"

-- Allow gf / mkdnflow to find .md files recursively
vim.opt.path:append("**")
vim.opt.suffixesadd:append(".md")

-- Ensure sdkman's JDK is on PATH for LSP servers (kotlin-language-server etc.)
-- Needed because nvim may launch without sourcing .zshrc/.zshenv on macOS.
local sdkman_java = "/opt/homebrew/opt/sdkman-cli/libexec/candidates/java/current/bin"
if vim.fn.isdirectory(sdkman_java) == 1 then
  vim.env.JAVA_HOME = sdkman_java:gsub("/bin$", "")
  vim.env.PATH = sdkman_java .. ":" .. vim.env.PATH
end
