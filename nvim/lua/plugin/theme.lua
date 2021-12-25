vim.cmd('colorscheme kuroi')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
vim.cmd('hi EndOfBuffer guibg=NONE ctermbg=NONE ')
vim.cmd('hi CursorLine term=bold cterm=bold guibg=#0C0C0C ')
vim.cmd('vnoremap <C-C> "*y')

-- Comment should be italic
vim.cmd [[let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"]]
vim.cmd [[let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"]]
vim.cmd [[highlight Comment cterm=italic gui=italic]]
