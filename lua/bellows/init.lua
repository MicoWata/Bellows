local Bellows = {}

local config = require("bellows.config")
local setup = require("bellows.setup")

function Bellows.setup(options)
	config.setup(options)

	setup.options()
	setup.highlights()
	setup.keymaps()
	setup.autocmds()
end

return Bellows
