-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.audible_bell = 'Disabled'
config.color_scheme = 'Rosé Pine Moon (Gogh)'
config.font = wezterm.font("Hack Nerd Font Mono", { weight = "Regular", stretch = "Normal", style = "Normal" })
config.font_size = 12

-- Performance improvements
config.animation_fps = 60
config.front_end = 'WebGpu' -- Try this first, if issues occur fall back to 'OpenGL'
config.webgpu_power_preference = 'HighPerformance'
config.enable_scroll_bar = false
config.scrollback_lines = 5000 -- Reduce if still having performance issues
config.enable_wayland = true   -- If you're on Linux

-- Your existing keybindings
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  -- Your existing key bindings remain the same
}

return config

