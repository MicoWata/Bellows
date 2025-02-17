local Config = require("bellows.config")
--
local setup = {}

function setup.config(options)
	Config.options = vim.tbl_deep_extend("force", {}, Config.defaults, options or {})
end

function setup.options()
	-- local options = config.options.settings
	--
	-- vim.opt.foldtext = options.foldtext
	vim.opt.foldtext = "v:lua.require'bellows.fold'.paint()"
end

function setup.keymaps()
	local keymaps = {
		{ mode = "n", input = "<S-End>", output = "zjzz", desc = "Jump to next fold" },
		{ mode = "n", input = "<S-Home>", output = "zkzz", desc = "Jump to last fold" },
		{ mode = "n", input = "<S-Down>", output = "zA", desc = "Toggle folds cascade" },
		{ mode = "n", input = "<S-Right>", output = "za", desc = "Toggle fold" },
		{ mode = "n", input = "<S-Up>", output = "zM", desc = "Close all folds" },
		{
			mode = "n",
			input = "<S-Left>",
			output = function()
				vim.cmd("normal! zM")
				vim.cmd("normal! za")
			end,
			desc = "Close all other folds",
		},
	}

	for _, map in ipairs(keymaps) do
		vim.keymap.set(map.mode, map.input, map.output, {
			noremap = true,
			silent = true,
			desc = map.desc,
		})
	end
end

function setup.autocmds()
	local augroup = vim.api.nvim_create_augroup("BellowsSaveFold", { clear = true })

	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = augroup,
		pattern = "*.*",
		command = "silent! loadview",
	})

	vim.api.nvim_create_autocmd("BufWinLeave", {
		group = augroup,
		pattern = "*.*",
		command = "silent! mkview",
	})
end

return setup
