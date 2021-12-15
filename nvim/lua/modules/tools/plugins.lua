local tools = {}
local conf = require('modules.tools.config')

tools['tversteeg/registers.nvim'] = {}

tools['editorconfig/editorconfig-vim'] = {
  ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

-- tools['brooth/far.vim'] = {
--   cmd = {'Far','Farp', 'Farf'},
--   config = function ()
--     vim.g['far#source'] = 'rg'
--   end
-- }

tools['windwp/nvim-spectre'] = {
  requires = {
    {'nvim-lua/popup.nvim'},
    {'nvim-lua/plenary.nvim'},
  },
  config = function ()
    if not packer_plugins['plenary.nvim'].loaded then
      vim.cmd [[packadd plenary.nvim]]
    end
    if not packer_plugins['popup.nvim'].loaded then
      vim.cmd [[packadd popup.nvim]]
    end
    require('spectre').setup({
      line_sep_start = '┌------- <Leader> R: repleace all; dd: toggle; <leader>o: option menu ------'
    })
  end
}

-- tools['iamcco/markdown-preview.nvim'] = {
--   ft = 'markdown',
--   config = function ()
--     vim.g.mkdp_auto_start = 0
--   end
-- }
--
-- tools['kdheepak/lazygit.nvim'] = { }

-- Note - complicated
-- tools['oberblastmeister/neuron.nvim'] = {
--   -- branch = 'unstable',
--   after = 'telescope.nvim',
--   requires = {
--     {'nvim-lua/popup.nvim',opt=true},
--     {'nvim-lua/plenary.nvim', opt=true},
--     -- {'nvim-telescope/telescope.nvim'}
--   },
--   config = function()
--     if not packer_plugins['plenary.nvim'].loaded then
--       vim.cmd [[packadd plenary.nvim]]
--       vim.cmd [[packadd popup.nvim]]
--       vim.cmd [[packadd telescope.nvim]]
--     end
--     require'neuron'.setup {
--       virtual_titles = true,
--       mappings = true,
--       -- run = nil, -- function to run when in neuron dir
--       neuron_dir = "~/neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
--       leader = "gz", -- the leader key to for all mappings, remember with 'go zettel'
--     }
--   end
-- }

-- Terminal
tools['voldikss/vim-floaterm'] = {
  config = function()
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    vim.g.floaterm_keymap_toggle = '<F1>'
    vim.g.floaterm_keymap_next = '<F10>'
    vim.g.floaterm_keymap_prev = '<F9>'
    vim.g.floaterm_keymap_new = '<F4>'
    vim.g.floaterm_title = ''
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    map('n', '<F5>', '<CMD>FloatermNew! cd %:p:h<CR>', opts)
  end
}

-- Terminal
-- Cannot change the C-i
-- tools['numtostr/FTerm.nvim'] = {
--   config = function()
--     require("FTerm").setup()
--     -- Keybinding
--     -- local map = vim.api.nvim_set_keymap
--     -- local opts = { noremap = true, silent = true }
--     -- Closer to the metal
--     -- map('n', '<C-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
--     -- map('t', '<C-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
--   end
-- }


tools['tpope/vim-fugitive'] = {}

tools['glacambre/firenvim'] = {
  run = function() vim.fn['firenvim#install'](0) end 
}

return tools
