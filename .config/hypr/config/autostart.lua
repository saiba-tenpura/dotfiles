hl.on("hyprland.start", function ()
  -- Lock screen & screen saver
  hl.exec_cmd("~/.config/sway/lock.sh & ~/.config/sway/idle.sh")

  -- Bar & wallpaper
  hl.exec_cmd("waybar & hyprpaper")

  -- Utilities (notifications & disk mounting)
  hl.exec_cmd("dunst")
  hl.exec_cmd("udiskie")

  -- Clipboard history
  hl.exec_cmd("wl-paste -p -t text --watch clipman store -P --histpath='~/.local/share/clipman-primary.json'")
end)
