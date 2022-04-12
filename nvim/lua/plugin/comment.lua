local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
  pre_hook = function(ctx)
    local U = require 'Comment.utils'
    local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
    return require('ts_context_commentstring.internal').calculate_commentstring {
      key = type,
    }
end,
}
