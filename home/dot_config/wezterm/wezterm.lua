local wezterm = require 'wezterm'

local config = {
    -- Colors & Appearance
    color_scheme = 'Dracula',
    initial_cols = 200,
    initial_rows = 100,

    -- Fonts
    font = wezterm.font_with_fallback({
        "UbuntuMono Nerd Font",
        "JetBrains Mono",
        "Monaco",
    }),
    font_size = 15.0,

    -- windows
    window_background_opacity = 0.875,
    window_close_confirmation = "NeverPrompt",

    -- Cursor
    default_cursor_style = "BlinkingBlock",

    -- Tab bar
    enable_scroll_bar = true,
    hide_tab_bar_if_only_one_tab = true,
}

return config
