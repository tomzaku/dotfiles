local config = {}

function config.nvim_treesitter()
  vim.api.nvim_exec([[
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
  ]], true)
  require'nvim-treesitter.configs'.setup {
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
end


return config
