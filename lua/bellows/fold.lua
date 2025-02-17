local Fold = {
	gutter = function()
		local namespace = vim.api.nvim_create_namespace("line_numbers")
		local last_line = vim.api.nvim_buf_line_count(0)

		for row = 1, last_line do
			if vim.fn.foldclosed(row) == row then
				vim.api.nvim_buf_set_extmark(0, namespace, row - 1, 0, {
					number_hl_group = "Folded",
				})
			else
				if row > 2 then
					vim.api.nvim_buf_set_extmark(0, namespace, row - 1, 0, {
						number_hl_group = "LineNr",
					})
				end
			end
		end
	end,
	paint = function()
		local start = vim.v.foldstart
		local finish = vim.v.foldend
		local line = vim.api.nvim_buf_get_lines(0, start - 1, start, false)[1]
		local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
		local parser = vim.treesitter.get_parser(0, lang)
		local query = vim.treesitter.query.get(parser:lang(), "highlights")

		if query == nil then
			return vim.fn.foldtext()
		end

		local tree = parser:parse({ start - 1, start })[1]
		local result = {}

		local line_pos = 0

		local prev_range = nil

		for id, node, _ in query:iter_captures(tree:root(), 0, start - 1, start) do
			local name = query.captures[id]
			local start_row, start_col, end_row, end_col = node:range()

			if start_row == start - 1 and end_row == start - 1 then
				local range = { start_col, end_col }

				if start_col > line_pos then
					table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
				end

				line_pos = end_col

				local text = vim.treesitter.get_node_text(node, 0)

				if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
					result[#result] = { text, "@" .. name }
				else
					table.insert(result, { text, "@" .. name })
				end

				prev_range = range
			end
		end

		table.insert(result, { " ... ", "Folded" })

		for id, node, _ in query:iter_captures(tree:root(), 0, finish - 1, finish) do
			local name = query.captures[id]
			local start_row, start_col, end_row, end_col = node:range()

			if start_row == finish - 1 and end_row == finish - 1 then
				local range = { start_col, end_col }

				if start_col > line_pos then
					table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
				end

				line_pos = end_col

				local text = vim.treesitter.get_node_text(node, 0)

				if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
					result[#result] = { text, "@" .. name }
				else
					table.insert(result, { text, "@" .. name })
				end

				prev_range = range
			end
		end
		return result
	end,
}

return Fold
