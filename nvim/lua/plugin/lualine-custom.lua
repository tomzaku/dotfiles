-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
	bg       = '#202328',
	fg       = '#bbc2cf',
	yellow   = '#ECBE7B',
	cyan     = '#008080',
	darkblue = '#081633',
	green    = '#98be65',
	orange   = '#FF8800',
	violet   = '#a9a1e1',
	magenta  = '#c678dd',
	blue     = '#51afef',
	red      = '#ec5f67',
}
local mode_color = {
	n = colors.blue,
	i = colors.green,
	v = colors.blue,
	[''] = colors.blue,
	V = colors.blue,
	c = colors.magenta,
	no = colors.red,
	s = colors.orange,
	S = colors.orange,
	[''] = colors.orange,
	ic = colors.yellow,
	R = colors.violet,
	Rv = colors.violet,
	cv = colors.red,
	ce = colors.red,
	r = colors.cyan,
	rm = colors.cyan,
	['r?'] = colors.cyan,
	['!'] = colors.red,
	t = colors.red,
}

local icons = {
	edit = " ",
	heading = "",
	separate = " - ",
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
		return "@" .. recording_register .. " "
	end
end



local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand('%:p:h')
		local gitdir = vim.fn.finddir('.git', filepath .. ';')
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = '',
		section_separators = '',
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left {
	function()
		return icons.heading
	end,
	color = function()
		return { fg = mode_color[vim.fn.mode()] }
	end,
	padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
	-- mode component
	function()
		local text = {
			n = "NORMAL",
			v = "VISUAL",
			V = "V-LINE",
			[""] = "V-BLOCK",
			s = "SELECT",
			S = "S-LINE",
			[""] = "S-BLOCK",
			i = "INSERT",
			R = "REPLACE",
			c = "COMMAND",
			r = "PROMPT",
			["!"] = "EXTERNAL",
			t = "TERMINAL",
		}
		return text[vim.fn.mode()]
	end,
	color = function()
		return { fg = mode_color[vim.fn.mode()], gui = 'bold' }
	end,
	padding = { right = 1 },
}

ins_left {
	'filename',
	file_status = true, -- Displays file status (readonly status, modified status)
	newfile_status = false, -- Display new file status (new file means no write after created)
	path = 1, -- 0: Just the filename
	-- 1: Relative path
	-- 2: Absolute path
	-- 3: Absolute path, with tilde as the home directory

	shorting_target = 40, -- Shortens path to leave 40 spaces in the window
	-- for other components. (terrible name, any suggestions?)
	symbols = {
		modified = '[+]', -- Text to show when the file is modified.
		readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
		unnamed = '[No Name]', -- Text to show for unnamed buffers.
		newfile = '[New]', -- Text to show for newly created file before first write
	},

	'filename',
	cond = conditions.buffer_not_empty,
}

ins_left {
	show_macro_recording
}

ins_left {
	"searchcount"
}
-- Add components to right sections
ins_right {
	'progress', -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
}
ins_right {
	'location', -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
}
ins_right {
	'filetype', -- option component same as &encoding in viml
}
-- Now don't forget to initialize lualine
lualine.setup(config)
