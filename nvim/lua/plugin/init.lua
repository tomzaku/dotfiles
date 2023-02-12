-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

require("packer").startup(function(use)
	-- Package manager
	use("wbthomason/packer.nvim")

	-- LSP Configuration & Plugins
	use({
		"neovim/nvim-lspconfig",
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			"j-hui/fidget.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	})

	-- Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
	})

	-- Highlight, edit, and navigate code
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	})

	-- Additional text objects via treesitter
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})

	-- Git related plugins
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim")
	use("sindrets/diffview.nvim")

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })

	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Comment
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = function(ctx)
					local U = require("Comment.utils")
					local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
					return require("ts_context_commentstring.internal").calculate_commentstring({
						key = type,
					})
				end,
			})
		end,
	})

	-- Code Runner
	use("metakirby5/codi.vim")

	-- Indent
	use("lukas-reineke/indent-blankline.nvim")

	-- Editting Support
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("windwp/nvim-ts-autotag")
	use("mrjones2014/nvim-ts-rainbow") -- rainbow parentheses.
	use({
		"norcalli/nvim-colorizer.lua",
		ft = { "html", "css", "sass", "scss", "vim", "typescript", "typescriptreact" },
	})
	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically
	use("Pocco81/true-zen.nvim")

	-- Search & replace
	use("windwp/nvim-spectre")

	-- Terminal
	use("voldikss/vim-floaterm") -- terminal
	use("akinsho/toggleterm.nvim") -- terminal

	-- Utility
	--[[ use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' } -- Folding  ]]

	use("liuchengxu/vista.vim")

	-- Key mapping
	use("folke/which-key.nvim")

	-- Grammar & spelling
	use("kamykn/spelunker.vim")

	-- Registry
	use({
		"AckslD/nvim-neoclip.lua",
		requires = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
			{ "nvim-telescope/telescope.nvim" },
			{ "ibhagwan/fzf-lua" },
		},
		config = function()
			require("neoclip").setup()
		end,
	}) -- Clipboard management for registers

	-- Dashboard and theme
	use({
		"glepnir/dashboard-nvim",
		--event = 'VimEnter',
		theme = "hyper",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use("glepnir/galaxyline.nvim") --tabbar footer
	-- use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

	-- Colorschemes
	use("glepnir/zephyr-nvim") -- theme
	use("aonemd/kuroi.vim") -- theme

	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	use("christoomey/vim-tmux-navigator")
	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	})

	-- Motion
	use("ggandor/leap.nvim")

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
	})
	use("andweeb/presence.nvim") -- discord Rich Presence

	-- Debugger
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")

	-- Quickfix
	use("kevinhwang91/nvim-bqf", { ft = "qf" })

	-- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
	local has_plugins, plugins = pcall(require, "custom.plugins")
	if has_plugins then
		plugins(use)
	end

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})

-- Setup

require("plugin.nvim-treesitter")
require("plugin.telescope")
require("plugin.lsp")
-- require("plugin.completion")
require("plugin.nvim-tree")
require("plugin.nvim-spectre")
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
require("plugin.which-key")
require("plugin.autopairs")
require("plugin.leap")
require("plugin.backup")
require("plugin.presence")
require("plugin.spelunker-vim")
require("plugin.nvim-dap")
--[[ require("plugin.nvim-ufo") ]]
require("plugin.nvim-ts-autotag")

--require('lualine').setup()
