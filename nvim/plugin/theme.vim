hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi CursorLine term=bold cterm=bold guibg=#0C0C0C

vnoremap <C-C> "*y

" Comment should be italic
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
highlight Comment cterm=italic gui=italic
