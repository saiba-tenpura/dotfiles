hl.on("hyprland.start", function ()
    -- Applications

    -- Bar
    hl.exec_cmd("waybar")

    -- Wallpaper
    hl.exec_cmd("hyprpaper")

    -- Notifications
    hl.exec_cmd("dunst")

    -- Disk Handling
    hl.exec_cmd("udiskie")

    -- Screen Sharing
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Scripts

    -- Waybar Toggle
    hl.exec_cmd("~/.config/hypr/scripts/auto-hide-waybar.sh")

    -- Lock screen & Screen saver
    hl.exec_cmd("~/.config/sway/lock.sh & ~/.config/sway/idle.sh")
end)
