function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
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
  font_size = 12,
  enable_tab_bar = false,

  color_scheme = "flavours",
  -- color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),

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
}
