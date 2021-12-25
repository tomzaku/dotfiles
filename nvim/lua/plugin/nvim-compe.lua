local status_ok, lib = pcall(require, "compe")
if not status_ok then
  return
end

lib.setup {
  enabled = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  allow_prefix_unmatch = false;
  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = false;
  };
}
