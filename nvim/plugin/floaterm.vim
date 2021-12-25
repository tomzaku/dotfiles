" Toggle the terminal 
nnoremap <silent> <leader>g :FloatermShowOrNew lazygit<CR>

command! -nargs=* -complete=customlist,floaterm#cmdline#complete -bang -range
\   FloatermShowOrNew call floaterm#show_or_new(<bang>0, [visualmode(), <range>, <line1>, <line2>], <q-args>)

function! floaterm#show_or_new(bang, rangeargs, cmdargs)
    let [cmd, config] = floaterm#cmdline#parse(a:cmdargs)
    for bufnr in floaterm#buflist#gather()
        let title = getbufvar(bufnr, 'floaterm_title')
        if title == cmd
            call floaterm#terminal#open_existing(bufnr)
            return 0
        endif
    endfor
    call floaterm#run('new', a:bang, a:rangeargs, "--autoclose=2 --title=".cmd." ".a:cmdargs)
endfunction

