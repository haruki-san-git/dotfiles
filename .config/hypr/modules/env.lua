-- modules/env.lua
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- CURSOR CONFLICTS PREVENTION
hl.env("XCURSOR_THEME", "WinSur-dark-cursors")
hl.env("XCURSOR_SIZE", "24")

-- SSH AUTHENTICATION
hl.env("SSH_AUTH_SOCK", (os.getenv("XDG_RUNTIME_DIR") or "") .. "/gcr/ssh")

-- QUANTUM THEME WAYLAND
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland")

-- PORTALS XDG
hl.env("GTK_USE_PORTAL", "1")