local status_ok, lib = pcall(require, "gitsigns")
if not status_ok then
  return
end


lib.setup {
  signs = {
    add = {hl = 'GitGutterAdd', text = '▋'},
    change = {hl = 'GitGutterChange',text= '▋'},
    delete = {hl= 'GitGutterDelete', text = '▋'},
    topdelete = {hl ='GitGutterDeleteChange',text = '▔'},
    changedelete = {hl = 'GitGutterChange', text = '▎'},
  },
  current_line_blame_opts ={
    delay = 500,
  },
   current_line_blame = true,
}

vim.api.nvim_command('hi GitSignsCurrentLineBlame term=bold cterm=bold guibg=#0C0C0C')
