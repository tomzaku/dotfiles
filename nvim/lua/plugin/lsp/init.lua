local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("plugin.lsp.nvim-lspconfig")
require("plugin.lsp.handlers").setup()
require("plugin.lsp.mason")
require("plugin.lsp.null-ls")
require("plugin.lsp.trouble")
require("plugin.lsp.lspsaga")
require("nvim-lsp-installer").setup({
    automatic_installation = false, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
