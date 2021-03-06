﻿note
	description: "Draw ovals in a specified window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OVAL_DEMO_CMD

inherit
	DEMO_CMD

create
	make_in

feature -- Basic operations

	draw (t_parent: CLIENT_WINDOW)
			-- Draw Ovals.
		local
			dc: WEL_CLIENT_DC
			r_left, r_top, r_right, r_bottom: INTEGER
			brush: WEL_BRUSH
			l_rect: WEL_RECT
		do
				-- Initialize
			r_left := next_number (t_parent.width)
			r_top := next_number (t_parent.height)
			r_right := next_number (t_parent.width)
			r_bottom := next_number (t_parent.height)
			create brush.make_solid (std_colors @ next_number (std_colors.count))
			create l_rect.make (1, 1, t_parent.width, 30)

				-- Drawing part
			create dc.make (t_parent)
			dc.get
			dc.select_brush (brush)
			dc.ellipse (r_left, r_top, r_right, r_bottom)
 			dc.draw_text (count.out, l_rect, {WEL_DT_CONSTANTS}.Dt_bottom)
 			dc.release

				-- Clean
			brush.delete

				-- Update
			count := count + 1
		end

	count: INTEGER
			-- Number of time where `draw' has been called.

invariant
	count_nonnegative: count >= 0

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
