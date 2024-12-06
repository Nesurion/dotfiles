-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night"

config.inactive_pane_hsb = {
	saturation = 0.6,
	brightness = 0.5,
}

-- Font configuration
config.font = wezterm.font_with_fallback({ "Berkeley Mono", "FiraCode Nerd Font" })
config.font_size = 15.0

-- Window configuration
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.audible_bell = "Disabled"

config.scrollback_lines = 5000

config.window_close_confirmation = "NeverPrompt"

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
	{
		key = "w",
		mods = "SUPER",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "h",
		mods = "ALT|SUPER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "ALT|SUPER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "LeftArrow",
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "DownArrow",
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "UpArrow",
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "RightArrow",
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "Enter",
		mods = "ALT|SUPER",
		action = act.TogglePaneZoomState,
	},
}

-- and finally, return the configuration to wezterm
return config
