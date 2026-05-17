hl.window_rule({
    -- Fix some dragging issues with XWayland
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


hl.window_rule({
    name  = "blender-float",
    match = {
        class = "^(Blender)$",
        title = "^(Blender Preferences|Blender Render)$",
    },
    float = true,
})

hl.window_rule({
    name  = "steam-float",
    match = {
        class = "^(Steam)$",
        title = "^(Friends|Steam - News)$",
    },
    float = true,
})

