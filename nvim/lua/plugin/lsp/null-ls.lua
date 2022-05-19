local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = true,
	sources = {
		formatting.prettier,
		formatting.black,
		formatting.stylua,
		formatting.eslint.with({
			extra_args = { "--resolve-plugins-relative-to=(yarn global dir)" },
		}),
		-- formatting.eslint,
		formatting.stylelint,
	},
	-- on_attach = function(client)
		-- auto formatting on save
		-- if client.resolved_capabilities.document_formatting then
		-- 	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		-- end
	-- end,
})
