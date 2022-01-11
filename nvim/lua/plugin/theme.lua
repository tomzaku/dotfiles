vim.cmd('colorscheme kuroi')
vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
vim.cmd('hi EndOfBuffer guibg=NONE ctermbg=NONE ')
vim.cmd('hi CursorLine term=bold cterm=bold guibg=#0C0C0C ')
vim.cmd('vnoremap <C-C> "*y')

-- Comment should be italic
vim.cmd [[let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"]]
vim.cmd [[let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"]]
vim.cmd [[highlight Comment cterm=italic gui=italic]]


-- SignColumn
vim.cmd [[highlight SignColumn ctermbg=NONE guibg=NONE]]
vim.cmd [[highlight ColorColumn ctermbg=0 guibg=NONE]] -- maximum chars col
vim.cmd [[highlight TabLine gui=NONE guibg=#041117 guifg=#abb2bf    cterm=NONE term=NONE ctermfg=black ctermbg=white]]
