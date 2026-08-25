-- Default configuration

-- Attempt to load host config
local hostname = io.open("/etc/hostname"):read("*line")
local status, err = pcall(require, "modules.host-config." .. hostname)
if not (status or err:match("module .* not found")) then
  error(err)
end

-- Load general configuration
require("modules.autostart")
require("modules.env")
require("modules.styles")
require("modules.input")
require("modules.keybinds")
require("modules.rules")

