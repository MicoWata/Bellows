local Tool = {
	notify = function(object)
		vim.notify(vim.inspect(object))
		vim.cmd("messages")
	end,

	write = function(object)
		vim.fn.writefile({ vim.inspect(object) }, "text.txt")
	end,
}

return Tool
