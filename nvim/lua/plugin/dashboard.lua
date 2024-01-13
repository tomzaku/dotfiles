function TableConcat(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

local function splitByNumberChar(inputstr, number)
    local t = { "", "", "" }
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

local fortune = os.capture("fortune -s")

require("dashboard").setup({
    theme = "hyper",
    config = {
        footer = splitByNumberChar(fortune, 100),
        header = {
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
        },
        -- week_header = {
        -- 	enable = true,
        -- },
        shortcut = {
            { desc = " Update", group = "@property", action = "Lazy update", key = "u" },
            {
                icon = " ",
                icon_hl = "@variable",
                desc = "Files",
                group = "@property",
                action = "Telescope find_files",
                key = "f",
            },
        },
    },
})
