local completion = {}
local conf = require('modules.completion.config')

completion['neovim/nvim-lspconfig'] = {
  event = 'BufReadPre',
  config = conf.nvim_lsp,
}

completion['glepnir/lspsaga.nvim'] = {
  cmd = 'Lspsaga',
}

completion["folke/lsp-trouble.nvim"] = {
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {
      vim.api.nvim_set_keymap("n", "<leaderxx", "<cmd>LspTroubleToggle<cr>", {silent = true, noremap = true})
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}

completion['hrsh7th/nvim-compe'] = {
  event = 'InsertEnter',
  config = conf.nvim_compe,
}

completion['hrsh7th/vim-vsnip'] = {
  event = 'InsertCharPre',
  config = conf.vim_vsnip
}

completion['nvim-telescope/telescope.nvim'] = {
  cmd = 'Telescope',
  config = conf.telescope,
  event = 'VimEnter', -- TODO: Run when starting vim may takes start app time issue
  opt = false,
  requires = {
    {'nvim-lua/popup.nvim', opt = true},
    {'nvim-lua/plenary.nvim',opt = true},
    {'nvim-telescope/telescope-fzy-native.nvim',opt = true},
  }
}


completion['mattn/vim-sonictemplate'] = {
  cmd = 'Template',
  ft = {'go','typescript','lua','javascript','vim','rust','markdown'},
  config = conf.vim_sonictemplate,
}

completion['mattn/emmet-vim'] = {
  event = 'InsertEnter',
  ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact'},
  config = conf.emmet,
}

-- Format
completion['dense-analysis/ale'] = {
}
-- Working good but only support prettier
-- completion['prettier/vim-prettier'] = {}


-- Comment
completion['numToStr/Comment.nvim'] = {
  config = function ()
    require('Comment').setup{
      pre_hook = function(ctx)
        local U = require 'Comment.utils'
        local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
        return require('ts_context_commentstring.internal').calculate_commentstring {
          key = type,
        }
    end,
    }
  end,
  after = 'nvim-treesitter',
  requires = {
    'nvim-treesitter/nvim-treesitter',
    'JoosepAlviste/nvim-ts-context-commentstring'
  }
}
-- completion['terrortylor/nvim-comment'] = {
--   config = function()
--     require('nvim_comment').setup()
--   end
-- }

completion['JoosepAlviste/nvim-ts-context-commentstring'] = {
  after = 'nvim-treesitter',
  config = function()
    require'nvim-treesitter.configs'.setup {
      context_commentstring = {
        enable = true
      }
    }
  end,
  requires = {
    'nvim-treesitter/nvim-treesitter',
  }
}

completion['metakirby5/codi.vim'] = {}

-- Check spell: not smart
-- completion['lewis6991/spellsitter.nvim'] = {
--   config = function()
--     require('spellsitter').setup{
--       hl = 'SpellBad',
--       captures = {'comment'},
--     }
--   end
-- }



return completion
