local status_ok, galaxyline = pcall(require, "galaxyline")
if not status_ok then
	return
end

local condition = require("galaxyline.condition")

local icons = {
	edit = " ",
	heading = "",
	-- separate = "  ",
	separate = " - ", 
	-- separate = "  ",
	sep = {
		left = "",
		right = "",
		space = " ",
	},
	diagnostic = {
		error = " ",
		warn = " ",
		info = " ",
	},
	diff = {
		add = " ",
		modified = " ",
		remove = " ",
	},
	-- git = ""
	git = " ",
	lsp = {
		working = " ",
		idle = " ",
	},
}

local show_macro_recording = function()
	local recording_register = vim.fn.reg_recording()
	if recording_register == "" then
		return ""
	else
		return "Recording @" .. recording_register .. " "
	end
end

local split = function(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local slice = function(tbl, first, last, step)
	local sliced = {}

	for i = first or 1, last or #tbl, step or 1 do
		sliced[#sliced + 1] = tbl[i]
	end

	return sliced
end

local get_visible_lsp = function()
	local tbl = { ["dashboard"] = true, [""] = true }
	if tbl[vim.bo.filetype] then
		return false
	end
	return true
end

local get_is_not_visible_lsp = function()
	return not get_visible_lsp()
end

local get_path = function()
	local path = vim.fn.expand("%:p")
	if vim.fn.empty(path) == 1 then
		return ""
	end
	local splitPath = split(path, "/")
	local lastIndex = #splitPath
	local shortPath = slice(splitPath, lastIndex - 3, lastIndex)
	return table.concat(shortPath, "/")
end

local should_hide_galaxy_line = function()
	local path = vim.fn.expand("%:p")
	if string.find(path, "NvimTree") then
		return false
	end
	return condition.buffer_not_empty()
end

-- function should_hide_galaxy_line_and_empty_file()
-- 	return should_hide_galaxy_line() and condition.buffer_not_empty()
-- end

local colors = {
	bg = "#1D1D1D",
	fg = "#bbc2cf",
	error = "#EA3323",
	warn = "#F3A83B",
	yellow = "#beb100",
	cyan = "#008080",
	darkblue = "#0277BD",
	green = "#00C4AB",
	orange = "#BA3600",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	blue = "#40C4FF",
	red = "#FF5151",
	gray = "#263238",
	lightgray = "#344149",
	darkergray = "#182124",
}

-- shorten lines for these filetypes
galaxyline.short_line_list = {
	"LuaTree",
	"floaterm",
	"dbui",
	"startify",
	"term",
	"nerdtree",
	"fugitive",
	"fugitiveblame",
	"NvimTree",
}

-- hide NvimTree
-- vim.api.nvim_exec(
-- 	[[
-- au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
-- ]],
-- 	false
-- )

local modes = {
	n = { "NORMAL", colors.green },
	v = { "VISUAL", colors.yellow },
	V = { "V-LINE", colors.yellow },
	[""] = { "V-BLOCK", colors.yellow },
	s = { "SELECT", colors.orange },
	S = { "S-LINE", colors.orange },
	[""] = { "S-BLOCK", colors.orange },
	i = { "INSERT", colors.orange },
	R = { "REPLACE", colors.red },
	c = { "COMMAND", colors.darkblue },
	r = { "PROMPT", colors.brown },
	["!"] = { "EXTERNAL", colors.orange },
	t = { "TERMINAL", colors.blue },
}

local get_vim_mode_style = function()
	local vim_mode = vim.fn.mode()
	return modes[vim_mode]
end

local get_filename = function()
	return vim.fn.expand("%:h:t") .. "/" .. vim.fn.expand("%:t")
end

local file_readonly = function(readonly_icon)
	if vim.bo.filetype == "help" then
		return ""
	end
	local icon = readonly_icon or ""
	if vim.bo.readonly == true then
		return icon
	end
	return ""
end

local show_editting_file = function()
	local file = get_filename()
	if vim.fn.empty(file) == 1 then
		return ""
	end
	if string.len(file_readonly()) ~= 0 then
		return file_readonly()
	end
	if vim.bo.modifiable then
		if vim.bo.modified then
			return "  " .. icons.edit
		end
	end
	return ""
end

local sectionCount = {
	left = 0,
	mid = 0,
	right = 0,
	short_line_left = 0,
	short_line_right = 0,
}

local nextSectionNum = function(sectionKind)
	local num = sectionCount[sectionKind] + 1
	sectionCount[sectionKind] = num
	return num
end

local addSection = function(sectionKind, section)
	local num = nextSectionNum(sectionKind)
	local id = sectionKind .. "_" .. num .. "_" .. section.name
	-- note: this is needed since id's get mapped to highlights name `Galaxy<Id>`
	if section.useNameAsId == true then
		id = section.name
	end
	galaxyline.section[sectionKind][num] = {
		[id] = section,
	}
end

local addSections = function(sectionKind, sections)
	for _, section in pairs(sections) do
		addSection(sectionKind, section)
	end
end

local string_provider = function(str)
	return function()
		return str
	end
end

local create_space_section = function(color)
	return {
		name = "whitespace",
		provider = string_provider(" "),
		highlight = { color, color },
	}
end

local create_macro_recording = function(color)
	return {
		name = "Macro",
		useNameAsId = true,
		provider = function()
			vim.api.nvim_command("hi GalaxyMacro guifg=" .. colors.yellow)
			return show_macro_recording()
		end,
		highlight = { color, color, "bold" },
	}
end

local create_separate_section = function(fg, bg)
	return {
		name = "whitespace",
		provider = string_provider(icons.separate),
		highlight = { fg, bg },
	}
end

local get_lsp_client = function(msg)
	msg = msg or icons.lsp.idle .. "no active lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end

	for i = #clients, 1, -1 do
		local client = clients[i]
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return icons.lsp.working .. client.name
		end
	end
	return msg
end

addSections("left", {
	{
		name = "ViModeLeftCap",
		useNameAsId = true,
		provider = function()
			local modeStyle = get_vim_mode_style()
			vim.api.nvim_command("hi GalaxyViModeLeftCap guifg=" .. modeStyle[2])
			return icons.heading
		end,
		highlight={colors.fg, colors.bg},
	},
	{
		name = "ViMode",
		useNameAsId = true,
		provider = function()
			-- auto change color according the vim mode
			local modeStyle = get_vim_mode_style()
			vim.api.nvim_command("hi GalaxyViMode guifg=" .. modeStyle[2])
			return icons.sep.space .. modeStyle[1] .. icons.sep.space
		end,
		highlight = { colors.fg, colors.bg, "bold" },
	},
	create_space_section(colors.bg),
	create_macro_recording(colors.bg),
	{
		name = "FileIcon",
		condition = condition.buffer_not_empty,
		highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
		provider = "FileIcon",
	},
	{
		name = "GetPath",
		provider = get_path,
		condition = condition.buffer_not_empty,
		highlight={colors.fg, colors.bg},
	},
	{
		name = "ShowEdittingFile",
		provider = show_editting_file,
		condition = condition.buffer_not_empty,
		highlight={colors.fg, colors.bg},
	},
})

addSections("right", {
	{
		name = "LineColumn",
		provider = "LineColumn",
		highlight={colors.fg, colors.bg},
	},
	{
		name = "LinePercent",
		provider = "LinePercent",
		highlight={colors.fg, colors.bg},
	},
	{
		name = "DiagnosticError",
		provider = "DiagnosticError",
		icon = "  ",
		highlight={colors.fg, colors.bg},
	},
	-- createSpaceSection(colors.gray),
	{
		name = "DiagnosticWarn",
		provider = "DiagnosticWarn",
		icon = "   ",
		highlight={colors.fg, colors.bg},
	},
	-- {
	-- 	name = "fileName",
	-- 	provider = show_editting_file,
	-- 	condition = condition.buffer_not_empty,
	-- 	-- highlight = {colors.blue, colors.gray},
	-- 	highlight = { colors.bg, colors.blue, "bold" },
	-- },
	create_separate_section("#5C5C5C", colors.bg),
	{
		name = "GetLspClient",
		provider = get_lsp_client,
		condition = get_visible_lsp,
		highlight={colors.fg, colors.bg},
		-- icon = icons.lsp,
	},
	create_space_section(colors.bg),
})

addSections("short_line_left", {
	{
		name = "ViModeLeftCap",
		useNameAsId = true,
		provider = function()
			local modeStyle = get_vim_mode_style()
			vim.api.nvim_command("hi GalaxyViModeLeftCap guifg=" .. modeStyle[2])
			return icons.heading
		end,
		condition = should_hide_galaxy_line,
		highlight={colors.fg, colors.bg},
	},
	{
		name = "ViMode",
		useNameAsId = true,
		provider = function()
			-- auto change color according the vim mode
			local modeStyle = get_vim_mode_style()
			vim.api.nvim_command("hi GalaxyViMode guifg=" .. modeStyle[2])
			return icons.sep.space .. modeStyle[1] .. icons.sep.space
		end,
		condition = should_hide_galaxy_line,
		highlight = { colors.fg, colors.bg, "bold" },
	},
	create_space_section(colors.bg),
	{
		name = "FileIcon",
		condition = should_hide_galaxy_line,
		provider = "FileIcon",
		highlight={colors.fg, colors.bg},
	},
	{
		name = "GetPath",
		provider = get_filename,
		condition = should_hide_galaxy_line,
		highlight={colors.fg, colors.bg},
	},
	{
		name = "ShowEdittingFile",
		provider = show_editting_file,
		condition = should_hide_galaxy_line,
		highlight={colors.fg, colors.bg},
	},
})

addSections("short_line_right", {
	-- createSpaceSection(colors.base02),
})
