-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
local Explorer = require("utils.explorer")

local buffer_triggered = false

-- use sh file format on env
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env.*", "*.env.*" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- treat hujson (human json, e.g. tailscale acls) as jsonc
vim.filetype.add({
  extension = {
    hujson = "jsonc",
  },
})

-- show file name at the top of each window
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  callback = function()
    if vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == "" then
      vim.wo.winbar = ""
      return
    end
    vim.wo.winbar = " %f %m"
  end,
})
