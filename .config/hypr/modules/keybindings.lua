-- modules/keybindings.lua

local mainMod = "SUPER"

-- APPLICATIONS SYSTEM
hl.bind(mainMod .. " + Q",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd(bluetooth))
hl.bind(mainMod .. " + N",      hl.dsp.exec_cmd(nmcli))
hl.bind(mainMod .. " + V",      hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd(sessionMenu))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("smile"))

-- WINDOW CLOSE
hl.bind(mainMod .. " + C", hl.dsp.window.close())

-- POWER MENU SHUTDOWN
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- WINDOW LAYOUT FULLSCREEN
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + T", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- FLOATING WINDOWS
hl.bind(mainMod .. " + D", function()
    -- 1. Toggle dello stato floating
    hl.dispatch(hl.dsp.window.float())
    
    -- 2. Resize e Center usando i dispatcher nativi (senza passare da exec_cmd)
    hl.dispatch(hl.dsp.window.resize({ x = 1000, y = 600 }))
    hl.dispatch(hl.dsp.window.center())
end)

-- MOVE FOCUS
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- WINDOW RESIZE
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })

-- WORKSPACES
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- SPECIAL WORKSPACE
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:magic" }))

-- MOUSE ACTIONS
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })

-- WINDOW GRID ALLOCATION
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.move({ direction = "left" }),   { repeating = true })
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.move({ direction = "right" }),  { repeating = true })
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.move({ direction = "up" }),     { repeating = true })
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.move({ direction = "down" }),   { repeating = true })

-- SCREENSHOTS
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(windowScreenshot))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot))

-- MULTIMEDIA KEYS
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                    { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })