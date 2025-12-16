local wezterm = require "wezterm"
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- General settings
config.automatically_reload_config = true
config.check_for_updates = false

-- Appearance
config.color_scheme = "Catppuccin Mocha"
config.default_cursor_style = "BlinkingBlock"
config.enable_scroll_bar = true
config.hide_mouse_cursor_when_typing = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false

-- Fonts
config.font = wezterm.font_with_fallback({
  "Ubuntu Mono",
  "LXGW WenKai Mono",
})
config.font_size = 15.0

-- Window
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.85
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = { left = 5, right = 5, top = 0, bottom = 0 }

return config
