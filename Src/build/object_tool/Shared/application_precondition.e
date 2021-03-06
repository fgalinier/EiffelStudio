note
	description: "Class representing a precondition."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_PRECONDITION

create
	make

feature -- Initialization

	make (an_expression: STRING)
			-- Create a precondition with 'an_expression'.
		require
			valid_precondition_expression: an_expression /= Void
		do
			precondition := an_expression			
		end

feature -- Attribute

	precondition: STRING
			-- Precondition expression

feature -- Code generation

	generated_text_for_command (formal_arg_name, actual_arg_name: STRING): STRING
			-- Generate eiffel text for a command.
			-- * changing formal arguments into actual ones
			-- * adding before queries the word `target'
			-- * changing `Current' into `target'
			-- * changing `implies' into a corresponding 
			-- * leaving `Void' as it is
		require
			valid_formal_argument: formal_arg_name /= Void and then not formal_arg_name.empty
			valid_actual_argument: actual_arg_name /= Void and then not actual_arg_name.empty
		do
			formal_argument := formal_arg_name
			actual_argument := actual_arg_name
			generate_for_routine := False
			create Result.make (0)
			Result.append ("(")
			Result.append (generate_eiffel_text (precondition))
			Result.append (")")
		end
	
	generated_text_for_routine (formal_args: ARRAYED_LIST [STRING]): STRING
			-- Generate eiffel text for a command.
			-- * changing formal arguments into actual ones
			-- * adding before queries the word `target'
			-- * changing `Current' into `target'
			-- * changing `implies' into a corresponding 
			-- * leaving `Void' as it is
		require
			arguments_not_void: formal_args /= Void
		do
			formal_arguments := formal_args
			formal_arguments.compare_objects
			generate_for_routine := True
			create Result.make (0)
			Result.append ("(")
			Result.append (generate_eiffel_text (precondition))
			Result.append (")")
		end

feature {NONE} -- Code generation

	formal_argument: STRING
			-- Formal argument name

	actual_argument: STRING
			-- Actual argument name

	formal_arguments: ARRAYED_LIST [STRING]
			-- List of formal argument names

	generate_eiffel_text (precondition_text: STRING): STRING
			-- Select what kind of expression `precondition_text' is.
		local
			i, operator_index: INTEGER
			found: BOOLEAN
		do
			
			create Result.make (0)
			i := precondition_text.substring_index (or_else_keyword, 1)
			if i > 0 then
				found := True
				operator_index := or_else_index
			end
			if not found then
				i := precondition_text.substring_index (and_then_keyword, 1)
				if i > 0 then
					found := True
					operator_index := and_then_index
				end
			end
			if not found then
				i := precondition_text.substring_index (or_keyword, 1)
				if i > 0 then
					found := True
					operator_index := or_index
				end
			end
			if not found then
				i := precondition_text.substring_index (and_keyword, 1)
				if i > 0 then
					found := True
					operator_index := and_index
				end
			end
			if not found then
				i := precondition_text.substring_index (xor_keyword, 1)
				if i > 0 then
					found := True
					operator_index := xor_index
				end
			end
			if not found then
				i := precondition_text.substring_index (implies_keyword, 1)
				if i > 0 then
					found := True
					operator_index := implies_index
				end
			end
			inspect
				operator_index
			when or_else_index then
				Result.append (generated_with_operator (precondition_text, or_else_keyword, i))
			when and_then_index then
				Result.append (generated_with_operator (precondition_text, and_then_keyword, i))
			when or_index then
				Result.append (generated_with_operator (precondition_text, or_keyword, i))
			when and_index then
				Result.append (generated_with_operator (precondition_text, and_keyword, i))
			when xor_index then
				Result.append (generated_with_operator (precondition_text, xor_keyword, i))
			when implies_index then
				Result.append (generated_with_operator (precondition_text, implies_keyword, i))
			else
				Result.append (generated_from_simple_expression (precondition_text))
			end
		end

	generated_with_operator (precondition_text, operator: STRING; i: INTEGER): STRING
			-- Generate code for a boolean operation.
		do
			create Result.make (0)
			Result.append (generate_eiffel_text (precondition_text.substring (1, i - 1)))
			Result.append (" ")
			Result.append (operator)
			Result.append (" ")
			Result.append (generate_eiffel_text (precondition_text.substring (i + operator.count, precondition_text.count)))
		end

	generated_from_simple_expression (precondition_text: STRING): STRING
			-- Generate text when `precondition_text' is a simple boolean
			-- expression (no operators).
		local
			temp_word: STRING
			i, j: INTEGER
			target_needed: BOOLEAN
			car: CHARACTER
		do
			create Result.make (0)
			from
				target_needed := True
				i := 1
			until
				i > precondition_text.count
			loop
				if precondition_text.item (i).is_digit 
					or precondition_text.item (i).is_alpha
					or precondition_text.item (i).is_equal ('_')
				then
					temp_word := next_word (precondition_text, i)
					i := i + temp_word.count
					if temp_word.is_equal ("Current") 
						or temp_word.is_equal ("current") 
					then
						Result.append ("target")
					elseif not generate_for_routine 
						and then temp_word.is_equal (formal_argument) 
					then
						Result.append (actual_argument)
					elseif generate_for_routine 
						and then formal_arguments.has (temp_word) 
					then
						j := formal_arguments.index_of (temp_word, 1)
						Result.append ("app_argument")
						Result.append_integer (j)
					elseif temp_word.is_boolean
						or temp_word.is_double
						or temp_word.is_integer
						or temp_word.is_real
					then
						Result.append (temp_word)
					elseif temp_word.is_equal ("Void") 
						or temp_word.is_equal ("void") 
						or temp_word.is_equal ("not")
						or temp_word.is_equal ("Not")
						or temp_word.is_equal ("default_pointer")
						or temp_word.is_equal ("Default_pointer")
					then
						Result.append (temp_word)
					else
						if target_needed then
							Result.append ("target.")
						end
						Result.append (temp_word)
					end					
				else
					car := precondition_text.item (i)
					if car.is_equal ('.') then
						target_needed := False
					elseif car.is_equal ('(') then
						target_needed := True
					end
					Result.append_character (car)
					i := i + 1
				end
			end
		end

	next_word (precondition_text: STRING; index: INTEGER): STRING
			-- Return the next word starting at `index' in
			-- `precondition_text'. 
		require
			character_is_valid: precondition_text.item (index).is_digit 
					or precondition_text.item (index).is_alpha
					or precondition_text.item (index).is_equal ('_') 
		local
			i: INTEGER
		do
			create Result.make (0)
			from
				i := index
			until
				i > precondition_text.count or else
				(not precondition_text.item (i).is_digit 
				and not precondition_text.item (i).is_alpha
			   	and not precondition_text.item (i).is_equal ('_')
				or precondition_text.item (i).is_equal ('.'))
			loop
				Result.append_character (precondition_text.item (i))
				i := i + 1
			end
		end

feature {NONE} -- Boolean operators

	or_keyword: STRING = " or "
			-- Boolean operator `or'

	or_index: INTEGER = unique
			-- Index for operator `or'

	and_keyword: STRING = " and "
			-- Boolean operator `and'

	and_index: INTEGER = unique
			-- Index for operator `and'

	xor_keyword: STRING = " xor "
			-- Boolean operator `xor'

	xor_index: INTEGER = unique
			-- Index for operator `xor'

	implies_keyword: STRING = " implies "
			-- Boolean operator `implies'

	implies_index: INTEGER = unique
			-- Index for operator `implies'

	or_else_keyword: STRING = " or else "
			-- Boolean operator `or else'

	or_else_index: INTEGER = unique
			-- Index for operator `or else'

	and_then_keyword: STRING = " and then "
			-- Boolean operator `and then'.

	and_then_index: INTEGER = unique
			-- Index for operator `and then'

feature {NONE} -- Attributes

	generate_for_routine: BOOLEAN;
			-- Is the precondition test generated for a routine?
			
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


end -- class APPLICATION_PRECONDITION
