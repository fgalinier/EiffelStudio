note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_MAIN_WINDOW

inherit
	ECDS_MAIN_WINDOW_IMP
		rename
			file_name as constants_file_name
		end

	ECDS_SAVED_SETTINGS
		rename
			make as settings_make
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	ECDS_OUTPUT_TAGS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

feature {NONE} -- Initialization

	user_initialization
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			settings_make
			close_request_actions.extend (agent ((create {EV_ENVIRONMENT}).application).destroy)
			if start_destination_folder_path /= Void then
				location_text_field.set_text (start_destination_folder_path)
			end
			if last_file_title /= Void then
				name_text_field.set_text (last_file_title)
			end
			if last_wsdl_url /= Void then
				address_text_field.set_text (last_wsdl_url)
			end
			if last_aspnet_url /= Void then
				web_address_text_field.set_text (last_aspnet_url)
			end
			check_aspnet_generation
			check_wsdl_generation
		end

feature {NONE} -- Implementation

	on_directory_browse
			-- Called by `select_actions' of `browse_location_button'.
		local
			l_dialog: EV_DIRECTORY_DIALOG
			l_path: STRING
		do
			create l_dialog.make_with_title ("Browse for destination folder")
			l_path := Start_destination_folder_path
			if l_path /= Void then
				l_dialog.set_start_directory (l_path)
			end
			l_dialog.show_modal_to_window (Current)
			l_path := l_dialog.directory
			if not l_path.is_empty  then
				set_start_destination_folder_path (l_path)
				location_text_field.set_text (l_path)
			end
			check_wsdl_generation
			check_aspnet_generation
		end

	on_filename_change
			-- Called by `change_actions' of `name_text_field'.
			-- Remove invalid filename character if one was entered
		local
			l_char: CHARACTER
			l_count: INTEGER
			l_file_name: STRING
		do
			l_file_name := name_text_field.text
			if not l_file_name.is_empty then
				l_count := l_file_name.count
				l_char := l_file_name.item (l_count)
				if l_count = 1 and l_char = ' ' then
					name_text_field.remove_text
				elseif l_char = '?' or l_char = '/' or l_char = '\' or l_char = '*' or l_char = '<' or l_char = '>'
					or l_char = '|' or l_char = ':' or l_char = '"' then
					l_file_name.keep_head (l_count - 1)
					name_text_field.set_text (l_file_name)
				end
				if not l_file_name.is_empty then
					set_last_file_title (l_file_name)				
				end
			end
			check_wsdl_generation
			check_aspnet_generation
		end

	on_wsdl_browse
			-- Called by `select_actions' of `browse_button'.
		local
			l_dialog: EV_FILE_OPEN_DIALOG
			l_path: STRING
		do
			create l_dialog.make_with_title ("Browse for WSDL file")
			l_dialog.filters.extend (["*.wsdl", "*.wsdl"])
			l_path := Wsdl_start_directory
			if l_path /= Void then
				l_dialog.set_start_directory (l_path)
			end
			l_dialog.show_modal_to_window (Current)
			l_path := l_dialog.file_path
			if not l_path.is_empty then
				set_wsdl_start_directory (l_path)
				set_last_wsdl_url (l_dialog.file_name)
				address_text_field.set_text (l_dialog.file_name)
			end
			check_wsdl_generation
		end

	on_generate_wsdl_tree
			-- Called by `select_actions' of `wsdl_go_button'.
		local
			l_wsdl_serializer: ECDS_WSDL_SERIALIZER
		do
			check
				valid_destination: location_text_field.text /= Void and then not location_text_field.text.is_empty
				valid_name: name_text_field.text /= Void and then not name_text_field.text.is_empty
				valid_address: address_text_field.text /= Void and then not address_text_field.text.is_empty
			end
			create l_wsdl_serializer.make (location_text_field.text, name_text_field.text, address_text_field.text, wsdl_server_check_button.is_selected)
			l_wsdl_serializer.serialize
			if l_wsdl_serializer.last_serialization_successful then
				report_success (l_wsdl_serializer.file_name)
			else
				report_failure (l_wsdl_serializer.last_error_message, l_wsdl_serializer.text_output)
			end
		end

	on_web_address_change
			-- Called by `change_actions' of `web_address_text_fied'.
			-- Record new web address.
		do
			set_last_aspnet_url (web_address_text_field.text)
			check_aspnet_generation
		end
		
	on_generate_aspnet_tree
			-- Called by `select_actions' of `generate_aspnet_tree_button'.
		local
			l_aspnet_serializer: ECDS_ASPNET_SERIALIZER
		do
			check
				valid_destination: location_text_field.text /= Void and then not location_text_field.text.is_empty
				valid_name: name_text_field.text /= Void and then not name_text_field.text.is_empty
				valid_url: web_address_text_field.text /= Void and then not web_address_text_field.text.is_empty
			end
			create l_aspnet_serializer.make (location_text_field.text, name_text_field.text, "http://localhost/" + web_address_text_field.text)
			l_aspnet_serializer.serialize
			if l_aspnet_serializer.last_serialization_successful then
				report_success (l_aspnet_serializer.file_name)
			else
				report_failure (l_aspnet_serializer.last_error_message, l_aspnet_serializer.text_output)
			end
		end

feature {NONE} -- Implementation

	report_success (a_file_name: STRING)
			-- Report that serialization occured successfully.
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		local
			l_dialog: EV_INFORMATION_DIALOG
		do
			create l_dialog.make_with_text ("Codedom tree successfully serialized in " + a_file_name)
			l_dialog.show_modal_to_window (Current)
		end
		
	report_failure (a_error, a_output: STRING)
			-- Report that serialization failed.
		require
			non_void_error: a_error /= Void
			valid_error: not a_error.is_empty
		local
			l_text: STRING
		do
			l_text := opening_tag (Error_tag) + "Serialization failed with error message:%N" + a_error + closing_tag (Error_tag)
			if a_output /= Void then
				l_text.append ("%N%N" + opening_tag (header_tag) + "Serializer output:%N" + closing_tag (header_tag))
				l_text.append (a_output)
			end
			l_text.prune_all ('%R')
			output_dialog.show
		--	output_dialog.clear
			output_dialog.write (l_text)
		end
		
	check_wsdl_generation
			-- Enable generate wsdl button if all required settings are initialized
		do
			if location_text_field.text /= Void and then not location_text_field.text.is_empty and
						name_text_field.text /= Void and then not name_text_field.text.is_empty and
						address_text_field.text /= Void and then not address_text_field.text.is_empty then
				if not wsdl_go_button.is_sensitive then
					wsdl_go_button.enable_sensitive
				end
			elseif wsdl_go_button.is_sensitive then
				wsdl_go_button.disable_sensitive
			end
		end
		
	check_aspnet_generation
			-- Enable generate wsdl button if all required settings are initialized
		do
			if location_text_field.text /= Void and then not location_text_field.text.is_empty and
						name_text_field.text /= Void and then not name_text_field.text.is_empty and
						web_address_text_field.text /= Void and then not web_address_text_field.text.is_empty then
				if not generate_aspnet_tree_button.is_sensitive then
					generate_aspnet_tree_button.enable_sensitive
				end
			elseif generate_aspnet_tree_button.is_sensitive then
				generate_aspnet_tree_button.disable_sensitive
			end
		end
	
	output_dialog: ECDS_OUTPUT_DIALOG
			-- Output dialog
		once
			create Result
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


end -- class ECDS_MAIN_WINDOW

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------

