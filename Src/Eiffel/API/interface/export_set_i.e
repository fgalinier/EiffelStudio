﻿note
	description: "Representation of an export clause which lists to whom a feature%N%
		%will be exported."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXPORT_SET_I

inherit
	EXPORT_I
		undefine
			copy, is_equal
		redefine
			is_set
		end

	LINKED_SET [CLIENT_I]
		rename
			is_subset as ll_is_subset,
			make as ll_make
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

create {EXPORT_SET_I}
	ll_make

feature {NONE} -- Initialization

	make (a_client: like item)
			-- Create set.
		do
			ll_make
			compare_objects
			put (a_client)
		end

feature -- Property

	is_set: BOOLEAN
			-- Is the current object an instance of EXPORT_SET_I ?
		do
			Result := True
		end

feature -- Access

	same_as (other: EXPORT_I): BOOLEAN
			-- is `other' the same as Current ?
		local
			one_client: CLIENT_I
			c1, c2: CURSOR
		do
			if attached {EXPORT_SET_I} other as other_set and then count = other_set.count then
				c1 := cursor
				c2 := other_set.cursor
				from
					Result := True
					start
				until
					after or else not Result
				loop
					one_client := item
					other_set.start
					other_set.search (one_client)
					Result :=  not other_set.after and then one_client.same_as (other_set.item)
					forth
				end
				go_to (c1)
				other_set.go_to (c2)
			end
		end

feature -- Comparison

	is_less alias "<" (other: EXPORT_I): BOOLEAN
			-- is Current less restrictive than other
		do
			if other.is_none then
				Result := True
			elseif other.is_all then
				Result := not is_all
			elseif attached {EXPORT_SET_I} other as other_set then
				Result := first.less_restrictive_than (other_set.first)
			else
				check
					must_be_a_set: False
				end
			end
		end

feature {COMPILER_EXPORTER} -- Compiler features

	equiv (other: EXPORT_I): BOOLEAN
			-- Is 'other' equivalent to Current ?
			-- [Semantic: old_status.equiv (new_status) ]
		local
			old_cursor: CURSOR
			export_client, other_export_client: CLIENT_I
		do
			if attached {EXPORT_SET_I} other as other_set then
				old_cursor := cursor
				from
					Result := True
					start
				until
					after or else not Result
				loop
					export_client := item
					other_export_client := other_set.clause (export_client.written_in)
					Result := (other_export_client /= Void)
						and then export_client.equiv (other_export_client)
					forth
				end
				go_to (old_cursor)
			else
				Result := other.is_all
			end
		end

	valid_for (client: CLASS_C): BOOLEAN
			-- Is the export valid for client `client' when the supplier is
			-- `supplier' ?
		do
			from
				start
			until
				after or else Result
			loop
				Result := item.valid_for (client)
				forth
			end
		end

	concatenation (other: EXPORT_I): EXPORT_I
			-- Concatenation of Current and `other'
		local
			new: EXPORT_SET_I
		do
			if other = Current then
					-- Return same object if identical.
				Result := other
			elseif attached {EXPORT_SET_I} other as other_set then
				if equiv (other) then
					Result := other
				else
						-- Duplication
					new := duplicate_internal (count)
						-- Merge
					new.merge (other_set)
					Result := new
				end
			elseif other.is_none then
				Result := Current
			else
				check
					other.is_all
				end
				Result := other
			end
		end

	is_subset (other: EXPORT_I): BOOLEAN
			-- Is Current clients a subset or equal with
			-- `other' clients?
		local
			l_client: CLIENT_I
			l_clients: ID_LIST
			i, nb: INTEGER
			current_group: CONF_GROUP
			l_class: CLASS_I
			l_cursor: LINKED_LIST_CURSOR [CLIENT_I]
			l_names_heap: like names_heap
		do
			if other.is_none then
				Result := False
			elseif other.is_all then
				Result := True
			elseif attached {EXPORT_SET_I} other as other_set then
				Result := True
				from
					l_names_heap := names_heap
					start
				until
					after or else not Result
				loop
					l_cursor := cursor
					from
						l_client := item
						l_clients := l_client.clients
						i := 1
						nb := l_clients.count
						current_group := l_client.written_class.group
					until
						i > nb or else not Result
					loop
						l_class := Universe.class_named (
							l_names_heap.item (l_clients.item (i)), current_group)
						if l_class /= Void and then l_class.is_compiled then
							Result := other_set.valid_for (l_class.compiled_class)
						end
						i := i + 1
					end
					go_to (l_cursor)
					forth
				end
			else
				check
					must_be_a_set: False
				end
			end
		end

	clause (written_in: INTEGER): CLIENT_I
			-- Clause of attribute `written_in'
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor
			from
				start
			until
				after or else Result /= Void
			loop
				if item.written_in = written_in then
					Result := item
				end
				forth
			end
			go_to (old_cursor)
		end

	trace
			-- Debug purpose
		do
			from
				start
			until
				after
			loop
				item.trace
				io.error.put_new_line
				forth
			end
		end

feature {EXPORT_SET_I} -- Implementation

	duplicate_internal (a_count: INTEGER): like Current
			-- Duplicate current.
		local
			l_cursor: CURSOR
		do
			l_cursor := cursor
			start
			Result := duplicate (a_count)
			go_to (l_cursor)
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
