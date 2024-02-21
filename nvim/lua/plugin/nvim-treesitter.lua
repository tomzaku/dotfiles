require("nvim-treesitter.configs").setup({
    -- JoosepAlviste/nvim-ts-context-commentstring
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { "lua", "vim", "javascript", "typescript", "tsx" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = false }, -- highlight toggle on will lagging
    indent = { enable = true, disable = { "python", "lua" } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    -- Plugins: mrjones2014/nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    },
    -- End of plugin mrjones2014/nvim-ts-rainbow

    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
})
-- require("treesitter-context").setup({
--     enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--     max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--     min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--     line_numbers = true,
--     multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
--     trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--     mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
--     -- Separator between context and content. Should be a single character string, like '-'.
--     -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--     separator = nil,
--     zindex = 20, -- The Z-index of the context window
--     on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- })
