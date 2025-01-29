-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Tokyo Night",
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace" },
		tabline_c = {},
		tab_active = {
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = {},
		tabline_x = {},
		tabline_y = {},
		tabline_z = {},
	},
	extensions = {},
})

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Tabline requires that some options are applied to the WezTerm Config struct.
-- For example the retro tab-bar must be enabled.
-- Tabline provides a function to apply some recommended options to the config. If you already set these options in your wezterm.lua you do not need this function.
-- This needs to be called after wezterm.setup().
tabline.apply_to_config(config)
workspace_switcher.apply_to_config(config)

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
-- config.enable_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
-- config.window_frame = {
-- 	font_size = 13.0,
-- 	active_titlebar_bg = "#333333",
-- }

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
	-- {
	-- 	key = "LeftArrow",
	-- 	mods = "ALT|SUPER",
	-- 	action = act.ActivatePaneDirection("Left"),
	-- },
	-- {
	-- 	key = "DownArrow",
	-- 	mods = "ALT|SUPER",
	-- 	action = act.ActivatePaneDirection("Down"),
	-- },
	-- {
	-- 	key = "UpArrow",
	-- 	mods = "ALT|SUPER",
	-- 	action = act.ActivatePaneDirection("Up"),
	-- },
	-- {
	-- 	key = "RightArrow",
	-- 	mods = "ALT|SUPER",
	-- 	action = act.ActivatePaneDirection("Right"),
	-- },
	-- {
	-- 	key = "Enter",
	-- 	mods = "ALT|SUPER",
	-- 	action = act.TogglePaneZoomState,
	-- },
	-- Vim style pane navigation
	{
		key = "h",
		mods = "ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "ALT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "Enter",
		mods = "ALT",
		action = act.TogglePaneZoomState,
	},
	-- Prompt for a name to use for a new workspace and switch to it.
	{
		key = "w",
		mods = "CTRL|ALT",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		key = "w",
		mods = "ALT",
		action = workspace_switcher.switch_workspace(),
	},
}

-- and finally, return the configuration to wezterm
return config
