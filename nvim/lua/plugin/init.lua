-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end


-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'


    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
        },
    }

    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    }

    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }

    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }


    -- Git related plugins
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
    use("sindrets/diffview.nvim")




    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("folke/todo-comments.nvim")
    use("numToStr/Comment.nvim") -- Easily comment stuff
    use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
    use("windwp/nvim-ts-autotag")
    use("p00f/nvim-ts-rainbow") -- rainbow parentheses.
    use({
        "norcalli/nvim-colorizer.lua",
        ft = { "html", "css", "sass", "scss", "vim", "typescript", "typescriptreact" },
    })
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
    use("kana/vim-niceblock") -- Make blockwise Visual mode more useful
    use("lukas-reineke/indent-blankline.nvim") -- indent

    use("liuchengxu/vista.vim")
    use("metakirby5/codi.vim")
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }


    -- Search & replace
    use("windwp/nvim-spectre")


    -- Terminal
    use("voldikss/vim-floaterm") -- terminal
    use("akinsho/toggleterm.nvim") -- terminal

    -- Key mapping
    use("folke/which-key.nvim")


    -- Grammar & spelling
    use("kamykn/spelunker.vim")


    -- Registry
    use({
        "AckslD/nvim-neoclip.lua",
        requires = {
            { "kkharji/sqlite.lua",           module = "sqlite" },
            { "nvim-telescope/telescope.nvim" },
            { "ibhagwan/fzf-lua" },
        },
        config = function()
            require("neoclip").setup()
        end,
    }) -- Clipboard management for registers

    -- Dashboard and theme
    use("glepnir/dashboard-nvim") -- dashboard
    use("glepnir/galaxyline.nvim") --tabbar footer
    -- Colorschemes
    use("glepnir/zephyr-nvim") -- theme
    use("aonemd/kuroi.vim") -- theme


    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }


    use("kdav5758/TrueZen.nvim")
    use("christoomey/vim-tmux-navigator")
    use("rmagatti/auto-session")
    use("ggandor/leap.nvim")
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && yarn install",
    })
    use("andweeb/presence.nvim") -- discord Rich Presence

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }




    -- Debugger
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

    -- Quickfix
    use("kevinhwang91/nvim-bqf", { ft = "qf" })


    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

-- Setup
require("plugin.lsp")
-- require("plugin.completion")
require("plugin.nvim-treesitter")
require("plugin.telescope")
require("plugin.nvim-tree")
require("plugin.nvim-spectre")
require("plugin.comment")
require("plugin.nvim-colorizer")
require("plugin.nvim-ts-context-commentstring")

require("plugin.toggleterm")
require("plugin.vim-floaterm")
require("plugin.vista")
require("plugin.dashboard")
require("plugin.gitsign")
require("plugin.galaxyline")
require("plugin.indent-blankline")
require("plugin.theme")
require("plugin.auto-session")
require("plugin.which-key")
require("plugin.autopairs")
-- -- tabbar
-- require("plugin.barbar")
require("plugin.leap")
require("plugin.todo-comments")
require("plugin.backup")
require("plugin.presence")
require("plugin.spelunker-vim")
require("plugin.nvim-dap")
require("plugin.nvim-ufo")
require("plugin.nvim-ts-autotag")
