function! ToggleWindowHorizontalVerticalSplit()
  if !exists('t:splitType')
    let t:splitType = 'vertical'
  endif

  if t:splitType == 'vertical' " is vertical switch to horizontal
    windo wincmd K
    windo wincmd = " Same with and height for windows
    let t:splitType = 'horizontal'

  else " is horizontal switch to vertical
    windo wincmd H
    windo wincmd = " Same with and height for windows
    let t:splitType = 'vertical'
  endif
endfunction
