-- This module will watch for camera activity and take specific actions
-- based on the camera starting and stopping.
-- code based on https://github.com/mr-mustash/dotfiles/blob/902e33359d11ec82fbe2f4e138d7bf9e6102b0fa/tilde/.hammerspoon/system/videoCalls.lua#L61
camera = {}

local function cameraInUse()
    hs.shortcuts.run("Meeting Start")
end

local function cameraStopped()
    print ("running Meeting Stop")
    hs.shortcuts.run("Meeting Stop")
end

local function cameraPropertyCallback(camera, property)
    -- TODO: Think about logging which application has started to use the camera with something like:
    -- https://www.howtogeek.com/289352/how-to-tell-which-application-is-using-your-macs-webcam/
    _log("Camera " .. camera:name() .. "in use status changed.")

    -- Weirdly, "gone" is used as the property  if the camera's use changes: https://www.hammerspoon.org/docs/hs.camera.html#setPropertyWatcherCallback
    if property == "gone" then
        if camera:isInUse() then
            _log("Camera " .. camera:name() .. " is in use.")
            cameraInUse()
        else
            _log("Camera " .. camera:name() .. " is no longer in use.")
            cameraStopped()
        end
    end
end

local function cameraWatcherCallback(camera, status)
    _log("New camera detected: " .. camera:name())
    print(status)
    if status == "Added" then
        camera:setPropertyWatcherCallback(cameraPropertyCallback)
        camera:startPropertyWatcher()
    end
end

local function addCameraOnInit()
    for _, camera in ipairs(hs.camera.allCameras()) do
        _log("New camera detected: " .. camera:name())
        camera:setPropertyWatcherCallback(cameraPropertyCallback)
        camera:startPropertyWatcher()
    end
end

function camera.init()
    hs.camera.setWatcherCallback(cameraWatcherCallback)
    hs.camera.startWatcher()

    addCameraOnInit()
end

return camera