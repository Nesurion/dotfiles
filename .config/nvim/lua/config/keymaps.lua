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

vim.keymap.set("n", "<leader>/", function()
  local cwd = vim.fn.getcwd()

  -- Check if we're in a Neo-tree buffer
  if vim.bo.filetype == "neo-tree" then
    local success, manager = pcall(require, "neo-tree.sources.manager")
    if success then
      local state = manager.get_state("filesystem")
      if state and state.tree then
        local node = state.tree:get_node()
        if node then
          -- Set cwd to the selected node's directory
          cwd = (node.type == "directory") and node.path or vim.fn.fnamemodify(node.path, ":h")
        end
      end
    end
  end

  -- Use the snacks picker to search for text in files within the specified cwd
  require("snacks").picker.grep({
    cwd = cwd, -- Limit the search to the selected directory
    prompt_title = "Search in Files in " .. cwd,
  })
end, { desc = "Search in Files (Contents) in Neo-tree Directory" })

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

-- Toggle between Tokyo Night and Tokyo Night Day
vim.keymap.set("n", "<leader>ub", function()
  local current_bg = vim.o.background
  if current_bg == "dark" then
    vim.o.background = "light"
    vim.cmd("colorscheme tokyonight-day")
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme tokyonight")
  end
end, { desc = "Toggle Tokyo Night theme" })

-- Create new buffer
vim.keymap.set("n", "<leader>bn", function()
  vim.cmd("enew")
end, { desc = "New buffer" })

-- Page up/down scrolling
vim.keymap.set("n", "<PageUp>", "<C-b>", { noremap = true, silent = true, desc = "Scroll page up" })
vim.keymap.set("n", "<PageDown>", "<C-f>", { noremap = true, silent = true, desc = "Scroll page down" })
