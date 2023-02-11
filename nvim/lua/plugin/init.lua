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

    -- LSP Configuration & Plugins
    use {
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

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
    }

    -- Highlight, edit, and navigate code
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }

    -- Additional text objects via treesitter
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }


    -- Git related plugins
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
    use("sindrets/diffview.nvim")

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }


    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }



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




    -- Debugger
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

    -- Quickfix
    use("kevinhwang91/nvim-bqf", { ft = "qf" })



    -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
    local has_plugins, plugins = pcall(require, 'custom.plugins')
    if has_plugins then
        plugins(use)
    end



    if is_bootstrap then
        require('packer').sync()
    end
end)


-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end


-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})


-- Setup

require("plugin.nvim-treesitter")
require("plugin.telescope")


-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

--[[ require("plugin.lsp") ]]
-- require("plugin.completion")
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
require("plugin.leap")
require("plugin.todo-comments")
require("plugin.backup")
require("plugin.presence")
require("plugin.spelunker-vim")
require("plugin.nvim-dap")
require("plugin.nvim-ufo")
require("plugin.nvim-ts-autotag")
