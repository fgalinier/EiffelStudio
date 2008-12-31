note
	description: "Dialog box to change an eiffel feature name"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class
	CHANGE_EIFFEL_FEATURE_NAME_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			
				-- Create all widgets.
			create l_vertical_box_1
			create l_vertical_box_2
			create l_horizontal_box_1
			create l_label_1
			create assemblies_combo
			create l_horizontal_box_2
			create l_label_2
			create types_combo
			create l_horizontal_box_3
			create l_label_3
			create dotnet_features_combo
			create l_horizontal_box_4
			create l_label_4
			create eiffel_features_combo
			create l_label_5
			create l_horizontal_box_5
			create l_label_6
			create new_eiffel_feature_name
			create l_horizontal_box_6
			create ok_btn
			create cancel_btn
			
				-- Build_widget_structure.
			extend (l_vertical_box_1)
			l_vertical_box_1.extend (l_vertical_box_2)
			l_vertical_box_2.extend (l_horizontal_box_1)
			l_horizontal_box_1.extend (l_label_1)
			l_horizontal_box_1.extend (assemblies_combo)
			l_vertical_box_2.extend (l_horizontal_box_2)
			l_horizontal_box_2.extend (l_label_2)
			l_horizontal_box_2.extend (types_combo)
			l_vertical_box_2.extend (l_horizontal_box_3)
			l_horizontal_box_3.extend (l_label_3)
			l_horizontal_box_3.extend (dotnet_features_combo)
			l_vertical_box_2.extend (l_horizontal_box_4)
			l_horizontal_box_4.extend (l_label_4)
			l_horizontal_box_4.extend (eiffel_features_combo)
			l_vertical_box_2.extend (l_label_5)
			l_vertical_box_1.extend (l_horizontal_box_5)
			l_horizontal_box_5.extend (l_label_6)
			l_horizontal_box_5.extend (new_eiffel_feature_name)
			l_vertical_box_1.extend (l_horizontal_box_6)
			l_horizontal_box_6.extend (ok_btn)
			l_horizontal_box_6.extend (cancel_btn)
			
				-- Initialize properties of all widgets.
			set_title ("Change Eiffel feature name.")
			l_label_1.set_text ("Assembly:")
			l_label_1.align_text_left
			l_label_2.set_text ("Class:")
			l_label_2.align_text_left
			l_label_3.set_text ("Dotnet feature name :")
			l_label_3.align_text_left
			l_label_4.set_text ("Corresponding Eiffel feature name:")
			l_label_4.align_text_left
			l_label_6.set_text ("New Eiffel feature name:")
			ok_btn.set_text ("OK")
			cancel_btn.set_text ("Cancel")
			
				--Connect events.
			assemblies_combo.change_actions.extend (agent on_change_assembly)
			types_combo.change_actions.extend (agent on_change_type)
			dotnet_features_combo.select_actions.extend (agent on_change_select_dotnet_feature)
			dotnet_features_combo.change_actions.extend (agent on_change_dotnet_feature)
			eiffel_features_combo.select_actions.extend (agent on_change_select_eiffel_feature)
			eiffel_features_combo.change_actions.extend (agent on_change_eiffel_feature)
			ok_btn.select_actions.extend (agent on_ok_btn)
			cancel_btn.select_actions.extend (agent on_cancel_btn)

				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.
			close_request_actions.extend (agent destroy)

			user_initialization
		end


feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	l_vertical_box_1, l_vertical_box_2: EV_VERTICAL_BOX
	l_horizontal_box_1, l_horizontal_box_2, l_horizontal_box_3, l_horizontal_box_4, 
	l_horizontal_box_5, l_horizontal_box_6: EV_HORIZONTAL_BOX
	l_label_1, l_label_2, l_label_3, l_label_4, l_label_5, l_label_6: EV_LABEL
	assemblies_combo, types_combo, dotnet_features_combo, eiffel_features_combo: EV_COMBO_BOX
	new_eiffel_feature_name: EV_TEXT_FIELD
	ok_btn, cancel_btn: EV_BUTTON
	
	user_initialization
			-- Called by `select_actions' of `execute'.
		deferred
		end

	on_change_assembly
			-- Called by `change_actions' of `assemblies_combo'.
		deferred
		end
	
	on_change_type
			-- Called by `change_actions' of `types_combo'.
		deferred
		end
	
	on_change_select_dotnet_feature
			-- Called by `select_actions' of `dotnet_features_combo'.
		deferred
		end
	
	on_change_dotnet_feature
			-- Called by `change_actions' of `dotnet_features_combo'.
		deferred
		end
	
	on_change_select_eiffel_feature
			-- Called by `select_actions' of `eiffel_features_combo'.
		deferred
		end
	
	on_change_eiffel_feature
			-- Called by `change_actions' of `eiffel_features_combo'.
		deferred
		end
	
	on_ok_btn
			-- Called by `select_actions' of `ok_btn'.
		deferred
		end
	
	on_cancel_btn
			-- Called by `select_actions' of `cancel_btn'.
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


end -- class CHANGE_EIFFEL_FEATURE_NAME_DIALOG_IMP
