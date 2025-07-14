-- Miro's windows manager
-- https://github.com/miromannino/miro-windows-manager
hs.window.animationDuration = 0 -- disable animations
local hammerKey = { "alt", "ctrl", "cmd", "shift" }
local hyper = { "alt", "ctrl", "cmd" }

local center = function(win)
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local padding = 25
	-- geometry.rect(padding, padding, 1 - (padding * 2), 1 - (padding * 2))
	f.x = max.x + padding
	f.y = max.y + padding
	f.w = max.w - (padding * 2)
	f.h = max.h - (padding * 2)
	win:setFrame(f)
end

local function primaryScreen()
	return hs.screen.allScreens()[1]
end

local function secondaryScreen()
	return hs.screen.allScreens()[2]
end

local function thirdScreen()
	return hs.screen.allScreens()[3]
end

hs.hotkey.bind(hyper, "R", function()
	local targetScreen = thirdScreen()
	local win = hs.window.focusedWindow()
	win:moveToScreen(targetScreen)
end)

hs.hotkey.bind(hyper, "C", function()
	local targetScreen = primaryScreen()
	local win = hs.window.focusedWindow()
	win:moveToScreen(targetScreen)
end)

hs.hotkey.bind(hyper, "S", function()
	local targetScreen = secondaryScreen()
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

hs.hotkey.bind(hyper, "m", maximize_window)
hs.hotkey.bind(hyper, "f", maximize_window_full)
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

-- 1/3 left
hs.hotkey.bind(hyper, "j", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = (max.w / 3) * 2
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

-- 2/3 right
hs.hotkey.bind(hyper, "k", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local a_third = max.w / 3

	f.x = max.x + a_third
	f.y = max.y
	f.w = a_third * 2
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

-- top 40%
hs.hotkey.bind(hyper, "o", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()
	local fourtypercent = max.h * 0.4

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = fourtypercent
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

-- bottom 60%
hs.hotkey.bind(hyper, "u", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	local sixtypercent = max.h * 0.6
	local fourtypercent = max.h * 0.4
	f.x = max.x
	f.y = max.y + fourtypercent
	f.w = max.w
	f.h = sixtypercent
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
	if not (teams == null) then
		hs.eventtap.keyStroke({ "cmd", "shift" }, "m", 0, teams)
	end
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
