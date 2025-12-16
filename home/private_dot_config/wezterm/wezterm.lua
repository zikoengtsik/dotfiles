local wezterm = require("wezterm")
local config = require("config")
local action = wezterm.action

-- Maximize the window on startup
wezterm.on("gui-startup", function()
  local _, _, window = wezterm.mux.spawn_window({})
  window:gui_window():maximize()
end)

--- Key binding
config.disable_default_key_bindings = true
config.keys = {
    { key = 'Tab', mods = 'CTRL', action = action.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = action.ActivateTabRelative(-1) },
    { key = '+', mods = 'SUPER', action = action.IncreaseFontSize },
    { key = '-', mods = 'SUPER', action = action.DecreaseFontSize },
    { key = '0', mods = 'SUPER', action = action.ResetFontSize },
    { key = '1', mods = 'SUPER', action = action.ActivateTab(0) },
    { key = '2', mods = 'SUPER', action = action.ActivateTab(1) },
    { key = '3', mods = 'SUPER', action = action.ActivateTab(2) },
    { key = '4', mods = 'SUPER', action = action.ActivateTab(3) },
    { key = '5', mods = 'SUPER', action = action.ActivateTab(4) },
    { key = '6', mods = 'SUPER', action = action.ActivateTab(5) },
    { key = '7', mods = 'SUPER', action = action.ActivateTab(6) },
    { key = '8', mods = 'SUPER', action = action.ActivateTab(7) },
    { key = '9', mods = 'SUPER', action = action.ActivateTab(8) },
    { key = '9', mods = 'SHIFT|CTRL', action = action.ActivateTab(8) },
    { key = 'C', mods = 'SUPER', action = action.CopyTo 'Clipboard' },
    { key = 'C', mods = 'SHIFT|CTRL', action = action.CopyTo 'Clipboard' },
    { key = 'H', mods = 'SUPER', action = action.HideApplication },
    { key = 'H', mods = 'SHIFT|CTRL', action = action.HideApplication },
    { key = 'N', mods = 'SUPER', action = action.SpawnWindow },
    { key = 'N', mods = 'SHIFT|CTRL', action = action.SpawnWindow },
    { key = 'P', mods = 'SUPER', action = action.ActivateCommandPalette },
    { key = 'P', mods = 'SHIFT|CTRL', action = action.ActivateCommandPalette },
    { key = 'Q', mods = 'SUPER', action = action.QuitApplication },
    { key = 'Q', mods = 'SHIFT|CTRL', action = action.QuitApplication },
    { key = 'T', mods = 'SUPER', action = action.SpawnTab 'CurrentPaneDomain' },
    { key = 'T', mods = 'SHIFT|CTRL', action = action.SpawnTab 'CurrentPaneDomain' },
    { key = 'V', mods = 'SUPER', action = action.PasteFrom 'Clipboard' },
    { key = 'V', mods = 'SHIFT|CTRL', action = action.PasteFrom 'Clipboard' },
    { key = 'W', mods = 'SUPER', action = action.CloseCurrentTab{ confirm = true } },
    { key = 'W', mods = 'SHIFT|CTRL', action = action.CloseCurrentTab{ confirm = true } },
    { key = 'c', mods = 'SUPER', action = action.CopyTo 'Clipboard' },
    { key = 'c', mods = 'SHIFT|CTRL', action = action.CopyTo 'Clipboard' },
    { key = 'h', mods = 'SUPER', action = action.HideApplication },
    { key = 'h', mods = 'SHIFT|CTRL', action = action.HideApplication },
    { key = 'n', mods = 'SUPER', action = action.SpawnWindow },
    { key = 'n', mods = 'SHIFT|CTRL', action = action.SpawnWindow },
    { key = 'p', mods = 'SUPER', action = action.ActivateCommandPalette },
    { key = 'p', mods = 'SHIFT|CTRL', action = action.ActivateCommandPalette },
    { key = 'q', mods = 'SUPER', action = action.QuitApplication },
    { key = 'q', mods = 'SHIFT|CTRL', action = action.QuitApplication },
    { key = 't', mods = 'SUPER', action = action.SpawnTab 'CurrentPaneDomain' },
    { key = 't', mods = 'SHIFT|CTRL', action = action.SpawnTab 'CurrentPaneDomain' },
    { key = 'v', mods = 'SUPER', action = action.PasteFrom 'Clipboard' },
    { key = 'v', mods = 'SHIFT|CTRL', action = action.PasteFrom 'Clipboard' },
    { key = 'w', mods = 'SUPER', action = action.CloseCurrentTab{ confirm = true } },
    { key = 'w', mods = 'SHIFT|CTRL', action = action.CloseCurrentTab{ confirm = true } },
}

return config
