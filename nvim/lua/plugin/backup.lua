-- Meaningful backup name, ex: filename@2015-04-05.14:59
vim.cmd [[au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")]]
