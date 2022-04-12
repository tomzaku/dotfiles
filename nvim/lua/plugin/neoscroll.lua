local status_ok, lib = pcall(require, "neoscroll")
if not status_ok then
  return
end

lib.setup({})
