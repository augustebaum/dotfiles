local function get_theme()
  local _time = os.date("*t")
  if _time.hour >= 17 or _time.hour < 9 then
    return "Catppuccin Frappe"
  else
    return "Catppuccin Latte"
  end
end

return {
  font = wezterm.font(
    "FiraCode Nerd Font Mono",
    {weight="Medium"}
  ),
  font_size = 11,
  enable_tab_bar = false,

  color_scheme = get_theme(),

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  
  adjust_window_size_when_changing_font_size = false,
  automatically_reload_config = true,

  keys = {
    { key = "Enter", mods = "ALT", action = "DisableDefaultAssignment" },
  },

  check_for_updates = false,
}
