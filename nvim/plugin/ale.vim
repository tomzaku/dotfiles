let g:ale_fix_on_save = 1

" To remove the variable/function info in galaxyline
let g:ale_linters_explicit = 1

let g:ale_completion_enabled = 0

let g:ale_completion_autoimport = 0

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_javascript_eslint_executable = '/Users/tomzaku/Projects/shopee_react_native/pc/node_modules/.bin/bb8-lint'
let g:ale_fixers = {
  \ 'typescript': ['prettier', 'eslint'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'typescriptreact': ['prettier', 'eslint'],
  \ 'javascriptreact': ['prettier', 'eslint'],
  \ 'python': ['autopep8', 'yapf'],
  \ 'scss': ['prettier', 'stylelint'],
  \ 'svelte': ['prettier', 'eslint', 'stylelint']
  \}
