local indent = require("indent_blankline")

indent.setup {
  filetype_exclude = {"help", "terminal", "dashboard", "packer"},
  show_current_context_start = true,
  show_current_context = true,
  char = '╎'
}
