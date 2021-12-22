local config = {}

function config.nvim_lsp()
  require('modules.completion.lspconfig')
end

function config.lsp_saga()
  local saga = require 'lspsaga'
  saga.init_lsp_saga()
end

function config.nvim_compe()
  require'compe'.setup {
    enabled = true;
    debug = false;
    min_length = 1;
    preselect = 'always';
    allow_prefix_unmatch = false;
    source = {
      path = true;
      buffer = true;
      calc = true;
      vsnip = true;
      nvim_lsp = true;
      nvim_lua = true;
      spell = true;
      tags = true;
      snippets_nvim = false;
    };
  }
end

function config.vim_vsnip()
  vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets'
end

function config.telescope()
  if not packer_plugins['plenary.nvim'].loaded then
    vim.cmd [[packadd plenary.nvim]]
    vim.cmd [[packadd popup.nvim]]
    vim.cmd [[packadd telescope-fzy-native.nvim]]
  end
  require('telescope').setup {
    defaults = {
      prompt_prefix = '🔭 ',
      -- prompt_position = 'top',
      selection_caret = " ",
      layout_config = {
        horizontal = {
          mirror = false,
          preview_width = 0.75,
        },
        vertical = {
          mirror = true,
          preview_width = 0.75,
        },
        center = {
          mirror = false,
          preview_width = 0.75,
        },
      },
      layout_strategy='vertical',
      -- width = 0.75,
      -- results_width = 0.75,
      sorting_strategy = 'ascending',
      file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
      file_sorter =  require'telescope.sorters'.get_fuzzy_file,
      generic_sorter =  require'telescope.sorters'.get_fuzzy_file,
    },
    extensions = {
        -- fzy_native = {
        --     override_generic_sorter = false,
        --     override_file_sorter = true,
        -- }
        fzf_writer = {
            minimum_grep_characters = 2,
            minimum_files_characters = 2,

            -- Disabled by default.
            -- Will probably slow down some aspects of the sorter, but can make color highlights.
            -- I will work on this more later.
            use_highlighter = true,
        }
    }
  }
end

function config.vim_sonictemplate()
  vim.g.sonictemplate_postfix_key = '<C-,>'
  vim.g.sonictemplate_vim_template_dir = os.getenv("HOME").. '/.config/nvim/template'
end

function config.emmet()
  vim.g.user_emmet_complete_tag = 0
  vim.g.user_emmet_install_global = 0
  vim.g.user_emmet_install_command = 0
  vim.g.user_emmet_mode = 'i'
end

--function config.lspinstall()
--  require'lspinstall'.setup()
--end

function config.ale()
  --vim.g.ale_fixers = {'prettier', 'eslint'}
  --vim.g.ale_cache_executable_check_failures = 1
end


return config
