-- Default configuration

-- Attempt to load host config
local hostname = io.open("/etc/hostname"):read("*line")
local status, err = pcall(require, "config.host-config." .. hostname)
if not (status or err:match("module .* not found")) then
  error(err)
end

-- Load general configuration
require("config.autostart")
require("config.env")
require("config.styles")
require("config.input")
require("config.keybinds")
require("config.rules")

