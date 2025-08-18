-- Hammerspoon configuration for application launching

local function launchOrFocus(appName)
    hs.application.launchOrFocus(appName)
end

-- Mac Option as leader key
hs.hotkey.bind({"alt"}, "1", function()
    launchOrFocus("Firefox")
end)

hs.hotkey.bind({"alt"}, "2", function()
    launchOrFocus("Slack")
end)

hs.hotkey.bind({"alt"}, "3", function()
    launchOrFocus("Visual Studio Code")
end)

hs.hotkey.bind({"alt"}, "4", function()
    launchOrFocus("Terminal")
end)

hs.hotkey.bind({"alt"}, "5", function()
    launchOrFocus("Microsoft Teams")
end)

hs.notify.new({title="Hammerspoon", informativeText="Configuration loaded"}):send()

-- hot reload
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
