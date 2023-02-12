local bind = require("keymap.bind")
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
	-- Vim map
	["n|<F1>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F1>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F2>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F3>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F4>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F5>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F6>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F7>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F8>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F9>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F10>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F11>"] = map_cmd("<nop>"), -- ignore Fn
	["i|<F12>"] = map_cmd("<nop>"), -- ignore Fn
	["n|ss"] = map_cu(":split"),
	["n|sv"] = map_cu(":vsplit"),
	["n|Y"] = map_cmd("y$"),
	["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap(),
	["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap(),
	["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap(),
	["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap(),
	["n|<C-q>"] = map_cmd(":wq<CR>"),
	["n|<Leader>ss"] = map_cu("SessionSave"):with_noremap(),
	["n|<Leader>sl"] = map_cu("SessionLoad"):with_noremap(),
	-- Insert
	["i|<C-h>"] = map_cmd("<BS>"):with_noremap(),
	["i|<C-d>"] = map_cmd("<Del>"):with_noremap(),
	["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap(),
	["i|<C-b>"] = map_cmd("<Left>"):with_noremap(),
	["i|<C-f>"] = map_cmd("<Right>"):with_noremap(),
	["i|<C-a>"] = map_cmd("<ESC>^A"):with_noremap(),
	["i|<C-j>"] = map_cmd("<Esc>o"):with_noremap(),
	["i|<C-k>"] = map_cmd("<Esc>O"):with_noremap(),
	["i|<C-s>"] = map_cmd("<Esc>:w<CR>"),
	["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"),
	-- command line
	["c|<C-b>"] = map_cmd("<Left>"):with_noremap(),
	["c|<C-f>"] = map_cmd("<Right>"):with_noremap(),
	["c|<C-a>"] = map_cmd("<Home>"):with_noremap(),
	["c|<C-e>"] = map_cmd("<End>"):with_noremap(),
	["c|<C-d>"] = map_cmd("<Del>"):with_noremap(),
	["c|<C-h>"] = map_cmd("<BS>"):with_noremap(),
	["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
	-- view
	["v|<C-c>"] = map_cmd('"*y'), -- copy

	-- quickfix
	["n|<C-n>"] = map_cmd(":cn<CR>"):with_noremap(),
	["n|<C-p>"] = map_cmd(":cp<CR>"):with_noremap(),
}

bind.nvim_load_mapping(def_map)
