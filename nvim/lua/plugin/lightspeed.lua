local status_ok, lib = pcall(require, "lightspeed")
if not status_ok then
    return
end

lib.setup({})
