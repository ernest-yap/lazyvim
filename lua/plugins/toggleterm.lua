return {
  {
    "akinsho/toggleterm.nvim",
    enabled = false,
    opts = {
      open_mapping = [[<c-/>]],
      size = function(term)
        if term.direction == "horizontal" then
          return math.floor(vim.o.lines * 0.5)
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.5)
        end
      end,
      direction = "vertical",
      shade_filetypes = {},
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
    },
    keys = {
      { "<C-/>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
  },
}
