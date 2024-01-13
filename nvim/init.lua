-- Example for configuring Neovim to load user-installed installed Lua rocks:
--$ luarocks --local --lua-version=5.1 install magick
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

-- Load Modules:
require("core")
