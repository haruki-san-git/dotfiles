-- modules/window_rules.lua
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- BLUEMAN FLOATING WINDOW
hl.window_rule({
    name  = "blueman-floating",
    match = { class = "blueman-manager" },
    float  = true,
    size   = "500 300",
    center = true,
})

-- AUDIO GUI PAVUCONTROL
hl.window_rule({
    name  = "audio-gui",
    match = { class = "org.pulseaudio.pavucontrol" },
    float  = true,
    size   = "500 300",
    center = true,
})

-- COPYQ CLIPBOARD
hl.window_rule({
    name  = "copyq",
    match = { class = "com.github.hluk.copyq" },
    float  = true,
    size   = "500 300",
    center = true,
    workspace = "current",
})

-- EMOJI SMILE GUI
hl.window_rule({
    name  = "emoji-gui",
    match = { class = "it.mijorus.smile" },
    float  = true,
    size   = "500 300",
    center = true,
})

-- NETWORK MANAGER CONNECTION
hl.window_rule({
    name  = "network-manager",
    match = { class = "nm-connection-editor" },
    float  = true,
    size   = "500 300",
    center = true,
})

-- ARCHIVER ZIP EXTRACT
hl.window_rule({
    name  = "7zip-xarchiver",
    match = { class = "xarchiver" },
    float  = true,
    size   = "800 550",
    center = true,
})

-- IMAGE VIEWER LOUPE
hl.window_rule({
    name  = "image-viewer",
    match = { class = "org.gnome.Loupe" },
    float  = true,
    size   = "900 600",
    center = true,
})

-- SUPPRESS MAXIMIZE EVENTS
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- XWAYLAND DRAG FIXES
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- HYPRLAND RUN POSITION
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})