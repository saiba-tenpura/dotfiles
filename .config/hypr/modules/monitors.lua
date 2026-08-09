-- Laptop
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- Desktop
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080",
    position = "0x0",
    scale    = 1,
})

hl.monitor({
    output   = "DP-1",
    mode     = "3840x2160@160",
    position = "auto",
    scale    = 2,
    vrr      = 1,
})

hl.monitor({
    output   = "DP-2",
    mode     = "3840x2160@144",
    position = "auto",
    scale    = 2,
    vrr      = 1,
})
