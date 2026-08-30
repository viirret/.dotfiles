local modifier = "SUPER"
local terminal = "foot"
local browser = "firefox"
local menu = "wofi --show drun"

hl.env("XCURSOR_SIZE", "24")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        layout = "dwindle",
    },
    decoration = {
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        rounding = 10,
        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            ignore_opacity = false,
        },
    },
    input = {
        kb_layout = "fi",
        follow_mouse = 1,
    },
})

hl.window_rule({
    match = { class = "^(" .. terminal .. ")$" },
    opacity = "0.9 0.8",
})

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -c '#000000' -m solid_color")
end)

hl.bind(modifier .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(modifier .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(modifier .. " + D", hl.dsp.exec_cmd(menu))

hl.bind(modifier .. " + Q", hl.dsp.window.close())
hl.bind(modifier .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Workspace bindings
for i = 1, 9 do
    hl.bind(modifier .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(modifier .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(modifier .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(modifier .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Vim keys
hl.bind(modifier .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(modifier .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(modifier .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(modifier .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(modifier .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(modifier .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(modifier .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(modifier .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Screenshot
hl.bind(
    modifier .. " + Z",
    hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Images/screenshot/screenshot-$(date +\'%Y-%m-%d_%H-%M-%S\').png')
)
