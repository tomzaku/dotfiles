vim.g.ale_fix_on_save = 1
vim.g.ale_linters_explicit = 1
vim.g.ale_completion_autoimport = 0
vim.g.ale_set_loclist = 0
vim.g.ale_set_quickfix = 1
vim.g.ale_javascript_prettier_use_local_config = 1

vim.g.ale_fixers = {
    typescript = { "prettier", "eslint" },
    javascript = { "prettier", "eslint" },
    typescriptreact = { "prettier", "eslint" },
    javascriptreact = { "prettier", "eslint" },
    python = { "autopep8", "yapf" },
    svelte = { "prettier", "eslint", "stylelint" },
}
