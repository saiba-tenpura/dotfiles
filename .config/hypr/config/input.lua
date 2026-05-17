hl.config({
    input = {
        kb_layout  = "de",
        kb_variant = "",
        kb_model   = "pc105",
        kb_options = "terminate:ctrl_alt_bksp",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name       = "geist-totem",
    kb_layout  = "us",
    kb_variant = "altgr-intl",
    kb_options = "nodeadkeys",
})

