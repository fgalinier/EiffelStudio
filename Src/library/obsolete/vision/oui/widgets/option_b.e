note

	description: "Rectangle which displays an option menu when armed"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	OPTION_B

inherit

	BUTTON
		redefine
			implementation, parent, set_size, set_height, set_width
		end

create

	make, make_unmanaged

feature {NONE} -- Initiazliation

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a menu button with `a_name' as label
			-- 'a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create an unmanaged menu button with `a_name' as label
			-- 'a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a menu button with `a_name' as label
			-- 'a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {OPTION_B_IMP} implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Access

	parent: COMPOSITE
			-- Parent of current menu button
		do
			Result ?= widget_manager.parent (Current)
		end;

	selected_button: BUTTON
			-- Current Push Button selected in the option menu
		require
			exists: not destroyed
		do
			Result := implementation.selected_button
		end;

	title: STRING
		require
			exists: not destroyed
		do
			Result := implementation.title;
		end;

	title_width: INTEGER
		require
			exists: not destroyed
		do
			Result := implementation.title_width;
		end;

feature -- Element change

	set_selected_button (button: BUTTON)
			-- Set `selected_button' to `button'
		require
			exists: not destroyed;
			button_exists: button /= Void
		do
			implementation.set_selected_button (button)
		ensure
			button = selected_button
		end;

	attach_menu (a_menu: OPT_PULL)
			-- Attach menu `a_menu' to the menu button, it will
			-- be the menu which will appear when the button
			-- is armed.
		require
			exists: not destroyed;
			menu_not_void: a_menu /= Void;
			same_parent: a_menu.parent = parent
		do
			implementation.attach_menu (a_menu)
		end;

	set_title (a_title: STRING)
		require
			exists: not destroyed;
		do
			implementation.set_title (a_title);
		end;

	remove_title
		require
			exists: not destroyed
		do
			implementation.remove_title;
		end;

	set_size (new_width, new_height: INTEGER)
		do
			if new_width > width or new_height > height then
				unmanage;
			end;
			implementation.set_size (new_width, new_height);
			if not managed then
				manage;
			end;
		end;

	set_width (new_width: INTEGER)
		do
			if new_width > width then
				unmanage;
			end;
			implementation.set_width (new_width);
			if not managed then
				manage;
			end;
		end;

	set_height (new_height: INTEGER)
		do
			if new_height > height then
				unmanage;
			end;
			implementation.set_height (new_height);
			if not managed then
				manage;
			end;
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: OPTION_B_I;
			-- Implementation of menu button

feature {NONE} -- Implementation

	set_default
			-- Set default value to current menu button.
		do
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




end -- class OPTION_B

