local Tool = {
	notify = function(object)
		vim.notify(vim.inspect(object))
		vim.cmd("messages")
	end,
}

return Tool
