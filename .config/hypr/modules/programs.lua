-- modules/programs.lua

-- CORE APPLICATIONS
terminal = "kitty"
fileManager = "dolphin"
bluetooth = "blueman-manager"
audio = "pavucontrol"
clipboardServer = "copyq --start-server"

-- SHELL INTERFACE
noctalia = "QT_QPA_PLATFORMTHEME=gtk3 qs -c noctalia-shell"
launcher = "qs -c noctalia-shell ipc call launcher toggle"
sessionMenu = "qs -c noctalia-shell ipc call sessionMenu toggle"
cursorCmd = "hyprctl setcursor WinSur-dark-cursors 24"

-- UTILITIES TOOLS
clipboard = "copyq toggle"
nmcli = "GTK_IM_MODULE=wayland nm-connection-editor"

-- SCREENSHOTS
windowScreenshot = "quickshell -c HyprQuickFrame -n"
screenshot = "env HQF_ACTION=temp quickshell -c HyprQuickFrame -n"
