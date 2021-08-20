local config = {}

function config.galaxyline()
  require('modules.ui.eviline')
end

function config.nvim_bufferline()
  require('bufferline').setup{
    options = {
      modified_icon = '✥',
      buffer_close_icon = '',
      mappings = true,
      always_show_bufferline = false,
    }
  }
end


function config.dashboard()
  function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
  end
  function Split(inputstr, sep)
    if sep == nil then
      sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
    end
    return t
  end
  function os.capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
  end
  local home = os.getenv('HOME')
  local fortune = os.capture('fortune -s')
  -- vim.g.dashboard_custom_footer = TableConcat({''}, Split(fortune, '\. '))
  vim.g.dashboard_custom_footer = { fortune }
  -- vim.g.dashboard_footer_icon = '🐬 '
  -- vim.g.dashboard_preview_command = 'cat'
  vim.g.dashboard_custom_header = {
    '',
    '',
    '',
    '          ▀████▀▄▄              ▄█ ',
    '            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ',
    '    ▄        █          ▀▀▀▀▄  ▄▀  ',
    '   ▄▀ ▀▄      ▀▄              ▀▄▀  ',
    '  ▄▀    █     █▀   ▄█▀▄      ▄█    ',
    '  ▀▄     ▀▄  █     ▀██▀     ██▄█   ',
    '   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ',
    '    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ',
    '   █   █  █      ▄▄           ▄▀   ',
    '',
    }
  -- vim.g.dashboard_preview_pipeline = 'lolcat'
  -- vim.g.dashboard_preview_file = home .. '/.config/nvim/static/neovim.cat'
  -- vim.g.dashboard_preview_file_height = 4 -- pikachu
  -- vim.g.dashboard_preview_file_width = 13 -- pikachu
  -- vim.g.dashboard_preview_file_height = 20 -- dota
  -- vim.g.dashboard_preview_file_width = 42 -- dota
  -- vim.g.dashboard_preview_file_height = 30 -- vegata
  -- vim.g.dashboard_preview_file_width = 80 -- vegata
  -- hide 
  -- vim.g.dashboard_preview_file_height = 1
  -- vim.g.dashboard_preview_file_width = 1
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.dashboard_custom_section = {
    last_session = {
      description = {'  Recently laset session                  SPC s l'},
      command =  'SessionLoad'},
    find_history = {
      description = {'  Recently opened files                   SPC f h'},
      command =  'DashboardFindHistory'},
    find_file  = {
      description = {'  Find  File                              SPC f f'},
      command = 'Telescope find_files find_command=rg,--hidden,--files'},
    new_file = {
     description = {'  File Browser                            SPC f b'},
     command =  'Telescope file_browser'},
    find_word = {
     description = {'  Find  word                              SPC f w'},
     command = 'DashboardFindWord'},
    find_dotfiles = {
     description = {'  Open Personal dotfiles                  SPC f d'},
     command = 'Telescope dotfiles path=' .. home ..'/.dotfiles'},
  }
end

function config.nvim_tree()
  -- Will slow if we handle a big directory and has git.
  vim.g.nvim_tree_git_hl = 0
  vim.g.nvim_tree_gitignore = 0
  vim.g.nvim_tree_show_icons = {
      git = 0,
      folders = 1,
      files = 1,
   }
  -- vim.g.nvim_tree_bindings = {
  --     { key = {"<Leader>F","n"}, cb = ":NvimTreeFindFile" }
  -- }

--   local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- 
--   vim.g.nvim_tree_follow = 1
--   vim.g.nvim_tree_auto_open = 1
--   vim.g.nvim_tree_hide_dotfiles = 1
--   vim.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
--   vim.g.nvim_tree_indent_markers = 0
--   vim.g.nvim_tree_gitignore = 1
--   vim.g.nvim_tree_bindings = {
--     ["h"] = tree_cb("close_node"),
--     ["l"] = tree_cb("edit"),
--     ["s"] = tree_cb("vsplit"),
--     ["i"] = tree_cb("split")
--   }
--   vim.g.nvim_tree_icons = {
--     default =  '',
--     symlink =  '',
--     git = {
--      unstaged = "✚",
--      staged =  "✚",
--      unmerged =  "≠",
--      renamed =  "≫",
--      untracked = "★",
--     },
--   }
end


function config._gitsigns()
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
  end
  require('gitsigns').setup {
    signs = {
      add = {hl = 'GitGutterAdd', text = '▋'},
      change = {hl = 'GitGutterChange',text= '▋'},
      delete = {hl= 'GitGutterDelete', text = '▋'},
      topdelete = {hl ='GitGutterDeleteChange',text = '▔'},
      changedelete = {hl = 'GitGutterChange', text = '▎'},
    },
--     keymaps = {
--        -- Default keymap options
--        noremap = true,
--        buffer = true,
--        ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
--        ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
--        ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
--        ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
--        ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
--        ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
--        ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
--        -- Text objects
--        ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
--        ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
--      },
     current_line_blame = true
  }
end

return config
