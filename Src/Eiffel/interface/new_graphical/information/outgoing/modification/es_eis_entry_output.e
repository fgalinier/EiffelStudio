note
	description: "EIS entry to code"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_ENTRY_OUTPUT

inherit
	ES_EIS_SHARED

	CONF_ACCESS

	SHARED_ENCODING_CONVERTER

	CHARACTER_ROUTINES

feature -- Operation

	process (a_entry: EIS_ENTRY)
			-- Start process `a_entry'
		require
			a_entry_not_void: a_entry /= Void
		local
			l_output: STRING_32
			l_comma_needed: BOOLEAN
			l_count: INTEGER
		do
			if not is_for_conf then
				create l_output.make_from_string ({ES_EIS_TOKENS}.eis_string)
				l_output.append ({ES_EIS_TOKENS}.colon)
				l_count := l_output.count
				if attached a_entry.name as l_name and then not l_name.is_empty then
					l_output.append (quoted_string ({ES_EIS_TOKENS}.name_string + {ES_EIS_TOKENS}.value_assignment + l_name))
					l_comma_needed := True
				end
				if attached a_entry.protocol as l_protocol and then not l_protocol.is_empty then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string ({ES_EIS_TOKENS}.protocol_string + {ES_EIS_TOKENS}.value_assignment + l_protocol))
					l_comma_needed := True
				end
				if attached a_entry.source as l_source and then not l_source.is_empty then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					if l_source.has ('\') or l_source.has ('/') then
						l_output.append (quoted_string ({ES_EIS_TOKENS}.source_string + {ES_EIS_TOKENS}.value_assignment + l_source))
					else
						l_output.append (quoted_string ({ES_EIS_TOKENS}.source_string + {ES_EIS_TOKENS}.value_assignment + id_solution.pretty_source_from_id (l_source, a_entry.target_id)))
					end
					l_comma_needed := True
				end
				if attached a_entry.ref as l_ref and then not l_ref.is_empty then
					if attached a_entry.source as l_source then
						if id_solution.id_valid (l_source) then
							if id_solution.id_valid (l_ref) then
								if l_comma_needed then
									l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
									l_output.append_character ({ES_EIS_TOKENS}.space)
								end
								l_output.append (quoted_string ({ES_EIS_TOKENS}.ref_string + {ES_EIS_TOKENS}.value_assignment + id_solution.assertion_of_id (l_ref).tag.name_32))
							end
						else
							if not id_solution.id_valid (l_ref) then
								if l_comma_needed then
									l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
									l_output.append_character ({ES_EIS_TOKENS}.space)
								end
								l_output.append (quoted_string ({ES_EIS_TOKENS}.ref_string + {ES_EIS_TOKENS}.value_assignment + l_ref))
							end
						end
					else
						if not id_solution.id_valid (l_ref) then
							if l_comma_needed then
								l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
								l_output.append_character ({ES_EIS_TOKENS}.space)
							end
							l_output.append (quoted_string ({ES_EIS_TOKENS}.ref_string + {ES_EIS_TOKENS}.value_assignment + l_ref))
						end
					end
				end
				if attached a_entry.destinations as l_destination and then not l_destination.is_empty then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string ({ES_EIS_TOKENS}.destination_string + {ES_EIS_TOKENS}.value_assignment + assertions_as_code (a_entry)))
					l_comma_needed := True
				end
				if a_entry.tags /= Void and then not a_entry.tags.is_empty then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string ({ES_EIS_TOKENS}.tag_string + {ES_EIS_TOKENS}.value_assignment + tags_as_code (a_entry)))
					l_comma_needed := True
				end

				if attached a_entry.type as l_type and then l_type /= 0 then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string ({ES_EIS_TOKENS}.type_string + {ES_EIS_TOKENS}.value_assignment + type_string_from_eis_entry (a_entry)))
					l_comma_needed := True
				end

				if a_entry.override then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string ({ES_EIS_TOKENS}.override_string + {ES_EIS_TOKENS}.value_assignment + {ES_EIS_TOKENS}.true_string))
					l_comma_needed := True
				end

				if a_entry.parameters /= Void and then not a_entry.parameters.is_empty then
					if l_comma_needed then
						l_output.append_character ({ES_EIS_TOKENS}.attribute_separator)
						l_output.append_character ({ES_EIS_TOKENS}.space)
					end
					l_output.append (quoted_string (parameters_as_code (a_entry)))
				end

					-- Nothing has been added, we need to complete the syntax
				if l_output.count = l_count then
					l_output.append ({ES_EIS_TOKENS}.empty_string)
				end
			else
				create last_output_conf.make ({ES_EIS_TOKENS}.eis_string.as_lower)
				if attached a_entry.name as l_name and then not l_name.is_empty then
					last_output_conf.add_attribute ({ES_EIS_TOKENS}.name_string, l_name)
				end
				if attached a_entry.protocol as l_protocol and then not l_protocol.is_empty then
					last_output_conf.add_attribute ({ES_EIS_TOKENS}.protocol_string, l_protocol)
				end
				if attached a_entry.source as l_source and then not l_source.is_empty then
					last_output_conf.add_attribute ({ES_EIS_TOKENS}.source_string, l_source)
				end
				if a_entry.tags /= Void and then not a_entry.tags.is_empty then
					last_output_conf.add_attribute ({ES_EIS_TOKENS}.tag_string, tags_as_code (a_entry))
				end
				if a_entry.destinations /= Void and then not a_entry.destinations.is_empty then
					last_output_conf.add_attribute ({ES_EIS_TOKENS}.destination_string, assertions_as_code (a_entry))
				end
				if attached a_entry.parameters as lt_parameters and then not lt_parameters.is_empty then
					from
						lt_parameters.start
					until
						lt_parameters.after
					loop
						if not lt_parameters.key_for_iteration.is_empty then
							--|FIXME: Since .ecf does not support Unicode attribute names,
							-- we cannot write Unicode data at the moment.
								if lt_parameters.key_for_iteration.is_valid_as_string_8 then
									last_output_conf.add_attribute (lt_parameters.key_for_iteration, lt_parameters.item_for_iteration)
								end
						end
						lt_parameters.forth
					end
				end
			end
			last_output_code := l_output
		ensure
			last_output_not_void: (not is_for_conf) implies (last_output_code /= Void)
			last_output_not_void: is_for_conf implies (last_output_conf /= Void)
		end

feature -- Status report

	is_for_conf: BOOLEAN
			-- Is for configure element output?

feature -- Status change

	set_is_for_conf (a_b: BOOLEAN)
			-- Set `is_for_conf' with `a_b'
		do
			is_for_conf := a_b
		ensure
			is_for_conf_set: is_for_conf = a_b
		end

feature -- Access

	last_output_code: detachable STRING_32
			-- Last output of code.

	last_output_conf: CONF_NOTE_ELEMENT
			-- Last output of conf note.

	assertions_as_code (a_entry: EIS_ENTRY): STRING_32
		require
			a_entry_not_void: a_entry /= Void
		do
			create Result.make_empty
			if attached a_entry.destinations as lt_destinations then
				from
					lt_destinations.start
				until
					lt_destinations.after
				loop
					if not lt_destinations.item.is_empty then
						Result.append (id_solution.assertion_of_id (lt_destinations.item).tag.name_32)
						if not lt_destinations.islast then
							Result.append_character ({ES_EIS_TOKENS}.tag_separator)
							Result.append_character ({ES_EIS_TOKENS}.space)
						end
					end
					lt_destinations.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	tags_as_code (a_entry: EIS_ENTRY): STRING_32
			-- Tags as a string of code.
			-- Unquoted
		require
			a_entry_not_void: a_entry /= Void
		local
			l_found: BOOLEAN
		do
			if attached a_entry.tags as lt_tags then
				create Result.make (10)
				from
					lt_tags.start
				until
					lt_tags.after
				loop
					if not lt_tags.item.is_empty then
						Result.append (lt_tags.item)
						if not lt_tags.islast then
							Result.append_character ({ES_EIS_TOKENS}.tag_separator)
							Result.append_character ({ES_EIS_TOKENS}.space)
						end
						l_found := True
					end
					lt_tags.forth
				end
			end
			if not l_found then
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	parameters_as_code (a_entry: EIS_ENTRY): STRING_32
			-- parameters as string of code.
			-- Quoted
		require
			a_entry_not_void: a_entry /= Void
		local
			l_attr: STRING_32
			i, l_count: INTEGER
			l_value: STRING_32
			l_found: BOOLEAN
		do
			if attached a_entry.parameters as lt_parameters then
				create Result.make (10)
				from
					lt_parameters.start
					l_count := lt_parameters.count
				until
					lt_parameters.after
				loop
					i := i + 1
					create l_attr.make_from_string_general (lt_parameters.key_for_iteration)
					l_value := lt_parameters.item_for_iteration
					if not l_value.same_string ({ES_EIS_TOKENS}.void_string) then
						l_attr.append ({ES_EIS_TOKENS}.value_assignment)
						l_attr.append (l_value)
						l_found := True
					end
					Result.append (l_attr)
					if i < l_count then
						Result.append_character ({ES_EIS_TOKENS}.attribute_separator)
						Result.append_character ({ES_EIS_TOKENS}.space)
					end
					lt_parameters.forth
				end
			end
			if not l_found then
			 	create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	quoted_string (a_string: STRING_32): STRING_32
			-- Quoted `a_string'
		require
			a_string_not_void: a_string /= Void
		do
			Result := eiffel_string_32 (a_string)
			Result.prepend_character ('%"')
			Result.append_character ('%"')
		ensure
			Result_not_void: Result /= Void
		end


note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
