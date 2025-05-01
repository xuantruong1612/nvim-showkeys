local M = {
	buf = nil,
	win = nil,
	key_history = {},
	timer = vim.loop.new_timer(),
	ns = vim.api.nvim_create_namespace("key_logger"),
	enabled = false,
}

return M
