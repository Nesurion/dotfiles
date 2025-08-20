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

vim.keymap.set("n", "<leader>e", "<cmd>Neotree focus<cr>", { desc = "NeoTree focus" })

vim.keymap.set("n", "<leader><leader>", function()
  local cwd = vim.fn.getcwd()

  -- Check if we're in a Neo-tree buffer
  if vim.bo.filetype == "neo-tree" then
    local success, manager = pcall(require, "neo-tree.sources.manager")
    if success then
      local state = manager.get_state("filesystem")
      if state and state.tree then
        local node = state.tree:get_node()
        if node then
          cwd = node.type == "directory" and node.path or vim.fn.fnamemodify(node.path, ":h")
        end
      end
    end
  end

  require("snacks").picker.files({ cwd = cwd })
end, { desc = "Find Files (Neo-tree aware)" })
-- Snacks explorer
-- Open working dir
-- vim.keymap.set("n", "<leader>e", function()
--   Snacks.explorer.open()
-- end, { desc = "Snacks Explorer" })

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
