local galaxyline = require("galaxyline")
local condition = require("galaxyline.condition")
local diagnostic = require("galaxyline.provider_diagnostic")
local vcs = require("galaxyline.provider_vcs")
local fileinfo = require("galaxyline.provider_fileinfo")

local icons = {
  duck = "🦆",
  goat = "🐐",
  knight = "♞",
  clubs = "♣︎",
  sep = {
    left = "",
    right = "",
    space = " "
  },
  diagnostic = {
    error = " ",
    warn = " ",
    info = " "
  },
  diff = {
    add = " ",
    modified = " ",
    remove = " "
  },
  -- git = ""
  git = " ",
  lsp = " "
}

function Split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function Slice(tbl, first, last, step)
  local sliced = {}

  for i = first or 1, last or #tbl, step or 1 do
    sliced[#sliced+1] = tbl[i]
  end

  return sliced
end

function VisibleLsp ()
  local tbl = {['dashboard'] = true,['']=true}
  if tbl[vim.bo.filetype] then
    return false
  end
  return true
end

function GetPath()
  local path = vim.fn.expand('%:p')
  if vim.fn.empty(path) == 1 then return '' end
  local splitPath = Split(path, '/')
  local lastIndex = #splitPath
  local shortPath = Slice(splitPath, lastIndex - 3, lastIndex)
  return table.concat(shortPath, '/')
end

function HideGalaxyLine()
  local path = vim.fn.expand('%:p')
  if string.find(path, "NvimTree") then
    return false
  end
  return true

end

local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#7D7400',
  cyan = '#008080',
  darkblue = '#0277BD',
  green = '#00796B',
  orange = '#E65100',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#40C4FF';
  red = '#B71C1C';
  gray = '#263238';
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
  "NvimTree"
}

local modes = {
  n = {"NORMAL", colors.green},
  v = {"VISUAL", colors.yellow},
  V = {"V-LINE", colors.yellow},
  [""] = {"V-BLOCK", colors.cyan},
  s = {"SELECT", colors.orange},
  S = {"S-LINE", colors.orange},
  [""] = {"S-BLOCK", colors.orange},
  i = {"INSERT", colors.orange},
  R = {"REPLACE", colors.red},
  c = {"COMMAND", colors.darkblue},
  r = {"PROMPT", colors.brown},
  ["!"] = {"EXTERNAL", colors.orange},
  t = {"TERMINAL", colors.orange}
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
  local icon = readonly_icon or ""
  if vim.bo.readonly == true then
    return icon
  end
  return ""
end

local current_file_name_provider = function()
  local file = get_filename()
  if vim.fn.empty(file) == 1 then
    return ""
  end
  if string.len(file_readonly()) ~= 0 then
    return file_readonly()
  end
  local icon = " "
  if vim.bo.modifiable then
    if vim.bo.modified then
      return icon
    end
  end
  return ""
end

local sectionCount = {
  left = 0,
  mid = 0,
  right = 0,
  short_line_left = 0,
  short_line_right = 0
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
  if (section.useNameAsId == true) then
    id = section.name
  end
  galaxyline.section[sectionKind][num] = {
    [id] = section
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

local createSpaceSection = function(color)
  return {
    name = "whitespace",
    provider = string_provider(" "),
    highlight = {color, color}
  }
end

addSections(
  "left",
  {
    {
      name = "ViModeLeftCap",
      useNameAsId = true,
      provider = function()
        local modeStyle = get_vim_mode_style()
        vim.api.nvim_command("hi GalaxyViModeLeftCap guifg=" .. modeStyle[2])
        return icons.sep.left
      end,
      highlight = {colors.base02, colors.bg_active}
    },
    {
      name = "ViMode",
      useNameAsId = true,
      provider = function()
        -- auto change color according the vim mode
        local modeStyle = get_vim_mode_style()
        vim.api.nvim_command("hi GalaxyViMode guibg=" .. modeStyle[2])
        return icons.sep.space .. modeStyle[1] .. icons.sep.space
      end,
      highlight = {colors.light01, colors.base02, "bold"}
    },
    {
      name = "ViModeRightCap",
      useNameAsId = true,
      provider = function()
        local modeStyle = get_vim_mode_style()
        vim.api.nvim_command("hi GalaxyViModeRightCap guifg=" .. modeStyle[2])
        return icons.sep.right
      end,
      highlight = {colors.base02, colors.bg_active}
    },
    createSpaceSection(colors.bg_active),
    {
      name = "FileIcon",
      condition = condition.buffer_not_empty,
      highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.base02},
      provider = 'FileIcon',
    },
    {
      name = "fileName",
      provider = current_file_name_provider,
      condition = condition.buffer_not_empty,
      highlight = {colors.base07, colors.base02},
    },
    {
      name = "GetPath",
      provider = GetPath,
      condition = condition.buffer_not_empty,
      highlight = {colors.fg,colors.base02,'bold'}
    },
  }
)

addSections(
  "right",
  {
    {
      name = "leftRightLsp",
      provider = string_provider(icons.sep.left),
      highlight = {colors.gray, colors.base02}
    },
    {
      name = "LineColumn",
      provider = "LineColumn",
      highlight = {colors.fg,colors.gray},
    },
    {
      name = "LinePercent",
      provider = 'LinePercent',
      highlight = {colors.fg,colors.gray,'bold'},
    },
    {
      name = "leftRightLsp",
      provider = string_provider(icons.sep.left),
      highlight = {colors.blue, colors.gray},
      condition = VisibleLsp,
    },
    {
      name = "fileName",
      provider = current_file_name_provider,
      condition = condition.buffer_not_empty,
      -- highlight = {colors.blue, colors.gray},
      highlight = {colors.bg,colors.blue,'bold'}
    },
    {
      name = "GetLspClient",
      provider = "GetLspClient",
      condition = VisibleLsp,
      -- icon = icons.lsp,
      highlight = {colors.bg,colors.blue,'bold'}
    },
    {
      name = "fileRightLsp",
      provider = string_provider(icons.sep.right),
      highlight = {colors.blue, colors.bg_active},
      -- condition = VisibleLsp
    },
  }
)

addSections(
  "short_line_left",
  {
    createSpaceSection(colors.base02),
    {
      name = "viModeLeftCap",
      provider = string_provider(icons.sep.left),
      condition = HideGalaxyLine,
      highlight = {colors.gray, colors.base02}
    },
    {
      name = "viMode",
      condition = HideGalaxyLine,
      provider = function()
        local modeStyle = get_vim_mode_style()
        return icons.sep.space .. modeStyle[1] .. icons.sep.space
      end,
      highlight = {colors.base02, colors.gray, "bold"}
    },
    {
      name = "viModeRightCap",
      condition = HideGalaxyLine,
      provider = string_provider(icons.sep.right),
      highlight = {colors.gray, colors.base02}
    },
    createSpaceSection(colors.bg_active),
    {
      name = "FileIcon",
      condition = condition.buffer_not_empty,
      highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.base02},
      provider = 'FileIcon',
    },
    -- {
    --   name = "fileName",
    --   provider = current_file_name_provider,
    --   condition = condition.buffer_not_empty,
    --   highlight = {colors.base07, colors.base02},
    -- },
    {
      name = "GetPath",
      provider = GetPath,
      condition = condition.buffer_not_empty,
      highlight = {colors.fg,colors.base02,'bold'}
    },
  }
)

addSections(
  "short_line_right",
  {
    createSpaceSection(colors.base02),
  }
)
