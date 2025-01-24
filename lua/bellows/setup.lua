local config = require("bellows.config")

local setup = {}

function setup.options()
	local options = config.options.settings

	vim.opt.foldmethod = options.method
	vim.opt.foldexpr = options.foldexpr
	vim.opt.foldtext = options.foldtext
	vim.opt.fillchars = { fold = " ", eob = " " }
	vim.opt.foldnestmax = options.nestmax
	vim.opt.foldminlines = options.minlines
	vim.opt.foldlevel = options.level
	vim.opt.foldenable = true
	vim.opt.mouse = "a"
	vim.opt.foldcolumn = options.column
end

function setup.highlights()
	local colors = config.options.colors

	vim.api.nvim_set_hl(0, "Folded", {
		fg = colors.fold.fg,
		bg = "NONE",
	})

	vim.api.nvim_set_hl(0, "FoldColumn", {
		fg = colors.column.fg,
		bg = "NONE",
	})
end

function setup.keymaps()
	local keymaps = {
		{ mode = "n", lhs = "zj", rhs = "zjzz", desc = "Move to next fold" },
		{ mode = "n", lhs = "zk", rhs = "zkzz", desc = "Move to last fold" },
		{ mode = "n", lhs = "z<Down>", rhs = "zA", desc = "Toggle fold" },
		{ mode = "n", lhs = "z<Right>", rhs = "za", desc = "Toggle fold" },
		{ mode = "n", lhs = "z<Up>", rhs = "zM", desc = "Close all folds" },
		{
			mode = "n",
			lhs = "z<Left>",
			rhs = function()
				vim.cmd("normal! zM")
				vim.cmd("normal! za")
			end,
			desc = "Close all other folds",
		},
	}

	for _, map in ipairs(keymaps) do
		vim.keymap.set(map.mode, map.lhs, map.rhs, {
			noremap = true,
			silent = true,
			desc = map.desc,
		})
	end
end

function setup.autocmds()
	local augroup = vim.api.nvim_create_augroup("BellowsSaveFold", { clear = true })

	vim.api.nvim_create_autocmd("BufWinLeave", {
		group = augroup,
		pattern = "*.*",
		command = "mkview",
	})

	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = augroup,
		pattern = "*.*",
		command = "silent! loadview",
	})
end

return setup
