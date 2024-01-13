local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

function _FIND_UP_PACKAGE_JSON()
    local currentPath = vim.fn.expand("%:p")
    local cmdString = "find-up 'package.json' --cwd=" .. currentPath
    local packageJsonPath = os.capture(cmdString)
    if packageJsonPath then
        vim.cmd("e" .. packageJsonPath)
    end
end

function _COPY_PACKAGE_NAME()
    local currentPath = vim.fn.expand("%:p")
    local cmdString = "find-up 'package.json' --cwd=" .. currentPath
    local packageJsonPath = os.capture(cmdString)
    if packageJsonPath then
        local cmd = "cat " .. packageJsonPath .. ' | grep "name" | sed -E "s/.* \\"(.*)\\",/\\1/g" | head -n 1'
        local packageName = os.capture(cmd)
        print(packageName)
        -- copy
        local copyCmd = 'let @+ = expand("' .. packageName .. '")'
        vim.cmd(copyCmd)
        return packageName
    end
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    --[[ triggers = "auto", -- automatically setup triggers ]]
    triggers = { "<leader>" }, -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
    lazygit:toggle()
end

local mappings = {
    ["b"] = {
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        "Buffers",
    },
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    ["E"] = { "<cmd>NvimTreeFindFile<cr>", "Explorer File" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    c = {
        name = "Copy",
        f = { '<cmd>let @+ = expand("%:p")<cr><cmd>echo expand("%:p")<cr>', "Copy full path" },
        p = {
            '<cmd>let @+ = fnamemodify(expand("%"), ":~:.")<cr><cmd>echo fnamemodify(expand("%"), ":~:.")<cr>',
            "Copy project path",
        },
        P = { "<cmd>lua _COPY_PACKAGE_NAME()<CR>", "Copy package name of package.json" },
    },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    f = {
        name = "Finding",
        f = { "<cmd>Telescope find_files<cr>", "Find files" },
        h = { "<cmd>Telescope oldfiles cwd_only=v:true<cr>", "History files" },
        w = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find words" },
        s = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Search current world" },
        S = {
            "<cmd>lua require('spectre').open_visual({path = vim.fn.fnamemodify(vim.fn.expand('%:h').. '/**/*', ':~:.')})<CR>",
            "Search directory",
        },
        b = { "<cmd>Telescope file_browser<cr>", "File browser" },
        P = { "<cmd>lua _FIND_UP_PACKAGE_JSON()<CR>", "Find up package.json" },
    },
    g = {
        name = "Git",
        l = {
            "<cmd>FloatermShowOrNew lazygit<cr>",
            "Lazy Git",
        },
        d = {
            "<cmd>DiffviewFileHistory %<cr>",
            "Diff",
        },
        c = {
            "<cmd>DiffviewClose<cr>",
            "Close Diff",
        },
    },
    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        -- d = { "<cmd> Lspsaga preview_definition<cr>", "Preview Definition" },
        D = { "<cmd> lua vim.lsp.buf.definition()<cr>", "Definition" },
        w = {
            "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            "Workspace Diagnostics",
        },
        f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        j = {
            "<cmd>lua vim.diagnostic.goto_next()<CR>",
            "Next Diagnostic",
        },
        k = {
            "<cmd>lua vim.diagnostic.goto_prev()<cr>",
            "Prev Diagnostic",
        },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
        t = { "<cmd>Vista<cr>", "Tagbar" },
    },
    s = {
        name = "Search",
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
    },
    t = {
        name = "Terminal",
        n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
        t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
        p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
        -- c = { "<cmd>!tmux split-window -c %:p:h <cr>", "Directory here" },
        c = { "<cmd>!kitty @ new-window --cwd %:p:h <cr>", "Directory here" },
    },
    p = {
        name = "Windows",
        v = { "<cmd>vsplit<cr>", "Split vertical" },
        h = { "<cmd>split<cr>", "Split horizontal" },
        t = { "<cmd>call ToggleWindowHorizontalVerticalSplit()<cr>", "Toggle pane" },
    },
    ["\\"] = { "<cmd>vsplit<cr>", "Split vertical" },
    ["|"] = { "<cmd>vsplit<cr>", "Split vertical" },
    ["-"] = { "<cmd>split<cr>", "Split horizontal" },
    ["_"] = { "<cmd>split<cr>", "Split horizontal" },
    z = { "<cmd>TZFocus<cr>", "Focus mode" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
