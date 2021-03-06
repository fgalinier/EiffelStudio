note

	description: "General scale implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SCALE_I 

inherit

	FONTABLE_I;

	PRIMITIVE_I;
	
feature -- Access

	granularity: INTEGER
			-- Value of the amount to move the slider and modifie value
			-- when a move action occurs
		deferred
		ensure
			granularity_large_enough: Result >=1;
			granularity_small_enough: Result <= (maximum - minimum)
		end;

	maximum: INTEGER
			-- Maximum value of the slider
		deferred
		ensure
			maximum_greater_than_minimum: Result >= minimum
		end;

	minimum: INTEGER
			-- Minimum value of the slider
		deferred
		ensure
			minimum_smaller_than_maximum: Result <= maximum
		end;

	text: STRING
			-- Scale text
		deferred
		end;

	value: INTEGER
			-- Value of the current slider position along the scale
		deferred
		ensure
			value_large_enough: Result >= minimum;
			value_small_enough: Result <= maximum
		end

feature -- Status report

	is_horizontal: BOOLEAN
			-- Is scale oriented horizontal?
		deferred
		end;

	is_maximum_right_bottom: BOOLEAN
			-- Is maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical?
		deferred
		end;

	is_output_only: BOOLEAN
			-- Is scale mode output only?
		deferred
		end;

	is_value_shown: BOOLEAN
			-- Is value shown on the screen?
		deferred
		end;

feature -- Status setting

	set_horizontal (flag: BOOLEAN)
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		deferred
		ensure
			value_correctly_set: is_horizontal = flag
		end;

	set_maximum_right_bottom (flag: BOOLEAN)
			-- Set maximum value on the right side when orientation
			-- is horizontal or on the bottom side when orientation
			-- is vertical if `flag', and at the opposite side otherwise.
		deferred
		ensure
			maximum_value_on_right_bottom: is_maximum_right_bottom = flag
		end;

	set_output_only (flag: BOOLEAN)
			-- Set scale mode to output only if `flag' and to input/output
			-- otherwise.
		deferred
		ensure
			output_only: is_output_only = flag
		end;

	set_value_shown (b: BOOLEAN)
			-- Show scale value on the screen if `b', hide it otherwise.
		deferred
		ensure
			value_is_shown: is_value_shown = b
		end;

feature -- Element change

	add_move_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when slide
			-- is moved.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_value_changed_action (a_command: COMMAND; argument: ANY)
			-- Add `a_command' to the list of action to execute when value
			-- is changed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	set_granularity (new_granularity: INTEGER)
			-- Set amount to move the slider and modifie value when
			-- when a move action occurs to `new_granularity'.
		require
			granularity_large_enough: new_granularity >= 1;
			granularity_small_enough: new_granularity <= (maximum - minimum)
		deferred
		ensure
			set: granularity = new_granularity
		end;

	set_maximum (new_maximum: INTEGER)
			-- Set maximum value of the slider to `new_maximum'.
		require
			valid_maximum: valid_maximum (new_maximum)
		deferred
		ensure
			set: maximum = new_maximum
		end;

	set_minimum (new_minimum: INTEGER)
			-- Set minimum value of the slider to `new_minimum'.
		require
			valid_minimum: valid_minimum (new_minimum)
		deferred
		ensure
			set: minimum = new_minimum
		end;

	set_text (a_text: STRING)
			-- Set scale text to `a_text'.
		require
			not_text_void: a_text /= Void
		deferred
		ensure
			text.is_equal (a_text)
		end;

	set_value (new_value: INTEGER)
			-- Set value to `new_value'.
		require
			value_small_enough: new_value <= maximum;
			value_large_enough: new_value >= minimum
		deferred
		ensure
			set: value = new_value
		end;

feature -- Removal

	remove_move_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- slide is moved.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_value_changed_action (a_command: COMMAND; argument: ANY)
			-- Remove `a_command' from the list of action to execute when
			-- value is changed.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

feature 

	valid_maximum (a_maximum: INTEGER): BOOLEAN
			-- Is `a_maximum' valid?
		do
			Result := a_maximum > minimum
		end

	valid_minimum (a_minimum: INTEGER): BOOLEAN
			-- is `a_minimum' valid?
		do
			Result := a_minimum < maximum
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




end -- class SCALE_I

