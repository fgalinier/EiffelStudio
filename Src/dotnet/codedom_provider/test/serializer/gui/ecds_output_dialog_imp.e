note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECDS_OUTPUT_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	ECDS_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		local 
			l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
			internal_font: EV_FONT
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
				-- Create all widgets.
			create output_box
			create output_text
			create l_ev_horizontal_separator_1
			create button_box
			create left_padding_cell
			create ok_button
			create right_padding_cell
			
				-- Build_widget_structure.
			extend (output_box)
			output_box.extend (output_text)
			output_box.extend (l_ev_horizontal_separator_1)
			output_box.extend (button_box)
			button_box.extend (left_padding_cell)
			button_box.extend (ok_button)
			button_box.extend (right_padding_cell)
			
			set_title ("Output")
			output_box.disable_item_expand (l_ev_horizontal_separator_1)
			output_box.disable_item_expand (button_box)
			create internal_font
			internal_font.set_family (4)
			internal_font.set_weight (7)
			internal_font.set_shape (10)
			internal_font.set_height (11)
			internal_font.preferred_families.extend ("Lucida Console")
			output_text.set_font (internal_font)
			output_text.set_minimum_width (590)
			output_text.set_minimum_height (230)
			button_box.set_padding_width (5)
			button_box.set_border_width (5)
			button_box.disable_item_expand (ok_button)
			ok_button.set_text ("OK")
			ok_button.set_minimum_width (100)
			
				--Connect events.
			ok_button.select_actions.extend (agent on_ok)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	output_box: EV_VERTICAL_BOX
	output_text: EV_TEXT
	button_box: EV_HORIZONTAL_BOX
	left_padding_cell, right_padding_cell: EV_CELL
	ok_button: EV_BUTTON

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	on_ok
			-- Called by `select_actions' of `ok_button'.
		deferred
		end
	

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ECDS_OUTPUT_DIALOG_IMP
