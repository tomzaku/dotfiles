local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("plugin.lsp.nvim-lspconfig")
require("plugin.lsp.handlers").setup()
require("plugin.lsp.lsp-installer")
require("plugin.lsp.null-ls")
require("plugin.lsp.trouble")
require("plugin.lsp.lspsaga")
