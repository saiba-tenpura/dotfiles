require('config/vars')

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + X", hl.dsp.exec_cmd("~/.config/sway/lock.sh"))
hl.bind(mod .. " + ESCAPE", hl.dsp.exec_cmd("wlogout -b 4 -T 250 -B 250"))
hl.bind(mod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + S", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mod .. " + V", hl.dsp.exec_cmd("clipman pick --histpath='~/.local/share/clipman-primary.json' -t wofi"))

-- Move focus with mod + vim keys
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move focus with mod + arrow keys
hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move focus with mod + vim keys
hl.bind(mod .. " + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.window.move({ direction = "down" }))

-- Move focus with mod + arrow keys
hl.bind(mod .. " + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mod + [0-9]
-- Move active window to a workspace with mod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Example special workspace (scratchpad)
hl.bind(mod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mod + scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

