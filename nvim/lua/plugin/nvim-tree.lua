local status_ok, lib = pcall(require, "nvim-tree")
if not status_ok then
	return
end
lib.setup({})
vim.g.nvim_tree_git_hl = 0
vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
}
