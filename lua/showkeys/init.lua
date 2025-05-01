local M = {}

function M.setup()
	require("showkeys.config").enable()
end

function M.enable()
	require("showkeys.config").enable()
end

function M.disable()
	require("showkeys.config").disable()
end

return M
