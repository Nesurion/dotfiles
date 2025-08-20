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
		theme_overrides = {
			window_mode = {
				a = { fg = "#181825", bg = "#cba6f7" },
				b = { fg = "#cba6f7", bg = "#313244" },
				c = { fg = "#cdd6f4", bg = "#181825" },
			},
		},
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
config.color_scheme = "Tokyo Night Moon"

config.inactive_pane_hsb = {
	saturation = 0.6,
	brightness = 0.5,
}

-- Font configuration
config.font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font", "FiraCode Nerd Font" })
config.font_size = 16.0

-- Window configuration
-- config.enable_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
-- config.window_frame = {
-- 	font_size = 13.0,
-- 	active_titlebar_bg = "#333333",
-- }

config.audible_bell = "Disabled"

config.scrollback_lines = 10000

config.window_close_confirmation = "NeverPrompt"

-- Worksapce Switcher
workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Attribute = { Italic = false } },
		{ Foreground = { AnsiColor = "Fuchsia" } },
		-- { Background = { Color = "black" } },
		{ Text = "󱂬 " .. label },
	})
end
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"
workspace_switcher.switch_workspace({ extra_args = " | rg -Fxf ~/dev" })

local function is_neovim(pane)
	local process_name = pane:get_foreground_process_name()
	return process_name and (process_name:match("nvim") or process_name:match("n"))
end

local function is_lazygit(pane)
	local process_name = pane:get_foreground_process_name()
	return process_name and (process_name:match("lazygit") or process_name:match("lg"))
end

-- Keybindings
config.leader = { key = " ", mods = "SHIFT", timeout_milliseconds = 1000 }
config.keys = {
	-- Enter window_mode
	{ key = "w", mods = "LEADER", action = act.ActivateKeyTable({ name = "window_mode", one_shot = false }) },
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

	-- Search with CMD-f
	{
		key = "f",
		mods = "SUPER",
		action = act.Search({ CaseInSensitiveString = "" }),
	},

	-- Copy mode
	{
		key = "c",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},

	-- -- Quick select mode
	{
		key = "q",
		mods = "LEADER",
		action = act.QuickSelect,
	},

	-- Close current pane cmd-w (with confirmation for nvim)
	{
		key = "w",
		mods = "SUPER",
		-- action = act.CloseCurrentPane({ confirm = false }),
		action = wezterm.action_callback(function(window, pane, _)
			if is_neovim(pane) then
				window:perform_action(act.CloseCurrentPane({ confirm = true }), pane)
			else
				window:perform_action(act.CloseCurrentPane({ confirm = false }), pane)
			end
		end),
	},
	-- Close current pane alt-d (with confirmation for nvim)
	-- {
	-- 	key = "d",
	-- 	mods = "ALT",
	-- 	-- action = act.CloseCurrentPane({ confirm = false }),
	-- 	action = wezterm.action_callback(function(window, pane, _)
	-- 		if is_neovim(pane) then
	-- 			window:perform_action(act.CloseCurrentPane({ confirm = true }), pane)
	-- 		else
	-- 			window:perform_action(act.CloseCurrentPane({ confirm = false }), pane)
	-- 		end
	-- 	end),
	-- },

	-- Split
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

	-- Scroll
	-- Up
	{ key = "PageUp", action = act.ScrollByPage(-0.25) },
	-- {
	-- 	key = "u",
	-- 	mods = "CTRL",
	-- 	action = act.ScrollByPage(-0.25),
	-- },
	-- -- Down
	{ key = "PageDown", action = act.ScrollByPage(0.25) },
	-- {
	-- 	key = "d",
	-- 	mods = "CTRL",
	-- 	action = act.ScrollByPage(0.25),
	-- },

	-- move pane focus
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

	-- pane size
	-- {
	-- 	key = "h",
	-- 	mods = "SHIFT|CMD",
	-- 	action = act.AdjustPaneSize({ "Left", 5 }),
	-- },
	-- {
	-- 	key = "j",
	-- 	mods = "SHIFT|CMD",
	-- 	action = act.AdjustPaneSize({ "Down", 5 }),
	-- },
	-- {
	-- 	key = "k",
	-- 	mods = "SHIFT|CMD",
	-- 	action = act.AdjustPaneSize({ "Up", 5 }),
	-- },
	-- {
	-- 	key = "l",
	-- 	mods = "SHIFT|CMD",
	-- 	action = act.AdjustPaneSize({ "Right", 5 }),
	-- },

	-- Zoom
	{
		key = "Enter",
		mods = "ALT",
		action = act.TogglePaneZoomState,
	},
	{
		key = "+",
		mods = "CMD",
		action = act.IncreaseFontSize,
	},
	{
		key = "-",
		mods = "CMD",
		action = act.DecreaseFontSize,
	},

	-- Prompt for a name to use for a new workspace and switch to it.
	{
		key = "t",
		mods = "CTRL|ALT|SHIFT",
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
		key = "t",
		mods = "CTRL|ALT",
		action = workspace_switcher.switch_to_prev_workspace(),
	},
	{
		key = "t",
		mods = "ALT",
		action = workspace_switcher.switch_workspace(),
	},
}

config.key_tables = {
	["window_mode"] = {
		{
			key = "h",
			action = act.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "j",
			action = act.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "k",
			action = act.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "l",
			action = act.AdjustPaneSize({ "Right", 5 }),
		},
		{ key = "Escape", action = "PopKeyTable" }, -- Exit mode on Escape
	},
}
-- and finally, return the configuration to wezterm
return config
