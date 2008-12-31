note
	description	: "Keys used in user_data tables of codeDom objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	CODE_USER_DATA_KEYS

feature -- Implementation

	From_eiffel_code_key: INTEGER = unique
			-- Specify that DOM has been generated by eiffel parser.

	Other_names: INTEGER = unique
			-- key to retrieve all names when a declaration contains multiple names.

	Feature_clients_key: INTEGER = unique
			-- key to retrieve clients associated to feature.

	Class_construtors: INTEGER = unique
			-- Key to retrieve list of creators of a class.

	Preconditions_key: INTEGER = unique
			-- key to retrieve preconditions.

	Postconditions_key: INTEGER = unique
			-- key to retrieve postconditions.

	Retry_feature: INTEGER = unique
			-- key to retrieve retry statements.

	Require_keyword: INTEGER = unique
			-- Require keyword for pre condition.

	Require_else_keyword: INTEGER = unique
			-- Require else keyword for pre condition.

	Ensure_keyword: INTEGER = unique
			-- Ensure keyword for post condition.

	Ensure_then_keyword: INTEGER = unique
			-- Ensure then keyword for post condition.

	Assertion_tag: INTEGER = unique
			-- Key to access tag associated to an assertion.

	Elseif_statement: INTEGER = unique
			-- Boolean key to declare if a condition_statement is an elseif or a if statement.

	Constructor_name_key: INTEGER = unique
			-- key to retrieve constructor name of a creation expression.

	Start_position: INTEGER = unique
			-- Key to access the start position of current element.

	End_position: INTEGER = unique
			-- Key to access the end position of current element.

	Line_start_position: INTEGER = unique
			-- Key to access the line start position of current element.

	Line_end_position: INTEGER = unique
			-- Key to access the line end position of current element.

	Column_start_position: INTEGER = unique
			-- Key to access the column start position of current element.

	Column_end_position: INTEGER = unique;
			-- Key to access the column end position of current element.

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
end -- CODE_USER_DATA_KEYS

