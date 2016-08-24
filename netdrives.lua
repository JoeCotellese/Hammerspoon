function connectMedia(params)
  if not hs.fs.chdir('/Volumes/Media') then
    hs.alert.show("disconnected")
    hs.applescript.applescript([[
        tell application "Finder"
            try
                mount volume "afp://jcotellese@BigNas%28AFP%29._afpovertcp._tcp.local/Media"
            end try
        end tell
    ]])

  end
end

mediaFolderWatcher = hs.pathwatcher.new('/Volumes/Media',connectMedia)
mediaFolderWatcher:start()
