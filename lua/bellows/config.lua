local Config = {}

Config.defaults = {
	settings = {
		foldexpr = "nvim_treesitter#foldexpr()",
		foldtext = [[substitute(getline(v:foldstart),'\t',repeat('\ ',&tabstop),'g').' ... '.trim(getline(v:foldend))]],
		fillchars = { fold = " ", eob = " " },
		method = "expr",
		nestmax = 3,
		minlines = 1,
		level = 99,
		column = "0",
	},
	colors = {
		fold = vim.api.nvim_get_hl(0, { name = "Folded" }),
		column = vim.api.nvim_get_hl(0, { name = "Special" }),
	},
}

Config.options = {}

function Config.setup(options)
	Config.options = vim.tbl_deep_extend("force", {}, Config.defaults, options or {})
end

return Config
