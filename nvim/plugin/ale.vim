let g:ale_fix_on_save = 1

" To remove the variable/function info in galaxyline
let g:ale_linters_explicit = 1

let g:ale_completion_enabled = 0

let g:ale_completion_autoimport = 0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_fixers = {
  \ 'typescript': ['prettier', 'eslint'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'typescriptreact': ['prettier', 'eslint'],
  \ 'javascriptreact': ['prettier', 'eslint'],
  \}
