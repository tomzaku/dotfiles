local status_ok, lib = pcall(require, "auto-session")
if not status_ok then
  return
end

lib.setup({
  -- auto_restore_enabled = false
  log_level="error",
  -- auto_session_root_dir="~/.config/nvim/session/"
})
