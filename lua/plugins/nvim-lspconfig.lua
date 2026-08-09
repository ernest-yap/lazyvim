return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          {
            "gD",
            function()
              vim.cmd("vsplit")
              vim.lsp.buf.definition()
            end,
            desc = "Goto Definition (Split)",
            has = "definition",
          },
        },
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
      },
      eslint = {
        settings = {
          workingDirectories = { mode = "auto" },
          experimental = {
            useFlatConfig = true,
          },
        },
      },
      vtsls = {
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = false,
            tsdk = vim.fn.expand("~/.nvm/versions/node/v22.14.0/lib"),
          },
        },
      },
    },
  },
}
