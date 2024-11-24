local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- initial window size
config.initial_cols = 200
config.initial_rows = 100

-- fonts
config.font = wezterm.font_with_fallback({
    "Ubuntu Mono",
    "JetBrains Mono",
    "Monaco",
})
config.font_size = 15.0

-- colors
config.color_scheme = 'Dracula'

-- windows
config.window_background_opacity = 0.875
config.window_close_confirmation = "NeverPrompt"

-- cursor
config.default_cursor_style = "BlinkingBlock"

-- tab bar
config.enable_scroll_bar = true
config.hide_tab_bar_if_only_one_tab = true

return config
