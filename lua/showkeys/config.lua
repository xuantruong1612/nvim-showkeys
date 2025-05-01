local state = require("showkeys.core.state")
local keys = require("showkeys.core.keys")
local display = require("showkeys.core.display")
local timer = require("showkeys.core.timer")

local M = {}

function M.enable()
	if state.enabled then
		return
	end

	vim.on_key(function(key)
		if not state.enabled then
			return
		end
		table.insert(state.key_history, keys.map(key))
		if #state.key_history > 20 then
			table.remove(state.key_history, 1)
		end

		local key_str = table.concat(state.key_history, "")
		display.update(key_str)
		timer.restart()
	end, state.ns)

	state.enabled = true
end

function M.disable()
	state.enabled = false
	display.hide()
end

return M
