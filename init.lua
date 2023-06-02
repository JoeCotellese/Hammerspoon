-- Configuration File for hammerspoon
-- A lot of this was swiped from wincent on GitHub
-- https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.hammerspoon/init.lua

hs.logger.defaultLogLevel = "info"
local log = hs.logger.new('mymodule','debug')

-- global functions
function getFunctionLocation()
  local w = debug.getinfo(3, "S")
  return w.short_src:gsub(".*/", "") .. ":" .. w.linedefined
end

function _log(message)
  local location = getFunctionLocation()
  print(location .. ": " .. message)
end


-- hyper is the global key that triggers Hammerspoon functions.
local hyper = {"ctrl", "alt", "cmd"}


-- this should be the only spoon you need to download and install
-- manually. You can then bootstrap other Spoons using this module
hs.loadSpoon("SpoonInstall")

-- Setup Window arrangement this replaces Moom window movement
-- and is more flexible!
spoon.SpoonInstall.repos.ShiftIt = {
   url = "https://github.com/peterklijn/hammerspoon-shiftit",
   desc = "ShiftIt spoon repository",
   branch = "master",
}

spoon.SpoonInstall:andUse("ShiftIt", { repo = "ShiftIt" })
spoon.ShiftIt:bindHotkeys(
  {
    left = { hyper, 'j' },
    right = { hyper, 'l' },
    up = { hyper, 'i' },
    down = { hyper, ',' },
    upleft = { hyper, 'u' },
    upright = { hyper, 'o' },
    botleft = { hyper, 'n' },
    botright = { hyper, '.' },
    maximum = { hyper, 'm' },
    toggleFullScreen = { hyper, 'f' },
    toggleZoom = { hyper, 'z' },
    center = { hyper, 'k' },
    nextScreen = { hyper, 'left' },
    previousScreen = { hyper, 'right' },
    resizeOut = { hyper, '=' },
    resizeIn = { hyper, '-' }
  }
)
spoon.ShiftIt:setWindowCyclingSizes({ 50, 33, 67 }, { 50 })

-- Arrange Desktop lets you save window arrangements
-- similar to Moom's functionality
-- https://sprak3000.github.io/blog/2021/12/arrange-desktop-hammerspoon/

-- function getSFProSymbol(code)
-- -- code = 0x1003DD -- change to the number you found in the process described above
--   char = hs.styledtext.new(utf8.char(code), { font = { name = "SF Pro", size = 16 } })
--   -- if you can use the symbol as a styled text object, then this is all you need

--   -- if you need it as an image, then also do the following
--   canvas = hs.canvas.new({ x = 0, y = 0, h = 0, w = 0 })
--   canvas:size(canvas:minimumTextSize(char))
--   canvas[#canvas + 1] = {
--       type = "text",
--       text = char
--   }
--   image = canvas:imageFromCanvas()
--   canvas:delete() -- won't auto collect yet
--   return image
-- end

-- iconImage = getSFProSymbol(0x1003dd)

-- spoon.SpoonInstall:andUse("ArrangeDesktop")
-- desktopMenubar = hs.menubar.new()
-- if desktopMenubar then
--   desktopMenubar:setIcon(iconImage)
--     local menuItems = {}
--     menuItems = spoon.ArrangeDesktop:addMenuItems(menuItems)
--     desktopMenubar:setMenu(menuItems)
-- end

-- lock the screen ala Windows NT
hs.hotkey.bind(hyper,"forwarddelete", function()
  _log("startScreensaver")
  hs.caffeinate.lockScreen()
  hs.alert.show("startScreensaver")
end)


-- Defeat paste blocking
hs.hotkey.bind({"cmd", "alt"}, "V", function() 
  hs.eventtap.keyStrokes(hs.pasteboard.getContents()) 
end)

-- hs.urlevent.bind("arrangeOmnifocus"

function arrangeOmnifocusWindows(eventName, params)
  hs.alert.show("arrangeOmnifocus")
  local inbox = hs.window.find("Inbox"):focus()
  inbox.focus()
  spoon.ShiftIt.upleft()
end

hs.hotkey.bind(hyper,"7", arrangeOmnifocusWindows)

spoon.SpoonInstall:andUse("Emojis")
spoon.Emojis:bindHotkeys({
  toggle = { hyper, "e" },
})

function windowFullScreen(appName)
  local app = hs.application.find(appName)
  local win = app:mainWindow()
  win:setFullScreen(true)
end

-- hs.hotkey.bind(hyper, "o", windowFullScreen("OmniFocus"))

-- configure modules
camera = require("camera")
camera.init()


hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', hs.reload):start()
