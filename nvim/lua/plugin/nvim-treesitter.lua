local status_ok, lib = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

vim.api.nvim_exec([[
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
]], true)

lib.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental =  "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    }
  }
}
