local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Automatically install packer
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({ })

-- Install your plugins here
packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("kyazdani42/nvim-web-devicons")
	use("moll/vim-bbye") -- Delete buffers and close files in Vim without closing your windows or messing up your layout
	use("lewis6991/impatient.nvim") -- Make load plugins faster
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight -- Having bugs
	use("folke/which-key.nvim")
	use("metakirby5/codi.vim")
	-- use "Raimondi/delimitMate" --  insert mode auto-completion for quotes, parens, brackets, etc. doesn't powerful since it doesn't use treesister
	use("xiyaowong/accelerated-jk.nvim")
	use({
		"norcalli/nvim-colorizer.lua",
		ft = { "html", "css", "sass", "scss", "vim", "typescript", "typescriptreact" },
	})
	use("itchyny/vim-cursorword") -- Underlines the word under the cursor
	use("hrsh7th/vim-eft") -- enhanced f/t
	-- use "rhysd/vim-operator-surround" -- mapping to enclose text objects with surrounds like paren, quote and so on.
	use("kana/vim-niceblock") -- Make blockwise Visual mode more useful
	use("tversteeg/registers.nvim") -- NeoVim plugin to preview the contents of the registers
	-- use 'editorconfig/editorconfig-vim' -- editor config
	use("liuchengxu/vista.vim")
	use("windwp/nvim-spectre") -- search & replace
	use("voldikss/vim-floaterm") -- terminal
	use("akinsho/toggleterm.nvim") -- terminal
	use("glacambre/firenvim") -- editor for chrome
	use("glepnir/dashboard-nvim") -- dashboard
	use("glepnir/galaxyline.nvim") --tabbar footer
	use("lukas-reineke/indent-blankline.nvim") -- indent
	use("kdav5758/TrueZen.nvim")
	use("christoomey/vim-tmux-navigator")
	use("rmagatti/auto-session")
  use 'ggandor/lightspeed.nvim' -- motion
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
	})
  use 'andweeb/presence.nvim' -- discord Rich Presence
	--tabbar
	use("akinsho/bufferline.nvim")
  use("folke/todo-comments.nvim")

	-- Colorschemes
	use("glepnir/zephyr-nvim") -- theme
	use("aonemd/kuroi.vim") -- theme

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/vim-vsnip")
	use("mattn/vim-sonictemplate")
	-- use "dense-analysis/ale"
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	--
	-- snippets
	use("mattn/emmet-vim")
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	-- use("glepnir/lspsaga.nvim") -- UI
	use("folke/lsp-trouble.nvim") -- window for error
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for: plugin/lsp/setting/jsonls.lua
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	-- FZF sorter for telescope written in c
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("kyazdani42/nvim-tree.lua")
  use("p00f/nvim-ts-rainbow") -- rainbow parentheses.

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("tpope/vim-fugitive")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

-- Setup
require("plugin.lsp")
require("plugin.completion")
require("plugin.nvim-treesitter")
require("plugin.telescope")
require("plugin.nvim-tree")
require("plugin.nvim-spectre")
-- require 'plugin.ale'
require("plugin.comment")
require("plugin.neoscroll")
require("plugin.nvim-colorizer")
require("plugin.nvim-ts-context-commentstring")
require("plugin.nvim-vsnip")
require("plugin.toggleterm")
require("plugin.vim-cursorword")
require("plugin.vim-floaterm")
require("plugin.vim-eft")
require("plugin.vim-operator-replace")
require("plugin.vista")
require("plugin.dashboard")
require("plugin.gitsign")
require("plugin.galaxyline")
require("plugin.indent-blankline")
require("plugin.theme")
-- require 'plugin.delimitMate'
require("plugin.emmet-vim")
require("plugin.auto-session")
require("plugin.which-key")
require("plugin.accelerated-jk")
require("plugin.autopairs")
-- tabbar
require("plugin.barbar")
require("plugin.bufferline")
require("plugin.lightspeed")
require("plugin.todo-comments")
require("plugin.backup")
require("plugin.presence")
