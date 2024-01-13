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
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    },
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
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { "j-hui/fidget.nvim", opts = {}, tag = "legacy" },

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
            "nvim-treesitter/nvim-treesitter-context",
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
            -- indent = { char = "╎" },
            -- filetype_exclude = { "help", "terminal", "dashboard", "packer" },
            -- show_current_context_start = true,
            -- show_current_context = true,
            -- char = "╎",
            -- show_trailing_blankline_indent = false,
        },
    },

    "JoosepAlviste/nvim-ts-context-commentstring",
    -- "gc" to comment visual regions/lines
    {
        "numToStr/Comment.nvim",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        after = "nvim-ts-context-commentstring",
        opts = function()
            return {
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            }
        end,
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
    "kamykn/spelunker.vim", -- Grammar & spelling - Add word to spellfile: Zg
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            { "kkharji/sqlite.lua", module = "sqlite" },
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
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- opts = {}
    },
    {
        "mcchrish/zenbones.nvim",
        dependencies = { "rktjmp/lush.nvim" },
    },
    -- "glepnir/galaxyline.nvim",
    -- Colorschemes
    "glepnir/zephyr-nvim",
    "aonemd/kuroi.vim",
    "sainnhe/edge",
    "Mofiqul/vscode.nvim",
    { "projekt0n/github-nvim-theme" },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        tag = "nightly",
    },

    -- "christoomey/vim-tmux-navigator", use kitty instead
    {
        "knubie/vim-kitty-navigator",
        build = function()
            vim.fn.system("cp", "*.py", "~/.config/kitty")
        end,
    },
    -- {
    -- 	"MunsMan/kitty-navigator.nvim",
    -- 	keys = {
    -- 		{
    -- 			"<C-h>",
    -- 			function()
    -- 				require("kitty-navigator").navigateLeft()
    -- 			end,
    -- 			desc = "Move left a Split",
    -- 			mode = { "n" },
    -- 		},
    -- 		{
    -- 			"<C-j>",
    -- 			function()
    -- 				require("kitty-navigator").navigateDown()
    -- 			end,
    -- 			desc = "Move down a Split",
    -- 			mode = { "n" },
    -- 		},
    -- 		{
    -- 			"<C-k>",
    -- 			function()
    -- 				require("kitty-navigator").navigateUp()
    -- 			end,
    -- 			desc = "Move up a Split",
    -- 			mode = { "n" },
    -- 		},
    -- 		{
    -- 			"<C-l>",
    -- 			function()
    -- 				require("kitty-navigator").navigateRight()
    -- 			end,
    -- 			desc = "Move right a Split",
    -- 			mode = { "n" },
    -- 		},
    -- 	},
    -- 	build = function()
    -- 		vim.fn.system("cp", "navigate_kitty.py", "~/.config/kitty")
    -- 		vim.fn.system("cp", "pass_keys.py", "~/.config/kitty")
    -- 	end,
    -- },

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
        run = "cd app && yarn install",
    },

    -- Discord
    -- "andweeb/presence.nvim",

    -- Debugger
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",

    -- Quickfix
    "kevinhwang91/nvim-bqf",

    -- image preview
    {
        "3rd/image.nvim",
        -- config = function()
        -- 	-- Requirements
        -- 	-- https://github.com/3rd/image.nvim?tab=readme-ov-file#requirements
        -- 	local backend = "kitty"
        --
        -- 	local shell
        -- 	if vim.fn.has("nvim-0.10.0") == 1 then
        -- 		-- print('nvim >= 0.10')
        -- 		shell = function(command)
        -- 			local obj = vim.system(command, { text = true }):wait()
        -- 			if obj.code ~= 0 then
        -- 				return nil
        -- 			end
        -- 			return obj.stdout
        -- 		end
        -- 	else
        -- 		-- print('nvim < 0.10')
        -- 		shell = function(command)
        -- 			command = table.concat(command, " ")
        -- 			local handle = io.popen(command)
        -- 			if handle == nil then
        -- 				return nil
        -- 			end
        -- 			local result = handle:read("*a")
        -- 			handle:close()
        -- 			return result
        -- 		end
        -- 	end
        --
        -- 	-- check if imagemagick is available
        -- 	if shell({ "convert", "-version" }) == nil then
        -- 		-- print("imagemagick is not available")
        -- 		return
        -- 	end
        --
        -- 	if backend == "kitty" then
        -- 		-- check if kitty is available
        -- 		local out = shell({ "kitty", "--version" })
        -- 		if out == nil then
        -- 			-- print("kitty is not available")
        -- 			return
        -- 		end
        -- 		local kitty_version = out:match("(%d+%.%d+%.%d+)")
        -- 		if kitty_version == nil then
        -- 			-- print("kitty version is not available")
        -- 			return
        -- 		end
        -- 		local v = vim.version.parse(kitty_version)
        -- 		local minimal = vim.version.parse("0.30.1")
        -- 		if v and vim.version.cmp(v, minimal) < 0 then
        -- 			-- print("kitty version is too old")
        -- 			return
        -- 		end
        -- 	end
        -- 	local tmux = vim.fn.getenv("TMUX")
        -- 	if tmux ~= vim.NIL then
        -- 		-- tmux uses number.number.(maybe letter)
        -- 		-- e.g. 3.3a
        -- 		-- but 3.3 comes before 3.3a
        -- 		-- so we replace a with 1
        -- 		local offset = 96
        -- 		local out = shell({ "tmux", "-V" })
        -- 		if out == nil then
        -- 			-- print("tmux is not available")
        -- 			return
        -- 		end
        -- 		out = out:gsub("\n", "")
        -- 		local letter = out:match("tmux %d+%.%d+([a-z])")
        -- 		local number
        -- 		if letter == nil then
        -- 			number = 0
        -- 		else
        -- 			number = string.byte(letter) - offset
        -- 		end
        -- 		local version = out:gsub("tmux (%d+%.%d+)([a-z])", "%1." .. number)
        -- 		local v = vim.version.parse(version)
        -- 		local minimal = vim.version.parse("3.3.1")
        -- 		if v and vim.version.cmp(v, minimal) < 0 then
        -- 			-- print("tmux version is too old")
        -- 			return
        -- 		end
        -- 	end
        --
        -- 	-- setup
        -- 	-- Example for configuring Neovim to load user-installed installed Lua rocks:
        -- 	--$ luarocks --local --lua-version=5.1 install magick
        -- 	package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
        -- 	package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
        --
        -- 	-- check if magick luarock is available
        -- 	local ok, magick = pcall(require, "magick")
        -- 	if not ok then
        -- 		-- print("magick luarock is not available")
        -- 		return
        -- 	end
        --
        -- 	require("image").setup({
        -- 		backend = backend,
        -- 		integrations = {
        -- 			markdown = {
        -- 				enabled = true,
        -- 				-- clear_in_insert_mode = true,
        -- 				-- download_remote_images = true,
        -- 				only_render_image_at_cursor = true,
        -- 				filetypes = { "markdown", "vimwiki", "quarto" },
        -- 			},
        -- 		},
        -- 		max_width = 100,
        -- 		max_height = 15,
        -- 		editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        -- 		tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        -- 	})
        -- end,
        opts = {
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "norg" },
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
            tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
        },
    },

    -- {
    -- 	"edluffy/hologram.nvim",
    -- 	opts = {
    -- 		auto_display = true -- WIP automatic markdown image display, may be prone to breaking
    -- 	}
    -- }
}, {})

-- Setup

require("plugin.nvim-treesitter")
require("plugin.lsp")
require("plugin.nvim-tree")

-- The rest is not addtion plugin can remove for debug
require("plugin.telescope")
require("plugin.completion")
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
-- require("plugin.presence") -- Has error with package
require("plugin.spelunker-vim")
require("plugin.nvim-dap")
require("plugin.nvim-ts-autotag")
require("plugin.dashboard")
require("colorizer").setup()
