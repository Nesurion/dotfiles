return {
  {
    dir = "ansible-vault-inline",
    name = "ansible-vault-inline",
    virtual = true,
    event = "BufReadPre",
    config = function()
      local group = vim.api.nvim_create_augroup("AnsibleVault", { clear = true })

      local function is_vault_file(buf)
        local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or ""
        return first_line:match("^%$ANSIBLE_VAULT;")
      end

      vim.api.nvim_create_autocmd("BufReadPost", {
        group = group,
        pattern = "*.yml",
        callback = function(ev)
          if not is_vault_file(ev.buf) then
            return
          end
          local file = ev.file
          local result = vim.fn.system("ansible-vault decrypt --output - " .. vim.fn.shellescape(file))
          if vim.v.shell_error == 0 then
            local lines = vim.split(result, "\n", { trimempty = false })
            if lines[#lines] == "" then
              table.remove(lines)
            end
            vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, lines)
            vim.bo[ev.buf].modified = false
            vim.b[ev.buf].ansible_vault = true
            vim.bo[ev.buf].filetype = "yaml"
          else
            vim.notify("ansible-vault decrypt failed: " .. result, vim.log.levels.ERROR)
          end
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        pattern = "*.yml",
        callback = function(ev)
          if not vim.b[ev.buf].ansible_vault then
            return
          end
          local lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
          local content = table.concat(lines, "\n") .. "\n"
          local result = vim.fn.system("ansible-vault encrypt --output - -", content)
          if vim.v.shell_error == 0 then
            local enc_lines = vim.split(result, "\n", { trimempty = false })
            if enc_lines[#enc_lines] == "" then
              table.remove(enc_lines)
            end
            vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, enc_lines)
          else
            vim.notify("ansible-vault encrypt failed: " .. result, vim.log.levels.ERROR)
            -- Prevent write of unencrypted content
            vim.cmd("echoerr 'Aborting write: encryption failed'")
          end
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        pattern = "*.yml",
        callback = function(ev)
          if not vim.b[ev.buf].ansible_vault then
            return
          end
          -- Re-decrypt so the buffer stays readable
          local file = ev.file
          local result = vim.fn.system("ansible-vault decrypt --output - " .. vim.fn.shellescape(file))
          if vim.v.shell_error == 0 then
            local lines = vim.split(result, "\n", { trimempty = false })
            if lines[#lines] == "" then
              table.remove(lines)
            end
            vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, lines)
            vim.bo[ev.buf].modified = false
          end
        end,
      })
    end,
  },
}
