local status_ok, lib = pcall(require, "leap")
if not status_ok then
	return
end

lib.add_default_mappings()
