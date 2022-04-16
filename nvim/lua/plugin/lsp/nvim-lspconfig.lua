-- Wont used since we have LspInstall

local api = vim.api
local util = require("lspconfig/util")
local global = require("core.global")
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
--
-- function _G.reload_lsp()
--   vim.lsp.stop_client(vim.lsp.get_active_clients())
--   vim.cmd [[edit]]
-- end
--
-- function _G.open_lsp_log()
--   local path = vim.lsp.get_log_path()
--   vim.cmd("edit " .. path)
-- end
--
-- vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
-- vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')
--
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     -- Enable underline, use default values
--     underline = true,
--     -- Enable virtual text, override spacing to 4
--     virtual_text = true,
--     signs = {
--       enable = true,
--       priority = 20
--     },
--     -- Disable a feature
--     update_in_insert = false,
-- })

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
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.tsserver.setup({
	root_dir = function()
		return vim.loop.cwd()
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
})

lspconfig.jsonls.setup({})
lspconfig.cssls.setup({})
lspconfig.html.setup({})
lspconfig.hls.setup({})
lspconfig.svelte.setup({})
