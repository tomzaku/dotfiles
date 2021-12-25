local lsp = vim.lsp
local format = {}

local function nvim_create_augroup(group_name,definitions)
  vim.api.nvim_command('augroup '..group_name)
  vim.api.nvim_command('autocmd!')
  for _, def in ipairs(definitions) do
    local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
    vim.api.nvim_command(command)
  end
  vim.api.nvim_command('augroup END')
end

function format.lsp_before_save()
  local defs = {}
  local ext = vim.fn.expand('%:e')

  -- This config for 'prettier/vim-prettier' plugin
  table.insert(defs,{"BufWritePre", '*.tsx,*.ts,*.scss,*.css',
                    "PrettierAsync"})
  
  nvim_create_augroup('lsp_before_save',defs)
end

return format
