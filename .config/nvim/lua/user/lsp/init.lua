local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.mason"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
require "user.lsp.rust"
require "user.lsp.go"
require('go').setup()
require'lspconfig'.rust_analyzer.setup{}

local lsp = require('lsp-zero')

lsp.preset('recommended')


lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
  'anakin_language_server'
})

lsp.nvim_workspace()

lsp.setup()
