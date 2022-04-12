local status_ok, lib = pcall(require, "telescope")
if not status_ok then
  return
end
lib.setup({
  line_sep_start = '┌------- <Leader> R: repleace all; dd: toggle; <leader>o: option menu ------'
})
