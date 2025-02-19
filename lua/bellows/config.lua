local Config = {}

Config.defaults = {
	keys = {
		next = "<S-End>",
		previous = "<S-Home>",
		fold = "<S-Right>",
		cascade = "<S-Down>",
		close = "<S-Up>",
		others = "<S-Left>",
	},
	options = {
		middle = " ... ",
		foldtext = "v:lua.require'bellows.fold'.paint()",
	},
}

Config.options = {}

return Config
