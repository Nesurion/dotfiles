-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"

-- Font configuration
config.font = wezterm.font("Lilex Nerd Font")
config.font_size = 15.0

-- Window configuration
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.audible_bell = "Disabled"

-- Keybindings
config.keys = {
	-- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
	{
		key = "LeftArrow",
		mods = "OPT",
		action = act.SendKey({
			key = "b",
			mods = "ALT",
		}),
	},
	{
		key = "RightArrow",
		mods = "OPT",
		action = act.SendKey({ key = "f", mods = "ALT" }),
	},
	{
		key = "f",
		mods = "SUPER",
		action = act.Search({ CaseInSensitiveString = "" }),
	},
}

-- and finally, return the configuration to wezterm
return config
