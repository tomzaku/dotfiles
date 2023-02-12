local status_ok, lib = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

lib.setup({
	context_commentstring = {
		enable = true,
	},
})
