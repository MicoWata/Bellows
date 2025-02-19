local Config = require("bellows.config")
local Fold = require("bellows.fold")

local Setup = {}

function Setup.config(options)
	Config.options = vim.tbl_deep_extend("force", {}, Config.defaults, options or {})
end

function Setup.options()
	-- local options = config.options.settings
	--
	-- vim.opt.foldtext = options.foldtext
	vim.opt.foldtext = "v:lua.require'bellows.fold'.paint()"
end

function Setup.keymaps()
	local keys = Config.options.keys

	local keymaps = {
		{ mode = "n", input = keys.next, output = "zjzz", desc = "Jump to next fold" },
		{ mode = "n", input = keys.previous, output = "zkzz", desc = "Jump to last fold" },
		{
			mode = "n",
			input = keys.others,
			output = function()
				vim.cmd("normal! zM")
				vim.cmd("normal! za")
				Fold.gutter()
			end,
			desc = "Close all other folds",
		},
		{
			mode = "n",
			input = keys.fold,
			output = function()
				vim.cmd("normal! za")
				Fold.gutter()
			end,
			desc = "Toggle fold",
		},
		{
			mode = "n",
			input = keys.close,
			output = function()
				vim.cmd("normal! zM")
				Fold.gutter()
			end,
			desc = "Close all folds",
		},
		{
			mode = "n",
			input = keys.cascade,
			output = function()
				vim.cmd("normal! zA")
				Fold.gutter()
			end,
			desc = "Toggle folds cascade",
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

function Setup.autocmds()
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

	vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "TextChanged", "TextChangedI", "BufWritePost" }, {
		group = augroup,
		callback = function()
			Fold.gutter()
		end,
	})
end

return Setup
