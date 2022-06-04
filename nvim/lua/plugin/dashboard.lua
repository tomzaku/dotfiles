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
  while (i<length)
  do
    local nextIndex = i+number
    table.insert(t, string.sub(inputstr, i, nextIndex))
    i = nextIndex
  end
  table.insert(t, '   ')
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
-- vim.g.dashboard_custom_footer = TableConcat({''}, Split(fortune, '   '))
-- vim.g.dashboard_custom_footer = { fortune }
vim.g.dashboard_custom_footer = splitByNumberChar(fortune, 60)
-- vim.g.dashboard_preview_command = 'cat'
vim.g.dashboard_custom_header = {
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
-- vim.g.dashboard_preview_pipeline = 'lolcat'
-- vim.g.dashboard_preview_file = home .. '/.config/nvim/static/neovim.cat'
-- vim.g.dashboard_preview_file_height = 4 -- pikachu
-- vim.g.dashboard_preview_file_width = 13 -- pikachu
-- vim.g.dashboard_preview_file_height = 20 -- dota
-- vim.g.dashboard_preview_file_width = 42 -- dota
-- vim.g.dashboard_preview_file_height = 30 -- vegata
-- vim.g.dashboard_preview_file_width = 80 -- vegata
-- hide
-- vim.g.dashboard_preview_file_height = 1
-- vim.g.dashboard_preview_file_width = 1
vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_custom_section = {
	last_session = {
		description = { "  Recently latest session                  SPC s l" },
		command = "SessionLoad",
	},
	find_history = {
		description = { "  Recently opened files                   SPC f h" },
		command = "DashboardFindHistory",
	},
	find_file = {
		description = { "  Find  File                              SPC f f" },
		command = "Telescope find_files find_command=rg,--hidden,--files",
	},
	new_file = {
		description = { "  File Browser                            SPC f b" },
		command = "Telescope file_browser",
	},
	find_word = {
		description = { "  Find  word                              SPC f w" },
		command = "DashboardFindWord",
	},
}
