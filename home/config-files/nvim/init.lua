-- Neovide
if vim.g.neovide then
	vim.g.neovide_cursor_vfx_mode = "ripple"

	vim.g.neovide_cursor_vfx_particle_density = 30.0
	vim.g.neovide_transparency = 1.0

	local font_name = "Hack Nerd Font Mono:h"
	local font_size = 14

	vim.o.guifont = font_name .. tostring(font_size)
	vim.g.neovide_profiler = false
	vim.g.neovide_hide_mouse_when_typing = true

	-- Fullscreen keymapping
	vim.keymap.set("n", "<leader>FF", function()
		if vim.g.neovide_fullscreen then
			vim.g.neovide_fullscreen = false
		else
			vim.g.neovide_fullscreen = true
		end
	end)
	vim.keymap.set("n", "<C-+>", function()
		font_size = font_size + 1
		vim.o.guifont = font_name .. tostring(font_size)
	end)
	vim.keymap.set("n", "<C-->", function()
		if font_size >= 1 then
			font_size = font_size - 1
			vim.o.guifont = font_name .. tostring(font_size)
		end
	end)
end
