indexing
	description	: "Wizard Final Step"
	author		: "Generated by the Wizard wizard"
	revision	: "1.0.0"

class
	WIZARD_FINAL_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			display,
			back
		end

	GB_SHARED_TOOLS
	
	GB_WIDGET_UTILITIES
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_SHARED_XML_HANDLER
	
	GB_CONSTANTS
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_SHARED_OBJECT_HANDLER
	
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end
		
	GB_SHARED_PREFERENCES
	

creation
	make

feature {NONE} -- Implementation

	build_finish is 
			-- Build user entries.
			--
			-- Note: You can remove this feature if you don't need
			--       a progress bar.
		do
			first_window.disable_user_resize
			first_window.disable_maximize
			main_window.hide_all_floating_tools
			choice_box.wipe_out
			choice_box.set_border_width (10)
			create progress 
			progress.set_minimum_height(20)
			progress.set_minimum_width(100)
			create progress_text
			choice_box.extend(create {EV_CELL})
			choice_box.extend(progress)
			choice_box.disable_item_expand(progress)
			choice_box.extend(progress_text)
			choice_box.extend(create {EV_CELL})

			choice_box.set_background_color (white_color)
			progress.set_background_color (white_color)
			progress_text.set_background_color (white_color)
		end

	process_info is
			-- Process the wizard information
		local
			code_generator: GB_CODE_GENERATOR
			output_file_name: FILE_NAME
			output_file: PLAIN_TEXT_FILE
			window_selector_item: GB_WINDOW_SELECTOR_ITEM
			window_selector_layout: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			eifp_document: EIFP_DOCUMENT
			eiffel_files: FILE_FOLDER_NODE_FRAGMENT
			build_files: FILE_FOLDER_NODE_FRAGMENT
		do
				-- The wizard generated code seems to leave the
				-- window locked, so we unlock it. We check first,
				-- so that if somebody fixes this, then our code
				-- will not fail.
			if (create {EV_ENVIRONMENT}).application.locked_window = first_window then
				first_window.unlock_update
			end
			create code_generator
			code_generator.set_progress_bar (progress)
			code_generator.generate
			system_status.current_project_settings.save
			xml_handler.save
			
				-- create eifp file
			create eifp_document.make_open_read (Visual_studio_information.wizard_installation_path + "\..\default_windows.eifp")
			if eifp_document.successful then
				eiffel_files := eifp_document.files_node.eiffel_source_files_node
				build_files := eifp_document.files_node.other_source_files_node

				from 
					window_selector.start
				until
					window_selector.off
				loop
					window_selector_item ?= window_selector.item
					 if window_selector_item /= Void then
					 	eiffel_files.add_file ((window_selector_item.object.name).as_lower + ".e", True)
					end
					window_selector_layout ?= window_selector.item
					if window_selector_layout /= Void then
						from
							window_selector_layout.start
						until
							window_selector_layout.off
						loop
							window_selector_item ?= window_selector_layout.item
							if window_selector_item /= Void then
								eiffel_files.add_file ((window_selector_layout.text + "\" + window_selector_item.object.name).as_lower + ".e", True)								
							end
							window_selector_layout.forth
						end
					end
					window_selector.forth
				end
				eiffel_files.add_file (system_status.current_project_settings.constants_class_name.as_lower + ".e", True)
				eiffel_files.add_file (system_status.current_project_settings.constants_class_name.as_lower +  Class_implementation_extension.as_lower + ".e", True)
			end
			build_files.add_file ("build_project.bpr", True)
			eifp_document.save_document (system_status.current_project_settings.project_location + "\" + System_status.current_project_settings.project_name + ".eifp")
			
			--| Add here the action of your wizard.
			--|
			--| Update `progress' and `progress_text' to give a
			--| a feedback to the user of what you are currently
			--| doing.
		end
		
	generated_path: FILE_NAME is
			-- `Result' is generated directory for current project.
		do
			create Result.make_from_string (system_status.current_project_settings.project_location)
		end

	proceed_with_current_info is
			-- User has clicked "finish", proceed...
		local
			objects: ARRAYED_LIST [GB_OBJECT]
			confirmation_dialog: EV_CONFIRMATION_DIALOG
		do
			objects := Window_selector.objects
			if not object_handler.objects_all_named (objects) then
				create confirmation_dialog.make_with_text (Not_all_windows_named_string)
				confirmation_dialog.set_icon_pixmap (Icon_build_window @ 1)
				confirmation_dialog.show_modal_to_window (main_window)
				if confirmation_dialog.selected_button.is_equal ("OK") then
					object_handler.add_default_names (objects)
				end
			end
				-- Only complete wizard if all window objects are named.
				-- If a user selected "cancel" from the confirmation dialog,
				-- then the wizard will not exit.
			if object_handler.objects_all_named (objects) then
				preferences.save_resources
				build_finish
				process_info
				Precursor {WIZARD_FINAL_STATE_WINDOW}
			end
		end
		
	display is
			-- Display Current State
		do
			first_window.set_final_state ("Finish")
			build
				-- Remove ability to resize from window.
			first_window.disable_user_resize
			first_window.disable_maximize
			main_window.hide_all_floating_tools
				-- Set size back to standard dialog size. Note that
				-- we cannot do this in `build' as it is only called the
				-- first time that the page is built. After that it is cached.
			first_window.set_minimum_size (100, 100)
			first_window.set_size (dialog_unit_to_pixels (503), dialog_unit_to_pixels (385))
		end

	display_state_text is
			-- Set the messages for this state.
		do
			title.set_text ("Completing the%N" + Envision_build_wizard_title)
			message.set_text (final_message)
		end
		
	project_location_wrapped: STRING is
			-- As project location may be very long, we must wrap it,
			-- in order to ensure that we do not get a very wide window
			-- just for displaying the location. Note that we also
			-- reset the width of the window here. This is a
			-- way of getting round the wizards standard behaviour.
		local
			project_location: STRING
			counter: INTEGER
		do
			first_window.set_size (dialog_unit_to_pixels(503), dialog_unit_to_pixels(385))
			project_location := system_status.current_project_settings.project_location.twin
			if project_location.count > 40 and not project_location.has ('%N') then
				from
					counter := 40
				until
					counter > project_location.count
				loop
					project_location.insert_character ('%N', counter)
					counter := counter + 40
				end
			end
			Result := project_location
		end
		

	final_message: STRING is
			-- Final message displayed by wizard.
		do
			Result := "Clicking 'Finish' will generate a new Eiffel Vision2%
			%%Nproject corresponding to the following information : %N%N" +
			"Project location : " + project_location_wrapped +
			"%N%NProject name : " + system_status.current_project_settings.project_name +
			"%NApplication class : " + system_status.current_project_settings.application_class_name +
			"%NWindow class : " + system_status.current_project_settings.main_window_class_name
		ensure then
			Result /= Void
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon used.
		once
			create Result.make_from_string ("eiffel_wizard_icon.png")
		end
	
	back is
			-- Back to previous page.
		do
			Precursor {WIZARD_FINAL_STATE_WINDOW}
			main_window.show
			first_window.hide
		end
		

end -- class WIZARD_FINAL_STATE
