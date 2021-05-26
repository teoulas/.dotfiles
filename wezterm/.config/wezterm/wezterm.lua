local wezterm = require "wezterm";
return {
  color_scheme = "Builtin Tango Dark",
  bold_brightens_ansi_colors = false,
  enable_scroll_bar = true,
  enable_wayland = true,
  font = wezterm.font("Fantasque Sans Mono"),
  font_size = 13,
  freetype_load_target = "Light", -- HorizontalLcd is too bold
  freetype_render_target = "HorizontalLcd",

  -- Keybindings
  keys = {
    -- Splits
    {key="r", mods="CTRL|ALT", action=wezterm.action{
      SplitHorizontal={domain="CurrentPaneDomain"}
    }},
    {key="d", mods="CTRL|ALT", action=wezterm.action{
      SplitVertical={domain="CurrentPaneDomain"}
    }},
    -- Pane focus
    {key="LeftArrow", mods="ALT", action=wezterm.action{
      ActivatePaneDirection="Left"
    }},
    {key="RightArrow", mods="ALT", action=wezterm.action{
      ActivatePaneDirection="Right"
    }},
    {key="UpArrow", mods="ALT", action=wezterm.action{
      ActivatePaneDirection="Up"
    }},
    {key="DownArrow", mods="ALT", action=wezterm.action{
      ActivatePaneDirection="Down"
    }},
    -- Tab focus
    {key="PageUp", mods="CTRL", action=wezterm.action{
      ActivateTabRelative=-1
    }},
    {key="PageDown", mods="CTRL", action=wezterm.action{
      ActivateTabRelative=1
    }},

  }
}
