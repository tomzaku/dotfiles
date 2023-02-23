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
	-- NOTE: First, some plugins that don't require any configuration

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Detect tabstop and shiftwidth automatically

	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",

			-- null-ls
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		-- build = ":TSUpdate"
		-- config = function()
		-- 	pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		-- end,
	},
	{
		"kylechui/nvim-surround",
		opts = {}
	},
	{ -- Adds git releated signs to the gutter, as well as utilities for managing changes
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
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			filetype_exclude = { "help", "terminal", "dashboard", "packer" },
			show_current_context_start = true,
			show_current_context = true,
			char = "╎",
			show_trailing_blankline_indent = false,
		},
	},

	"JoosepAlviste/nvim-ts-context-commentstring",
	-- "gc" to comment visual regions/lines
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		opts = {
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		},
	},
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

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
	"mrjones2014/nvim-ts-rainbow",
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
	"kamykn/spelunker.vim", -- Grmmar & spelling
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "kkharji/sqlite.lua",           module = "sqlite" },
			{ "nvim-telescope/telescope.nvim" },
			{ "ibhagwan/fzf-lua" },
		},
		opts = {},
	},

	-- Theme & Dashboard
	{
		"glepnir/dashboard-nvim",
		event = 'VimEnter',
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- opts = {}
	},
	-- "glepnir/galaxyline.nvim",
	-- Colorschemes
	"glepnir/zephyr-nvim",
	"aonemd/kuroi.vim",

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		tag = "nightly",
	},

	"christoomey/vim-tmux-navigator",
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
		run = "cd app && yarn install",
	},

	"andweeb/presence.nvim",

	-- Debugger
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",

	-- Quickfix
	"kevinhwang91/nvim-bqf",
}, {})

-- Setup

require("plugin.nvim-treesitter")
require("plugin.telescope")
require("plugin.lsp")
require("plugin.completion")
require("plugin.nvim-tree")
require("plugin.nvim-spectre")
require("plugin.toggleterm")
require("plugin.vim-floaterm")
require("plugin.vista")
require("plugin.dashboard")
require("plugin.gitsign")
-- require("plugin.galaxyline") -- TODO: Lagging
-- require("plugin.lualine")
require("plugin.lualine-custom")
require("plugin.theme")
require("plugin.which-key")
require("plugin.autopairs")
require("plugin.leap")
require("plugin.backup")
require("plugin.presence")
require("plugin.spelunker-vim")
require("plugin.nvim-dap")
require("plugin.nvim-ts-autotag")
require("plugin.dashboard")
require("colorizer").setup()
