indexing
	description:
		"Implementation interface for pick and drop.%N%
		%See ev_pick_and_dropable.e"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	EV_SHARED_TRANSPORT_I

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_I

feature -- Access

	pebble: ANY
			-- Data to be transported by pick and drop mechanism.

	pebble_function: FUNCTION [ANY, TUPLE, ANY]
			-- Returns data to be transported by pick and drop mechanism.

	pebble_positioning_enabled: BOOLEAN is
			-- If `True' then pick and drop start coordinates are
			-- `pebble_x_position', `pebble_y_position'.
			-- If `False' then pick and drop start coordinates are
			-- the pointer coordinates.
		do
			Result := internal_pebble_positioning_enabled
		end

	accept_cursor: EV_POINTER_STYLE
			-- Accept cursor set by user.
			-- To be displayed when the screen pointer is over a target that accepts
			-- `pebble' during pick and drop.

	deny_cursor: EV_POINTER_STYLE
		-- Deny cursor set by user.
		-- To be displayed when the screen pointer is not over a valid target.

	pebble_x_position: INTEGER is
			-- Initial x position for pick and drop relative to `Current'.
		do
			Result := pick_x
		end

	pebble_y_position: INTEGER is
			-- Initial y position for pick and drop relative to `Current'.
		do
			Result := pick_y
		end

feature -- Status setting

	set_pebble_position (a_x, a_y: INTEGER) is
			-- Set the initial position for pick and drop relative to `Current'.
		require
		do
			pick_x := a_x.to_integer_16
			pick_y := a_y.to_integer_16
		ensure
			pick_x_assigned: pick_x = a_x
			pick_y_assigned: pick_y = a_y
		end

	set_pebble (a_pebble: like pebble) is
			-- Assign `a_pebble' to `pebble'.
		require
			a_pebble_not_void: a_pebble /= Void
		do
			pebble_function := Void
			pebble := a_pebble
			enable_transport
			-- Data to be transported by pick and drop mechanism.
		ensure
			pebble_assigned: interface.implementation.pebble = a_pebble
			is_transport_enabled: interface.implementation.is_transport_enabled
		end

	set_pebble_function (a_function: FUNCTION [ANY, TUPLE, ANY]) is
			-- Assign `a_function' to `pebble_function'.
		require
			a_function_not_void: a_function /= Void
		do
			pebble := Void
			pebble_function := a_function
			enable_transport
		ensure
			pebble_function_assigned: interface.implementation.pebble_function = a_function
			is_transport_enabled: interface.implementation.is_transport_enabled
		end

	remove_pebble is
			-- Remove `pebble'.
		do
			pebble := Void
			pebble_function := Void
			disable_transport
		ensure
			pebble_removed: pebble = Void and pebble_function = Void
			is_transport_disabled: not is_transport_enabled
		end

	enable_transport is
            		-- Activate pick/drag and drop mechanism.
		require
			pebble_not_void: pebble /= Void or pebble_function /= Void
		deferred
		ensure
			is_transport_enabled: interface.implementation.is_transport_enabled
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		deferred
		ensure
			is_transport_disabled: not is_transport_enabled
		end

	set_pick_and_drop_mode is
			-- Set transport mechanism to pick and drop,
		do
			user_interface_mode := pick_and_drop_mode
		ensure
			mode_is_pick_and_drop: mode_is_pick_and_drop
		end

	set_drag_and_drop_mode is
			-- Set transport mechanism to drag and drop,
		do
			user_interface_mode := drag_and_drop_mode
		ensure
			mode_is_drag_and_drop: mode_is_drag_and_drop
		end

	set_target_menu_mode is
			-- Set transport mechanism to a target_menu.
		do
			user_interface_mode := target_menu_mode
		ensure
			mode_is_target_menu: mode_is_target_menu
		end

	set_configurable_target_menu_mode is
			-- Set transport mechanism to a configurable target_menu.
		do
			user_interface_mode := configurable_target_menu_mode
		ensure
			mode_is_target_menu: mode_is_configurable_target_menu
		end

	set_accept_cursor (a_cursor: like accept_cursor) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		do
			accept_cursor := a_cursor
		end

	set_deny_cursor (a_cursor: like deny_cursor) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that doesn't accept `pebble' during pick and drop.
		do
			deny_cursor := a_cursor
		end

	enable_pebble_positioning is
			-- Assign `True' to `pebble_positioning_enabled'.
		do
			internal_pebble_positioning_enabled := True
		end

	disable_pebble_positioning is
			-- Assign `False' to `pebble_positioning_enabled'.
		do
			internal_pebble_positioning_enabled := False
		end

feature -- Status report

	is_transport_enabled: BOOLEAN
			-- Is the transport mechanism enabled?

	mode_is_pick_and_drop: BOOLEAN is
			-- Is the transport mechanism pick and drop?
		do
			Result := user_interface_mode = pick_and_drop_mode or else user_interface_mode = configurable_target_menu_mode
		end

	mode_is_drag_and_drop: BOOLEAN is
			-- Is the transport mechanism drag and drop?
		do
			Result := user_interface_mode = drag_and_drop_mode
		end

	mode_is_target_menu: BOOLEAN is
			-- Is the transport mechanism a target menu?
		do
			Result := user_interface_mode = target_menu_mode
		end

	mode_is_configurable_target_menu: BOOLEAN is
			-- Is the transport mechanism a configurable target menu?
		do
			Result := user_interface_mode = configurable_target_menu_mode
		end

feature {EV_ANY_I} -- Implementation

	pick_x, pick_y: INTEGER_16
		-- Initial point for the pick and drop.

	internal_pebble_positioning_enabled: BOOLEAN
		-- Is `pebble_positining_enabled' ?

	user_interface_mode: INTEGER_8
			-- Transport user interface mode.

	pick_and_drop_mode: INTEGER_8 is 0
	drag_and_drop_mode: INTEGER_8 is 1
	target_menu_mode: INTEGER_8 is 2
	configurable_target_menu_mode: INTEGER_8 is 3

	start_transport (
		a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER)
	is
			-- Start a pick and drop transport.
		deferred
		end

	end_transport (
		a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER)
	is
			-- Terminate the pick and drop mechanism.
		deferred
		end

	execute (
			a_x, a_y: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
		is
			-- Executed when `pebble' is being moved.
			-- Draw a rubber band from pick position to pointer position.
		local
			target: EV_ABSTRACT_PICK_AND_DROPABLE
			real_target: EV_PICK_AND_DROPABLE
			application: EV_APPLICATION_IMP
		do
			erase_rubber_band
			pointer_x := a_screen_x.to_integer_16
			pointer_y := a_screen_y.to_integer_16
			application_implementation.set_pnd_pointer_coords (a_screen_x, a_screen_y)
			draw_rubber_band

			target := pointed_target
			real_target ?= target
			application ?= environment.application.implementation
			if application.pnd_motion_actions_internal /= Void then
				application.pnd_motion_actions_internal.call ([a_x, a_y, real_target])
			end

				-- Cursor needs to be constantly updated so for widgets that handle
				-- Pick and Drop themselves such as EV_GRID.
				--| FIXME IEK This could be refactored to only update cursor for widgets that
				--| need constant updating
			update_pointer_style (target)
		end

	update_pointer_style (target: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Assign correct cursor for transport to `Current'.
		do
			if
				target /= Void and then (
					target.drop_actions.accepts_pebble (pebble)
				)
			then
				if accept_cursor /= Void then
					internal_set_pointer_style (accept_cursor)
				else
					internal_set_pointer_style (default_accept_cursor)
				end
			else
				if deny_cursor /= Void then
					internal_set_pointer_style (deny_cursor)
				else
					internal_set_pointer_style (default_deny_cursor)
				end
			end
		end

	pointed_target: EV_ABSTRACT_PICK_AND_DROPABLE is
			-- Target at mouse position.
		local
			rpt: like real_pointed_target
			widget_target: EV_WIDGET
			a: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_ABSTRACT_PICK_AND_DROPABLE]
			widget_x, widget_y: INTEGER
		do
			rpt := real_pointed_target
			Result := rpt
			widget_target ?= rpt
			if widget_target /= Void then
				a := widget_target.implementation.actual_drop_target_agent
				if a /= Void then
					widget_x := pointer_x - widget_target.screen_x
					widget_y := pointer_y - widget_target.screen_y
					Result := a.item ([widget_x, widget_y])
				end
			end
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
			-- Default target at mouse position.
		deferred
		end

	draw_rubber_band  is
			-- Erase previously drawn rubber band.
			-- Draw a rubber band between initial pick point and cursor.
		deferred
		end

	erase_rubber_band  is
			-- Erase previously drawn rubber band.
		deferred
		end

	call_pebble_function (a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Set `pebble' using `pebble_function' if present.
		do
			if pebble_function /= Void then
				pebble_function.call ([a_x, a_y])
				pebble := pebble_function.last_result
			end
		end

	modify_widget_appearance (starting: BOOLEAN) is
			-- Modify the appearence of widgets to reflect current
			-- state of pick and drop and dropable targets.
			-- If `starting' then the pick and drop is starting,
			-- else it is ending.
		local
			window_imp: EV_WINDOW_IMP
			windows: LINEAR [EV_WINDOW]
		do
			windows := application_implementation.windows
			from
				windows.start
			until
				windows.off
			loop
				window_imp ?= windows.item.implementation
				check
					window_implementation_not_void: window_imp /= Void
				end
				window_imp.update_for_pick_and_drop (starting)
				windows.forth
			end
		end

feature {EV_WIDGET, EV_WIDGET_I}

	set_pointer_style (c: EV_POINTER_STYLE) is
			-- Assign `c' to `pointer_style'
		deferred
		end

	internal_set_pointer_style (c: EV_POINTER_STYLE) is
			-- Assign `c' to `pointer_style'
		deferred
		end

	enable_capture is
			-- Grab the user input.
		deferred
		end

	disable_capture is
			-- Ungrab the user input.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	application_implementation: EV_APPLICATION_I is
			-- Application implementation object.
		do
			Result := environment.application.implementation
		end

	environment: EV_ENVIRONMENT is
			-- Environment object.
		once
			create Result
		end

	interface: EV_PICK_AND_DROPABLE
		-- Provides a common user interface to platform dependent functionality
		-- implemented by `Current'.

invariant
	user_interface_modes_mutually_exclusive:
		mode_is_pick_and_drop.to_integer +
		mode_is_drag_and_drop.to_integer +
		mode_is_target_menu.to_integer = 1
	pebble_function_takes_two_integer_open_operands:
		pebble_function /= Void implies pebble_function.valid_operands ([1,1])

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PICK_AND_DROPABLE_I

