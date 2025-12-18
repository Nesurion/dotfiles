-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>d", '"_d', { noremap = true })
vim.keymap.set("x", "<leader>d", '"_d', { noremap = true })
vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true })

vim.keymap.set("n", "c", '"_c', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })

vim.keymap.set("n", "<leader>yy", "0wv$hy", { noremap = true })

-- Replace word under cursor with register content
vim.keymap.set(
  "n",
  "<leader>p",
  'viw"_dP',
  { noremap = true, desc = "Replace word under cursor with register content" }
)
-- Replace line with register content
vim.keymap.set(
  "n",
  "<leader>dp",
  '"_ddP',
  { noremap = true, desc = "Replace the current line with the register content" }
)

-- Map Enter to toggle code folding
vim.api.nvim_set_keymap("n", "<CR>", "za", { noremap = true, silent = true })

-- Close the buffer with alt-d
vim.keymap.set("n", "∂", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- Format
vim.keymap.set({ "n", "v" }, "==", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- Create new buffer
vim.keymap.set("n", "<leader>bn", function()
  vim.cmd("enew")
end, { desc = "New buffer" })

-- Page up/down scrolling
vim.keymap.set("n", "<PageUp>", "<C-b>", { noremap = true, silent = true, desc = "Scroll page up" })
vim.keymap.set("n", "<PageDown>", "<C-f>", { noremap = true, silent = true, desc = "Scroll page down" })

-- Exit terminal insert mode with Esc Esc
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal insert mode" })

-- Toggle relative line numbers
vim.keymap.set("n", "<leader>ul", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { noremap = true, silent = true, desc = "Toggle Relative Line Numbers" })
