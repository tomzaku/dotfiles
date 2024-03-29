-- local function get_path()
-- 	local path = vim.fn.expand("%:p")
-- 	if vim.fn.empty(path) == 1 then
-- 		return ''
-- 	end
-- 	local splitPath = split(path, "/")
-- 	local lastIndex = #splitPath
-- 	local shortPath = slice(splitPath, lastIndex - 3, lastIndex)
-- 	return table.concat(shortPath, "/")
-- end

local show_macro_recording = function()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "@" .. recording_register .. " "
    end
end

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { "mode" },
        -- lualine_b = { 'branch', 'diff', 'diagnostics' },
        -- lualine_b = {},
        -- lualine_c = {'filename'},
        lualine_b = {
            {
                "filename",
                file_status = true, -- Displays file status (readonly status, modified status)
                newfile_status = false, -- Display new file status (new file means no write after created)
                path = 1, -- 0: Just the filename
                -- 1: Relative path
                -- 2: Absolute path
                -- 3: Absolute path, with tilde as the home directory

                shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                -- for other components. (terrible name, any suggestions?)
                symbols = {
                    modified = "[+]", -- Text to show when the file is modified.
                    readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                    unnamed = "[No Name]", -- Text to show for unnamed buffers.
                    newfile = "[New]", -- Text to show for newly created file before first write
                },
            },
        },
        lualine_c = {
            show_macro_recording,
            "searchcount",
        },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },

    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    -- winbar = {},
    -- inactive_winbar = {},
    -- extensions = {}
    extensions = { "nvim-tree", "toggleterm", "nvim-dap-ui" },
})
