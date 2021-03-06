note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IVIEW_OBJECT2_INTERFACE

inherit
	IVIEW_OBJECT_INTERFACE

feature -- Status Report

	get_extent_user_precondition (dw_draw_aspect: INTEGER; lindex: INTEGER; ptd: TAG_DVTARGETDEVICE_RECORD; lpsizel: TAG_SIZEL_RECORD): BOOLEAN
			-- User-defined preconditions for `get_extent'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	get_extent (dw_draw_aspect: INTEGER; lindex: INTEGER; ptd: TAG_DVTARGETDEVICE_RECORD; lpsizel: TAG_SIZEL_RECORD)
			-- No description available.
			-- `dw_draw_aspect' [in].  
			-- `lindex' [in].  
			-- `ptd' [in].  
			-- `lpsizel' [out].  
		require
			non_void_ptd: ptd /= Void
			valid_ptd: ptd.item /= default_pointer
			non_void_lpsizel: lpsizel /= Void
			valid_lpsizel: lpsizel.item /= default_pointer
			get_extent_user_precondition: get_extent_user_precondition (dw_draw_aspect, lindex, ptd, lpsizel)
		deferred

		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IVIEW_OBJECT2_INTERFACE

