local status_ok, lib = pcall(require, "accelerated-jk")
if not status_ok then
	return
end
lib.setup({})
