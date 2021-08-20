local ui = {}
local conf = require('modules.ui.config')

-- Theme configuration
ui['glepnir/zephyr-nvim'] = {
}
ui['aonemd/kuroi.vim'] = {
  config = [[vim.cmd('colorscheme kuroi')]]
}


ui['glepnir/dashboard-nvim'] = {
  config = conf.dashboard
}

-- tabbar footer
ui['glepnir/galaxyline.nvim'] = {
  branch = 'main',
  config = conf.galaxyline,
  requires = {'kyazdani42/nvim-web-devicons'}
}


-- indent
-- ui['glepnir/indent-guides.nvim'] = {
--   event = 'BufRead',
--   config = function()
--     require('indent_guides').setup({
--       even_colors = { fg ='#202020',bg='#202020' };
--       odd_colors = {fg='#202020',bg='#202020'};
--     })
--   end
-- }
ui['lukas-reineke/indent-blankline.nvim'] = {
  config = function()
    vim.g.indentLine_enabled = 1
    vim.g.indent_blankline_char = "▏"

    vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard", "packer"}
    vim.g.indent_blankline_buftype_exclude = {"terminal"}

    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = false
  end
}

-- Bufferline for tab
-- ui['akinsho/nvim-bufferline.lua'] = {
--   config = conf.nvim_bufferline,
--   requires = {'kyazdani42/nvim-web-devicons'}
-- }

-- File explorer
-- ui['preservim/nerdtree'] = {
--   config = conf.nertree
-- }
-- ui['Xuyuanp/nerdtree-git-plugin'] = {}
-- BUGS: Moving cursor lagging
-- https://github.com/tiagofumo/vim-nerdtree-syntax-highlight/issues/6
--ui['tiagofumo/vim-nerdtree-syntax-highlight'] = {}
-- BUGS: Disable selecting
--ui['ryanoasis/vim-devicons'] = {}

-- BUGS: Lagging when save file.
ui['kyazdani42/nvim-tree.lua'] = {
  cmd = {'NvimTreeToggle','NvimTreeOpen', 'NvimTreeFindFile'},
  config = conf.nvim_tree,
  -- requires = {'kyazdani42/nvim-web-devicons'}
}
-- End File explorer

-- Only show git log
ui['lewis6991/gitsigns.nvim'] = {
  event = {'BufRead','BufNewFile'},
  config = conf._gitsigns,
  requires = {'nvim-lua/plenary.nvim',opt=true}
}
-- Have bugs: cannot install
-- ui['tanvirtin/vgit.nvim'] = {
--   config = function()
--     require('vgit').setup{}
--   end,
--   requires = {'nvim-lua/plenary.nvim',opt=true}
-- }

-- Maximizer
ui['kdav5758/TrueZen.nvim'] = {
  -- config = function () 
}
-- ui['szw/vim-maximizer'] = {
--   config = function()
--     vim.g.maximizer_default_mapping_key = '<Leader>z'
--   end
-- }

-- Tmux & nvim
ui['christoomey/vim-tmux-navigator']={}

return ui
