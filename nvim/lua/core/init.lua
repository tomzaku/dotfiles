local global = require("core.global")
local vim = vim

-- Create cache dir and subs dir
local createdir = function()
    local data_dir = {
        global.cache_dir .. "backup",
        global.cache_dir .. "session",
        global.cache_dir .. "swap",
        global.cache_dir .. "tags",
        global.cache_dir .. "undo",
    }
    -- There only check once that If cache_dir exists
    -- Then I don't want to check subs dir exists
    if vim.fn.isdirectory(global.cache_dir) == 0 then
        os.execute("mkdir -p " .. global.cache_dir)
        for _, v in pairs(data_dir) do
            if vim.fn.isdirectory(v) == 0 then
                os.execute("mkdir -p " .. v)
            end
        end
    end
end

local leader_map = function()
    vim.g.mapleader = " "
    vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
    vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local load_core = function()
    require("core.options")
    require("plugin")
    createdir()
    leader_map()
    require("core.mapping")
end

load_core()
