local status_ok, lib = pcall(require, "todo-comments")
if not status_ok then
  return
end

lib.setup({})
