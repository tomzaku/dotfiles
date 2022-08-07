function TableConcat(t1, t2)
	for i = 1, #t2 do
		t1[#t1 + 1] = t2[i]
	end
	return t1
end
function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end
local function splitByNumberChar(inputstr, number)
	local t = {}
	local length = inputstr:len()
	local i = 0
	while i < length do
		local nextIndex = i + number
		table.insert(t, string.sub(inputstr, i, nextIndex))
		i = nextIndex
	end
	table.insert(t, "   ")
	return t
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
local home = os.getenv("HOME")
local fortune = os.capture("fortune -s")
local db = require("dashboard")
db.custom_header = {
	"",
	"",
	"",
	"          ▀████▀▄▄              ▄█ ",
	"            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ",
	"    ▄        █          ▀▀▀▀▄  ▄▀  ",
	"   ▄▀ ▀▄      ▀▄              ▀▄▀  ",
	"  ▄▀    █     █▀   ▄█▀▄      ▄█    ",
	"  ▀▄     ▀▄  █     ▀██▀     ██▄█   ",
	"   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ",
	"    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ",
	"   █   █  █      ▄▄           ▄▀   ",
	"",
}

db.custom_footer = splitByNumberChar(fortune, 60)
db.session_directory = '~/Projects/dotfiles/nvim/session/'
-- db.custom_center = {
-- 	{
-- 		icon = " ",
-- 		desc = "Recently latest session                  ",
-- 		shortcut = "SPC s l",
-- 		action = "SessionLoad",
-- 	},
-- 	{
-- 		icon = "  ",
-- 		desc = "Recently opened files                   ",
-- 		action = "DashboardFindHistory",
-- 		shortcut = "SPC f h",
-- 	},
-- 	{
-- 		icon = "  ",
-- 		desc = "Find  File                              ",
-- 		action = "Telescope find_files find_command=rg,--hidden,--files",
-- 		shortcut = "SPC f f",
-- 	},
-- 	{
-- 		icon = "  ",
-- 		desc = "File Browser                            ",
-- 		action = "Telescope file_browser",
-- 		shortcut = "SPC f b",
-- 	},
-- 	{
-- 		icon = "  ",
-- 		desc = "Find  word                              ",
-- 		action = "Telescope live_grep",
-- 		shortcut = "SPC f w",
-- 	},
-- }
