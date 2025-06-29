local state = require("showkeys.core.state")
local display = require("showkeys.core.display")

local M = {}

function M.restart()
	state.timer:stop()
	state.timer:start(1200, 0, vim.schedule_wrap(display.hide))
end

return M
