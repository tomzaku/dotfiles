-- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.

local status_ok, lib = pcall(require, "trouble")
if not status_ok then
	return
end

lib.setup({})
