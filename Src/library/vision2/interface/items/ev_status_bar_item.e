--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision status bar item."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_ITEM

inherit
	EV_SIMPLE_ITEM
		redefine
			implementation,
			create_implementation,
			parent
		end

feature -- Access

	parent: EV_STATUS_BAR is
			-- Parent of the current item.
		do
			Result ?= {EV_SIMPLE_ITEM} Precursor
		end

feature -- Measurement

	width: INTEGER is
			-- The width of the item in the status bar.
		require
		do
			Result := implementation.width
		end

feature -- Status setting

	set_width (value: INTEGER) is
			-- Make `value' the new width of the item.
			-- If -1, then the item reach the right of the status
			-- bar.
		require
			has_parent: parent /= Void
			valid_value: value >= -1
			maximise_ok: value = -1 implies (parent.i_th (parent.count) = Current)
		do
			implementation.set_width (value)
		ensure
			width_set: (width = value) or (value = -1)
		end

feature {NONE} -- Implementation

	implementation: EV_STATUS_BAR_ITEM_I
			-- platform dependent access.

	create_implementation is
			-- Create implementation of status bar item.
		do
			create {EV_STATUS_BAR_ITEM_IMP} implementation.make (Current)
		end

end -- class EV_STATUS_BAR_ITEM

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.11.4.6  2000/02/07 20:17:12  king
--| Removed invalid creation procedure declarations
--|
--| Revision 1.11.4.5  2000/02/05 02:47:46  oconnor
--| released
--|
--| Revision 1.11.4.4  2000/02/04 21:15:45  king
--| Added has_parent precond to set-width
--|
--| Revision 1.11.4.3  2000/01/27 19:30:37  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.4.2  1999/12/17 21:12:19  rogers
--| Advanced make procedures hav been removed, ready for re-implementation.
--|
--| Revision 1.11.4.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/04 23:10:52  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.10.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
