indexing
	description: "Demo for squares."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SQUARE_ITEM

inherit
	FIGURE_ITEM

create
	make_with_title

feature -- Access

	figure: EV_SQUARE is
		local
			pt: EV_POINT
		do
			create Result.make
			Result.path.set_line_width (2)
			create pt.set (150, 150)
			Result.set_center (pt)
			Result.set_size_of_side (60)
		end

end -- class SQUARE_ITEM

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

