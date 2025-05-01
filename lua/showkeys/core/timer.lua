local state = require("showkeys.core.state")
local display = require("showkeys.core.display")

local M = {}

function M.restart()
	state.timer:stop()
	state.timer:start(2000, 0, vim.schedule_wrap(display.hide))
end

return M
