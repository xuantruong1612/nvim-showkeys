local api = vim.api
local state = require("showkeys.core.state")

local M = {}

function M.create_win()
	if state.win and api.nvim_win_is_valid(state.win) then
		return
	end
	state.buf = api.nvim_create_buf(false, true)
end

function M.hide()
	if state.win and api.nvim_win_is_valid(state.win) then
		api.nvim_win_close(state.win, true)
		state.win = nil
		state.key_history = {}
	end
end

function M.update(key_str)
	M.create_win()
	local win_width = math.min(#key_str, vim.o.columns - 10)
	local opts = {
		relative = "editor",
		width = win_width,
		height = 1,
		row = vim.o.lines - 3,
		col = 5,
		style = "minimal",
		border = "none",
	}

	if not state.win or not api.nvim_win_is_valid(state.win) then
		state.win = api.nvim_open_win(state.buf, false, opts)
	else
		api.nvim_win_set_config(state.win, opts)
	end

	api.nvim_buf_set_lines(state.buf, 0, -1, false, { key_str })
end

return M
