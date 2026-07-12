-- modules/monitors.lua
-- https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.25,
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@59.94",
    position = "auto",
    scale    = 1,
    mirror   = "eDP-1",
})