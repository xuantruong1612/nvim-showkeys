local M = {}
local api = vim.api
local buf, win
local key_history = {}
local timer = vim.loop.new_timer()
local ns = api.nvim_create_namespace("key_logger")

local enabled = false

local function map_special_key(key)
	local key_map = {
		["\t"] = "⇥",
		["\n"] = "⏎",
		[" "] = "␣",
		["\27"] = "⎋",
	}
	return key_map[key] or key
end

local function create_floating_win()
	if win and api.nvim_win_is_valid(win) then
		return
	end
	buf = api.nvim_create_buf(false, true)
end

local function hide_window()
	if win and api.nvim_win_is_valid(win) then
		api.nvim_win_close(win, true)
		win = nil
		key_history = {}
	end
end

local function update_key_display(key)
	create_floating_win()
	table.insert(key_history, map_special_key(key))
	if #key_history > 20 then
		table.remove(key_history, 1)
	end
	local key_str = table.concat(key_history, "")

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

	if not win or not api.nvim_win_is_valid(win) then
		win = api.nvim_open_win(buf, false, opts)
	else
		api.nvim_win_set_config(win, opts)
	end

	api.nvim_buf_set_lines(buf, 0, -1, false, { key_str })

	timer:stop()
	timer:start(2000, 0, vim.schedule_wrap(hide_window))
end

function M.enable()
	if enabled then
		return
	end
	vim.on_key(function(key)
		if not enabled then
			return
		end
		update_key_display(key)
	end, ns)
	enabled = true
end

function M.disable()
	enabled = false
	hide_window()
end

return M
