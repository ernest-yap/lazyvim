-- Pick the formatter per buffer: biome when the project has a biome config
-- (require_cwd), otherwise fall back to prettierd/prettier. Resolved on every
-- format call, so switching projects hotswaps the formatter.
local function js_formatters(bufnr)
  if require("conform").get_formatter_info("biome", bufnr).available then
    return { "biome", "biome-organize-imports" }
  end
  return { "prettierd", "prettier", stop_after_first = true }
end

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = js_formatters,
      javascriptreact = js_formatters,
      typescript = js_formatters,
      typescriptreact = js_formatters,
    },
    formatters = {
      biome = {
        require_cwd = true,
      },
    },
  },
}
