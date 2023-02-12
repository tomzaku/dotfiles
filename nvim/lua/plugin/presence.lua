local status_ok, lib = pcall(require, "presence")
if not status_ok then
	return
end

function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, "r"))
	local s = assert(f:read("*a"))
	f:close()
	if raw then
		return s
	end
	s = string.gsub(s, "^%s+", "")
	s = string.gsub(s, "%s+$", "")
	s = string.gsub(s, "[\n\r]+", " ")
	return s
end
local function printFortune()
	local fortune = os.capture("fortune -s")
	return fortune
end

lib:setup({
	buttons = false,
	reading_text = "Reading", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
	workspace_text = printFortune, -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
	editing_text = "Editing", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
	file_explorer_text = "Browsing",
})
