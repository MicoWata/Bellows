local Bellows = {}

local setup = require("bellows.setup")

function Bellows.setup(options)
	-- setup.config(options)
	setup.options()
	setup.keymaps()
	setup.autocmds()
end

return Bellows
