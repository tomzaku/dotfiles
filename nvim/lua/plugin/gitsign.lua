local status_ok, lib = pcall(require, "gitsigns")
if not status_ok then
    return
end

lib.setup({
    signs = {
        add = { hl = "GitGutterAdd", text = "▋" },
        change = { hl = "GitGutterChange", text = "▋" },
        delete = { hl = "GitGutterDelete", text = "▋" },
        topdelete = { hl = "GitGutterDeleteChange", text = "▔" },
        changedelete = { hl = "GitGutterChange", text = "▎" },
    },
    current_line_blame_opts = {
        delay = 300,
    },
    current_line_blame_formatter_opts = {
        relative_time = true,
    },
    current_line_blame = true,
})
