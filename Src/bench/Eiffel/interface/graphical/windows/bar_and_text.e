
-- Model for workbench windows

class BAR_AND_TEXT

inherit

	TOOL_W
		rename
			execute as tool_w_execute
		redefine
			save_command, set_default_format,
			hole
		end;
	TOOL_W
		redefine
			save_command, set_default_format,
			hole, execute
		select
			execute
		end;
	TOP_SHELL
		rename
			make as shell_make,
			realize as shell_realize
		redefine
			delete_window_action
		end;
	TOP_SHELL
		rename
			make as shell_make
		redefine
			realize, delete_window_action
		select
			realize
		end

creation

	make

feature

	make (a_screen: SCREEN) is
			-- Create an assembly tool.
		do
			shell_make (tool_name, a_screen);
			!!global_form.make (new_name, Current);
			build_widgets;
			if hole.icon_symbol.is_valid then
				set_icon_pixmap (hole.icon_symbol);
			end;
			set_icon_name (tool_name);
			transporter_init
		end;

	realize is
		do
			--set_default_position;
			shell_realize
		end;

	set_default_format is
			-- Default format of windows
		do
			text_window.set_last_format (default_format);		
		end;

	global_form: FORM;

	hole: HOLE;
			-- Hole caracterizing current

	edit_bar, format_bar: FORM;
			-- Main and format menu bars

	build_widgets is
			-- Build system widget.
		do
			set_default_size;
				!!text_window.make (new_name, global_form, Current);
				!!edit_bar.make (new_name, global_form);
				build_bar;
				!!format_bar.make (new_name, global_form);
				build_format_bar;
				text_window.set_last_format (default_format);
			attach_all
		end;

	set_default_size is
		do
			set_size (440, 500)
		end;

	set_default_position is
		do
		end;

	showtext_command: SHOW_TEXT;
			-- Command to show text od text window's root stone,
			-- default format by default
	default_format: FORMATTER is do Result := showtext_command end;

	type_teller: LABEL_G;
			-- To tell what type of element we are dealing with

	clean_type is
			-- Clean what's said in the type teller window.
		do
			type_teller.set_text (" ")
		end;

	tell_type (a_type_name: STRING) is
			-- Display `a_type_name' in type teller.
		do
			type_teller.set_text (a_type_name)
		end;

	editable: BOOLEAN is
			-- Is Current window editable (default is false)?
		do
		end;

	search_command: SEARCH_STRING;
	change_font_command: CHANGE_FONT;
	open_command: OPEN_FILE is do end;
	save_command: SAVE_FILE is do end;
	save_as_command: SAVE_AS_FILE is do end;
	quit_command: QUIT_FILE is do end;
	create_edit_buttons is do end;

	close_windows is
			-- Close search window
		do
			search_command.close;
			change_font_command.close (text_window)
		end;

	build_bar is
		do
			if editable then
				build_edit_bar
			else
				build_basic_bar
			end;
		end;

	build_basic_bar is
			-- Build top bar (only the basics).
		local
			quit_cmd: QUIT_FILE;
		do
			!!hole.make (edit_bar, Current);
			!!type_teller.make (new_name, edit_bar);
			type_teller.set_center_alignment;
			!!search_command.make (edit_bar, text_window);
			!!change_font_command.make (edit_bar, text_window);
			!!quit_cmd.make (edit_bar, text_window);
				edit_bar.attach_left (hole, 0);
				edit_bar.attach_top (hole, 0);
				edit_bar.attach_top (type_teller, 0);
				edit_bar.attach_top (search_command, 0);
				edit_bar.attach_top (change_font_command, 0);
				edit_bar.attach_top (quit_cmd, 0);
				clean_type;
				edit_bar.attach_left_widget (hole, type_teller, 0);
				edit_bar.attach_right_widget (search_command, type_teller, 0);
				edit_bar.attach_bottom (type_teller, 0);
				edit_bar.attach_right_widget (change_font_command, search_command, 0);
				edit_bar.attach_right_widget (quit_cmd, change_font_command, 5);
				edit_bar.attach_right (quit_cmd, 0);
		end;

	build_edit_bar is
			-- Build top bar: editing commands.
		do
			!!hole.make (edit_bar, Current);
			create_edit_buttons;
			!!type_teller.make (new_name, edit_bar);
				type_teller.set_center_alignment;
			!!search_command.make (edit_bar, text_window);
			!!change_font_command.make (edit_bar, text_window);
				edit_bar.attach_left (hole, 0);
				edit_bar.attach_top (hole, 0);
				edit_bar.attach_top (open_command, 0);
				edit_bar.attach_top (save_command, 0);
				edit_bar.attach_top (save_as_command, 0);
				edit_bar.attach_top (type_teller, 0);
				edit_bar.attach_top (search_command, 0);
				edit_bar.attach_top (change_font_command, 0);
				edit_bar.attach_top (quit_command, 0);
				edit_bar.attach_left (hole, 0);
				edit_bar.attach_left_widget (hole, type_teller, 0);
				edit_bar.attach_right_widget (open_command, type_teller, 0);
				edit_bar.attach_right_widget (save_command, open_command, 0);
				edit_bar.attach_right_widget (save_as_command, save_command, 0);
				edit_bar.attach_right_widget (search_command, save_as_command, 0);
				edit_bar.attach_bottom (type_teller, 0);
				edit_bar.attach_right_widget (change_font_command, search_command, 0);
				edit_bar.attach_right_widget (quit_command, change_font_command, 5);
				edit_bar.attach_right (quit_command, 0);
				clean_type;
		end;

	build_format_bar is
			-- Build bottom bar: formatting commands.
		do
		end;

	attach_all is
			-- Attach menu bar and windows below together.
		do
			global_form.attach_left (edit_bar, 0);
			global_form.attach_right (edit_bar, 0);
			global_form.attach_top (edit_bar, 0);

			global_form.attach_left (text_window, 0);
			global_form.attach_right (text_window, 0);
			global_form.attach_bottom_widget (format_bar, text_window, 0);
			global_form.attach_top_widget (edit_bar, text_window, 0);

			global_form.attach_left (format_bar, 0);
			global_form.attach_right (format_bar, 0);
			global_form.attach_bottom (format_bar, 0);
		end

feature -- quit actions

	task_end: TASK;

	delete_window_action  is
		do
			!!task_end.make;
			task_end.add_action (Current, task_end);
			iterate;
		end;
	
	execute (argument: ANY) is
		do
			if argument = task_end then
				task_end.remove_action (Current, task_end);
				quit_command.execute (Void);
			else
				tool_w_execute (argument)
			end;
		end;

end -- class BAR_AND_TEXT
