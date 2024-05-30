-- Install packer
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Basic region
    "nvim-lua/plenary.nvim",

    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    -- {
    --     "monkoose/neocodeium",
    --     event = "VeryLazy",
    --     config = function()
    --         local neocodeium = require("neocodeium")
    --         neocodeium.setup()
    --         vim.keymap.set("i", "<c-g>", neocodeium.accept)
    --         vim.keymap.set("i", "<c-r>", neocodeium.cycle)
    --     end,
    -- },
    -- {
    --     "Exafunction/codeium.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function()
    --         require("codeium").setup({
    --             config_path = "/Users/zaku/.codeium/config.json"
    --         })
    --     end
    -- },
    -- {
    --     'Exafunction/codeium.vim',
    --     event = 'BufEnter',
    --     config = function()
    --         -- Change '<C-g>' here to any keycode you like.
    --         vim.keymap.set('i', '<c-g>', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
    --         vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
    --             { expr = true, silent = true })
    --         vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
    --             { expr = true, silent = true })
    --         vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    --     end
    -- },
    {
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- LSP signature hint as you type
            { "ray-x/lsp_signature.nvim", opts = {} },

            -- Useful status updates for LSP
            { "j-hui/fidget.nvim",        opts = {}, tag = "legacy" },

            -- Additional lua configuration, makes nvim stuff amazing!
            "folke/neodev.nvim",

            -- null-ls
            "jose-elias-alvarez/null-ls.nvim",
        },
    },
    {
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    },

    {
        -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- "nvim-treesitter/nvim-treesitter-context", -- show the context of child such as parent function
        },
        build = ":TSUpdate",
        -- config = function()
        -- 	pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        -- end,
    },

    -- End of region basic - the rest can comment to debug
    {
        "kylechui/nvim-surround",
        opts = {},
    },
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    "sindrets/diffview.nvim",

    -- Indent
    {
        -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "╎" },
            exclude = {
                filetypes = {
                    "dashboard",
                },
            },
        },
    },

    "JoosepAlviste/nvim-ts-context-commentstring",
    -- "gc" to comment visual regions/lines
    {
        "numToStr/Comment.nvim",
        after = "nvim-ts-context-commentstring",
        opts = {
            pre_hook = function()
                return vim.bo.commentstring
            end,
        }
    },
    { "folke/todo-comments.nvim",   dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1
        end,
    },

    "metakirby5/codi.vim",

    -- Editting Support
    "windwp/nvim-autopairs",
    "windwp/nvim-ts-autotag",
    "norcalli/nvim-colorizer.lua",
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    "Pocco81/true-zen.nvim",

    -- Search & Replace
    "windwp/nvim-spectre",

    -- Terminal
    "voldikss/vim-floaterm",
    "akinsho/toggleterm.nvim",

    -- Utility
    "liuchengxu/vista.vim",
    "folke/which-key.nvim", -- Key mapping
    -- "kamykn/spelunker.vim", -- Grammar & spelling - Add word to spellfile: Zg
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            { "kkharji/sqlite.lua",           module = "sqlite" },
            { "nvim-telescope/telescope.nvim" },
            { "ibhagwan/fzf-lua" },
        },
        opts = {},
    },
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    -- Theme & Dashboard
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    -- {
    --     "nvim-lualine/lualine.nvim",
    --     dependencies = { "nvim-tree/nvim-web-devicons" },
    --     -- opts = {}
    -- },
    {
        "mcchrish/zenbones.nvim",
        dependencies = { "rktjmp/lush.nvim" },
    },
    "glepnir/galaxyline.nvim",
    -- Colorschemes
    "glepnir/zephyr-nvim",
    "aonemd/kuroi.vim",
    "sainnhe/edge",
    "Mofiqul/vscode.nvim",
    { "projekt0n/github-nvim-theme" },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    {
        "sontungexpt/witch",
        priority = 1000,
        lazy = false,
        config = function(_, opts)
            require("witch").setup(opts)
        end,
    },

    -- "christoomey/vim-tmux-navigator", use kitty instead
    {
        "knubie/vim-kitty-navigator",
        build = function()
            vim.fn.system("cp", "*.py", "~/.config/kitty")
        end,
    },
    -- bug when use the new version
    {
        "rmagatti/auto-session",
        opts = {
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        },
    },

    "ggandor/leap.nvim", -- Motion

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -- Discord
    -- "andweeb/presence.nvim",

    -- Debugger
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",

    -- Quickfix
    "kevinhwang91/nvim-bqf",

    -- AI
    "github/copilot.vim",

    -- image preview
    -- {
    --     "3rd/image.nvim",
    --     opts = {
    --         backend = "kitty",
    --         integrations = {
    --             markdown = {
    --                 enabled = true,
    --                 clear_in_insert_mode = true,
    --                 download_remote_images = true,
    --                 only_render_image_at_cursor = true,
    --                 filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    --             },
    --             neorg = {
    --                 enabled = true,
    --                 clear_in_insert_mode = false,
    --                 download_remote_images = true,
    --                 only_render_image_at_cursor = false,
    --                 filetypes = { "norg" },
    --             },
    --         },
    --         max_width = nil,
    --         max_height = nil,
    --         max_width_window_percentage = nil,
    --         max_height_window_percentage = 50,
    --         window_overlap_clear_enabled = true,                                      -- toggles images when windows are overlapped
    --         window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    --         editor_only_render_when_focused = true,                                   -- auto show/hide images when the editor gains/looses focus
    --         tmux_show_only_in_active_window = true,                                   -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    --         hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
    --     },
    -- },
    -- {
    --     "nvim-neotest/neotest",
    --     dependencies = {
    --         "nvim-neotest/nvim-nio",
    --         "nvim-lua/plenary.nvim",
    --         "antoinemadec/FixCursorHold.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --         'nvim-neotest/neotest-jest',
    --     },
    --     config = function()
    --         require("neotest").setup({
    --             adapters = {
    --                 require("neotest-jest")({
    --                     jestCommand = "npm run integration-test --",
    --                     jestConfigFile = function(file)
    --                         -- if string.find(file, "/packages/") then
    --                         --     return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
    --                         -- end
    --
    --                         return vim.fn.getcwd() .. "/jest.integration.js"
    --                     end,
    --                     env = { CI = true },
    --                     cwd = function(path)
    --                         return vim.fn.getcwd()
    --                     end,
    --                 }),
    --             },
    --         })
    --     end,
    -- }
}, {})

-- Setup

require("plugin.nvim-treesitter")
require("plugin.lsp")
require("plugin.nvim-tree")

-- The rest is not additional plugin can remove for debug
require("plugin.telescope")
-- require("plugin.completion")
require("plugin.nvim-spectre")
require("plugin.toggleterm")
require("plugin.vim-floaterm")
require("plugin.vista")
require("plugin.dashboard")
require("plugin.gitsign")
require("plugin.galaxyline") -- TODO: Lagging
-- require("plugin.lualine")
-- require("plugin.lualine-custom")
require("plugin.theme")
require("plugin.which-key")
require("plugin.autopairs")
require("plugin.leap")
require("plugin.backup")
-- require("plugin.presence") -- Has error with package
-- require("plugin.spelunker-vim") -- Lagging
require("plugin.nvim-dap")
require("plugin.nvim-ts-autotag")
require("plugin.dashboard")
require("colorizer").setup()
