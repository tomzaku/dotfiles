local editor = {}
local conf = require('modules.editor.config')

editor['Raimondi/delimitMate'] = {
  event = 'InsertEnter',
  config = conf.delimimate,
}

editor['rhysd/accelerated-jk'] = {
  opt = true
}

editor['norcalli/nvim-colorizer.lua'] = {
  ft = { 'html','css','sass','scss','vim','typescript','typescriptreact'},
  config = conf.nvim_colorizer
}

editor['itchyny/vim-cursorword'] = {
  event = {'BufReadPre','BufNewFile'},
  config = conf.vim_cursorwod
}

editor['hrsh7th/vim-eft'] = {
  opt = true,
  config = function()
    vim.g.eft_ignorecase = true
  end
}

editor['kana/vim-operator-replace'] = {
  keys = {{'x','p'}},
  config = function()
    vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)",{silent =true})
  end,
  requires = 'kana/vim-operator-user'
}

editor['rhysd/vim-operator-surround'] = {
  event = 'BufRead',
  requires = 'kana/vim-operator-user'
}

editor['kana/vim-niceblock']  = {
  opt = true
}

-- Auto save session
editor['rmagatti/auto-session'] = {
  config = function()
    require('auto-session').setup({
      auto_restore_enabled = false
    })
  end
}



-- Scroll smooth
-- -- bug: cause lag
-- editor['karb94/neoscroll.nvim'] = {
--   event = "WinScrolled",
--   config = function()
--     require('neoscroll').setup({})
--   end
-- 
-- }
--
return editor
