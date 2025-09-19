-- Miro's windows manager
-- https://github.com/miromannino/miro-windows-manager
hs.window.animationDuration = 0 -- disable animations
local hammerKey = { "alt", "ctrl", "cmd", "shift" }
local hyper = { "alt", "ctrl", "cmd" }

local function builtInScreen()
	return hs.screen("Built%-in")
end

local function secondaryScreen()
	-- search for screen with 1 in the name (at home LG ULTRAFINE (1))
	local s = hs.screen("1")
	if s == nil then
		-- fallback to second screen if LG is not connected
		s = hs.screen.allScreens()[2]
	end
	return s
end

local function thirdScreen()
	local s = hs.screen("2")
	if s == nil then
		-- fallback to second screen if LG is not connected
		s = hs.screen.allScreens()[3]
	end
	return s
end

-- Move window to right screen
hs.hotkey.bind(hyper, "R", function()
	local targetScreen = thirdScreen()
	local win = hs.window.focusedWindow()
	win:moveToScreen(targetScreen)
end)

-- Move window to center screen
hs.hotkey.bind(hyper, "C", function()
	local targetScreen = secondaryScreen()
	local win = hs.window.focusedWindow()
	win:moveToScreen(targetScreen)
end)

-- Move window to small (laptop) screen
hs.hotkey.bind(hyper, "S", function()
	local targetScreen = builtInScreen()
	local win = hs.window.focusedWindow()
	win:moveToScreen(targetScreen)
end)

-- full screen with padding
local maximize_window = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	local padding = 50

	win:setFrame(max)

	-- add some padding on the left for stage manager
	f.x = max.x + padding
	f.y = max.y + padding
	f.w = max.w - (padding * 2)
	f.h = max.h - (padding * 2)
	win:setFrame(f)
end

-- full screen
local maximize_window_full = function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	win:setFrame(max)

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h
	win:setFrame(f)
end

-- scaled down window for ultrawide display
hs.hotkey.bind(hyper, "n", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	local padding_width = 500
	local column_width = max.w / 12

	win:setFrame(max)

	f.x = max.x + (2 * column_width)
	f.y = max.y
	f.w = max.w - (2 * 2 * column_width)
	f.h = max.h
	win:setFrame(f)
end)

hs.hotkey.bind(hyper, "m", maximize_window)
hs.hotkey.bind(hyper, "f", maximize_window_full)

-- window
hs.hotkey.bind(hyper, "w", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	local padding = 240

	win:setFrame(max)

	f.x = max.x + padding
	f.y = max.y + padding
	f.w = max.w - (padding * 2)
	f.h = max.h - (padding * 2)
	win:setFrame(f)
end)

-- 1/2 left
hs.hotkey.bind(hyper, "h", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)

-- 1/2 right
hs.hotkey.bind(hyper, "l", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local half = max.w / 2

	f.x = max.x + half
	f.y = max.y
	f.w = half
	f.h = max.h
	win:setFrame(f)
end)

-- 1/3 left
hs.hotkey.bind(hyper, "q", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local thirdWidth = (max.w / 3)

	f.x = max.x
	f.y = max.y
	f.w = thirdWidth
	f.h = max.h
	win:setFrame(f)
end)

-- 1/3 center
hs.hotkey.bind(hyper, "a", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local thirdWidth = (max.w / 3)

	f.x = max.x + thirdWidth
	f.y = max.y
	f.w = thirdWidth
	f.h = max.h
	win:setFrame(f)
end)

-- 1/3 right
hs.hotkey.bind(hyper, "z", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local thirdWidth = (max.w / 3)

	f.x = max.x + thirdWidth * 2
	f.y = max.y
	f.w = thirdWidth * 2
	f.h = max.h
	win:setFrame(f)
end)

-- top half
hs.hotkey.bind(hyper, "t", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local half = max.h / 2

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = half
	win:setFrame(f)
end)

-- bottom half
hs.hotkey.bind(hyper, "b", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local half = max.h / 2

	f.x = max.x
	f.y = max.y + half
	f.w = max.w
	f.h = half
	win:setFrame(f)
end)

-- top 1/3 (vertical)
hs.hotkey.bind(hyper, "p", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local t = max.h / 3

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = t
	win:setFrame(f)
end)

-- middle 1/3 (vertical)
hs.hotkey.bind(hyper, ";", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local t = max.h / 3

	f.x = max.x
	f.y = max.y + t
	f.w = max.w
	f.h = t
	win:setFrame(f)
end)

-- bottom 1/3 (vertical)
hs.hotkey.bind(hyper, "/", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local t = max.h / 3

	f.x = max.x
	f.y = max.y + t * 2
	f.w = max.w
	f.h = t
	win:setFrame(f)
end)

-- App switching

local function bindAppToKey(key, app)
	hs.hotkey.bind(hammerKey, key, function()
		hs.application.open(app)
	end)
end

bindAppToKey("B", "Arc") -- browser
bindAppToKey("T", "WezTerm") -- terminal
bindAppToKey("S", "Slack")
bindAppToKey("E", "IntelliJ IDEA") -- editor
bindAppToKey("W", "WhatsApp")
bindAppToKey("O", "Microsoft Outlook")
bindAppToKey("M", "Spotify")

-- Toggle Teams Mute
local toggleMute = function()
	local teams = hs.application.find("com.microsoft.teams2")
	if teams == null then
		-- teams not running
		return
	end
	hs.eventtap.keyStroke({ "cmd", "shift" }, "m", 0, teams)
	-- local currentFocus = hs.window.focusedWindow()
	-- local teamsMainWindow = teams:mainWindow()
	-- if not (teamsMainWindow == null) then
	-- 	hs.eventtap.keyStroke({ "cmd", "shift" }, "m", 0, teams)
	-- 	-- restore initial main window
	-- 	-- currentFocus:becomeMain()
	-- end
end
hs.hotkey.bind({}, "f12", toggleMute)

-- Toggle Teams Camera
local toggleCamera = function()
	local teams = hs.application.find("com.microsoft.teams2")
	if not (teams == null) then
		hs.eventtap.keyStroke({ "cmd", "shift" }, "o", 0, teams)
	end
end
hs.hotkey.bind({}, "f11", toggleCamera)
