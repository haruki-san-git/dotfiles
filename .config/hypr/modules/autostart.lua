-- modules/autostart.lua
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	-- DBUS ENVIRONMENT
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	-- SYSTEM SERVICES
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("kbuildsycoca6 --noincremental")
	hl.exec_cmd("wl-clip-persist --clipboard regular")
	-- hl.exec_cmd("awww-daemon")

	if cursorCmd then
		hl.exec_cmd(cursorCmd)
	end

	-- CLIPBOARD SHELL
	if clipboardServer then
		hl.exec_cmd(clipboardServer)
	end

	-- Esecuzione variabile importata da programs.lua
	if noctalia then
		hl.exec_cmd(noctalia)
	end
end)
