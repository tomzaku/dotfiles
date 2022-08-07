local status_ok, lib = pcall(require, "colorizer")
if not status_ok then
  return
end
lib.setup {
  css = { rgb_fn = true; };
  scss = { rgb_fn = true; };
  sass = { rgb_fn = true; };
  stylus = { rgb_fn = true; };
  vim = { names = true; };
  tmux = { names = false; };
  'javascript';
  'javascriptreact';
  'typescript';
  'typescriptreact';
  html = {
    mode = 'foreground';
  }
}
