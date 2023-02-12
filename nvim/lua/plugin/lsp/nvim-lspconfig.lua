local api = vim.api
local util = require("lspconfig/util")
local global = require("core.global")
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

lspconfig.pylsp.setup({})

lspconfig.gopls.setup({
	cmd = { "gopls", "--remote=auto" },
	-- on_attach = enhance_attach,
	capabilities = capabilities,
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
	},
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		require("plugin.lsp.handlers").on_attach(client, bufnr)
	end,
})

lspconfig.jsonls.setup({
	on_attach = require("plugin.lsp.handlers").on_attach,
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup({
	capabilities = capabilities,
	on_attach = require("plugin.lsp.handlers").on_attach,
})
lspconfig.html.setup({
	on_attach = require("plugin.lsp.handlers").on_attach,
})
lspconfig.hls.setup({})
lspconfig.svelte.setup({
	on_attach = require("plugin.lsp.handlers").on_attach,
})
