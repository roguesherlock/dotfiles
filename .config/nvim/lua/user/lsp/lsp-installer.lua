local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  vim.notify('yo mason isnt working')
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

local servers = {
  "sumneko_lua",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "volar",
  "tailwindcss",
	"gopls"
}

mason.setup()

mason_lspconfig.setup({
    ensure_installed = servers,
  }
)

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  vim.notify('yo lsp config not working')
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  lspconfig[server].setup(opts)
end
