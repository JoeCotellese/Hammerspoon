-- swiped from the hammer spoon config here:
-- https://github.com/derekwyatt/dotfiles
-------------------------------------------------------------------
-- Launcher
--
-- This is the awesome. The other stuff is all cool, but this is the
-- thing I love the most because it reduces the amount of time I
-- spend with the mouse, and is far more deterministic than trying
-- to use cmd+tab.
--
-- The idea here is to have a MODE-BASED app launching and app
-- switching system. Traditional Mac philosophy (and Emacs :D)
-- would have us contort our hands into crazy combinations of keys
-- to manipulate the state of the machine, which is a serious pain
-- in the ass. Using Hammerspoon we can avoid that.
--
-- * ctrl+space gets us into "launch mode"
-- * In "launch mode" the keyboard changes so that each key can now
--   have a new meaning. For example, the 'v' key is now responsible
--   for either launching or switching to VimR
-- * You can then map whatever you like to whatever function you'd
--   like to invoke.
--
-- It's just a big pile of awesome.
-------------------------------------------------------------------

-- We need to store the reference to the alert window
appLauncherAlertWindow = nil

-- This is the key mode handle
launchMode = hs.hotkey.modal.new({}, nil, '')

-- Leaves the launch mode, returning the keyboard to its normal
-- state, and closes the alert window, if it's showing
function leaveMode()
  if appLauncherAlertWindow ~= nil then
    hs.alert.closeSpecific(appLauncherAlertWindow, 0)
    appLauncherAlertWindow = nil
  end
  launchMode:exit()
end

-- So simple, so awesome.
function switchToApp(app)
  hs.application.open(app)
  leaveMode()
end

-- Enters launch mode. The bulk of this is geared toward
-- showing a big ugly window that can't be ignored; the
-- keyboard is now in launch mode.
hs.hotkey.bind({ 'ctrl' }, 'space', function()
  launchMode:enter()
  appLauncherAlertWindow = hs.alert.show('App Launcher Mode', {
    strokeColor = hs.drawing.color.x11.orangered,
    fillColor = hs.drawing.color.x11.cyan,
    textColor = hs.drawing.color.x11.black,
    strokeWidth = 5,
    radius = 5,
    textSize = 36,
    fadeInDuration = 0,
    atScreenEdge = 20,
  }, 'infinite')
end)

-- When in launch mode, hitting ctrl+space again leaves it
launchMode:bind({ 'ctrl' }, 'space', function() leaveMode() end)

-- Mapped keys
launchMode:bind({}, 'd',  function() leaveMode(); deepwork() end)
launchMode:bind({"shift"}, 'd',  function() leaveMode(); interrogateDeepWorkTimer() end)
launchMode:bind({}, 'g',  function() switchToApp('OmniGraffle.app') end)
launchMode:bind({}, 'i',  function() switchToApp('Signal.app') end)
launchMode:bind({}, 'm',  function() switchToApp('Mail.app') end)
launchMode:bind({}, 'o',  function() switchToApp('Omnifocus.app') end)
launchMode:bind({}, 's',  function() switchToApp('Slack.app') end)
launchMode:bind({}, 't',  function() switchToApp('iTerm.app') end)

--- browsers
-- launchMode:bind({'b'}, 'c',  function() switchToApp('Choosy.app') end)
-- launchMode:bind({'b'}, 'g',  function() switchToApp('Chrome.app') end)
-- launchMode:bind({'b'}, 's',  function() switchToApp('Safari.app') end)
launchMode:bind({}, 'v',  function() switchToApp('Vivaldi.app') end)

launchMode:bind({}, 'z',  function() switchToApp('zoom.us.app') end)
launchMode:bind({}, '`',  function() hs.reload(); leaveMode() end)

-- Unmapped keys
launchMode:bind({}, 'a',  function() leaveMode() end)
launchMode:bind({}, 'c',  function() leaveMode() end)


launchMode:bind({}, 'e',  function() leaveMode() end)
launchMode:bind({}, 'f',  function() leaveMode() end)


launchMode:bind({}, 'h',  function() leaveMode() end)

launchMode:bind({}, 'j',  function() leaveMode() end)
launchMode:bind({}, 'k',  function() leaveMode() end)
launchMode:bind({}, 'l',  function() leaveMode() end)



launchMode:bind({}, 'n',  function() leaveMode() end)

launchMode:bind({}, 'p',  function() leaveMode() end)
launchMode:bind({}, 'q',  function() leaveMode() end)
launchMode:bind({}, 'r',  function() leaveMode() end)



launchMode:bind({}, 'u',  function() leaveMode() end)

launchMode:bind({}, 'w',  function() leaveMode() end)
launchMode:bind({}, 'x',  function() leaveMode() end)
launchMode:bind({}, 'y',  function() leaveMode() end)

launchMode:bind({}, '1',  function() leaveMode() end)
launchMode:bind({}, '2',  function() leaveMode() end)
launchMode:bind({}, '3',  function() leaveMode() end)
launchMode:bind({}, '4',  function() leaveMode() end)
launchMode:bind({}, '5',  function() leaveMode() end)
launchMode:bind({}, '6',  function() leaveMode() end)
launchMode:bind({}, '7',  function() leaveMode() end)
launchMode:bind({}, '8',  function() leaveMode() end)
launchMode:bind({}, '9',  function() leaveMode() end)
launchMode:bind({}, '0',  function() leaveMode() end)
launchMode:bind({}, '-',  function() leaveMode() end)
launchMode:bind({}, '=',  function() leaveMode() end)
launchMode:bind({}, '[',  function() leaveMode() end)
launchMode:bind({}, ']',  function() leaveMode() end)
launchMode:bind({}, '\\', function() leaveMode() end)
launchMode:bind({}, ';',  function() leaveMode() end)
launchMode:bind({}, "'",  function() leaveMode() end)
launchMode:bind({}, ',',  function() leaveMode() end)
launchMode:bind({}, '.',  function() leaveMode() end)
launchMode:bind({}, '/',  function() leaveMode() end)