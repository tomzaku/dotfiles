local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
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
