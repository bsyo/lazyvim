return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      ruby_lsp = {
        mason = false,
        cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
      },
      solargraph = {
        enabled = lsp == "solargraph",
      },
      rubocop = {
        -- If Solargraph and Rubocop are both enabled as an LSP,
        -- diagnostics will be duplicated because Solargraph
        -- already calls Rubocop if it is installed
        mason = false,
        cmd = { "bundle", "exec", "rubocop", "--lsp" },
      },
      standardrb = {
        enabled = formatter == "standardrb",
      },
    },
  },
}
