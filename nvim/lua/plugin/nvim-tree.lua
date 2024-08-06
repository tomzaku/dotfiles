require("nvim-tree").setup({
    filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {
            "**/node_modules/*",
            "node_modules",
            ".*node_modules.*"
        },
    },
    view = {
        side = "right"
    }
})
-- vim.g.nvim_tree_git_hl = 0
-- vim.g.nvim_tree_show_icons = {
--     git = 0,
--     folders = 1,
--     files = 1,
-- }
