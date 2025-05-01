local M = {}

function M.map(key)
	local map = {
		["\t"] = "⇥",
		["\n"] = "⏎",
		[" "] = "␣",
		["\27"] = "⎋",
	}
	return map[key] or key
end

return M
