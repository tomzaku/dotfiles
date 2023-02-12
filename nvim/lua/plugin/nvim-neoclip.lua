local status_ok, lib = pcall(require, "neoclip")
if not status_ok then
	return
end

lib.setup()
