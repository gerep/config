-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.audible_bell = 'Disabled'
config.color_scheme = 'Everforest Dark (Gogh)'
config.font_size = 14

return config
