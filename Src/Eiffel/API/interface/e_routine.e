﻿note
	description: "Representation of an eiffel routine."

class E_ROUTINE

inherit
	E_FEATURE
		redefine
			argument_names,
			arguments,
			associated_feature_i,
			body_id_for_ast,
			has_postcondition,
			has_precondition,
			is_once,
			is_object_relative_once,
			is_deferred,
			is_external,
			is_inline_agent,
			is_instance_free,
			is_invariant,
			locals,
			object_test_locals,
			obsolete_message,
			updated_version
		end

	SHARED_INLINE_AGENT_LOOKUP
		undefine
			is_equal
		end

feature -- Properties

	arguments: E_FEATURE_ARGUMENTS
			-- Arguments type

	has_precondition: BOOLEAN
			-- Is the routine declaring some precondition?

	has_postcondition: BOOLEAN
			-- Is the routine declaring some postcondition?

	is_instance_free: BOOLEAN
			-- <Precursor>

	is_deferred: BOOLEAN
			-- Is the routine deferred?

	is_once: BOOLEAN
			-- Is the routine declared as a once?

	is_object_relative_once: BOOLEAN
			-- Is the routine declared as object_relative once?

	is_external: BOOLEAN
			-- Is the routine declared as a once?

	is_inline_agent: BOOLEAN
			-- is the routine an inline angent
		do
			Result := inline_agent_nr /= 0
		end

	is_invariant: BOOLEAN
			-- <Precursor>		

	inline_agent_nr: INTEGER

	enclosing_body_id: INTEGER
			-- The Body id of the enclosing feature of an inline agent

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

feature -- Access

	argument_names: detachable LIST [STRING]
			-- Argument names
		do
			if attached arguments as args then
				Result := args.argument_names
			end
		end

	locals: detachable EIFFEL_LIST [LIST_DEC_AS]
		do
			if attached associated_routine_as as l_routine_as then
				Result := l_routine_as.locals
			end
		end

	object_test_locals: LIST [TUPLE [name: ID_AS; type: TYPE_AS]]
			-- Object test locals mentioned in the routine
		do
			if attached associated_routine_as as l_routine_as then
				Result := l_routine_as.object_test_locals
			end
		end

	updated_version: E_FEATURE
		do
			if is_inline_agent then
				if
					attached {EIFFEL_CLASS_C} associated_class as l_class and then
					l_class.is_valid and then
					attached l_class.inline_agent_with_nr (enclosing_body_id, inline_agent_nr) as l_feat
				then
					Result := l_feat.api_feature (l_class.class_id)
				end
			else
				Result := Precursor
			end
		end

feature {NONE} -- Implementation

	associated_routine_as: detachable ROUTINE_AS
			-- Associated routine as used to find out locals and object test locals
		local
			is_retrying: BOOLEAN
		do
			if not is_retrying then
				if is_inline_agent then
					if
						attached ast as inl_agt_feat_as and then
						attached {ROUTINE_AS}
								inline_agent_lookup.lookup_inline_agent_of_feature (inl_agt_feat_as, inline_agent_nr).content
							as r_as
					then
						Result := r_as
					end
				elseif body_index > 0 then
					if
						attached ast as feat_as and then
							--| feature_as can be Void for invariant routine
						attached {ROUTINE_AS} feat_as.body.content as r_as
					then
						Result := r_as
					end
				end
				if
					Result /= Void and then
					Result.is_built_in and then
					attached {BUILT_IN_AS} Result.routine_body as built_in_as and then
					attached built_in_as.body as feature_as and then
					attached {ROUTINE_AS} feature_as.body.content as r_as
				then
					Result := r_as
				end
			end
		rescue
			if not is_retrying then
				is_retrying := True
				retry
			end
		end

feature {FEATURE_I} -- Setting

	set_instance_free (value: BOOLEAN)
			-- Set `is_instance_free` to `value`.
		do
			is_instance_free := value
		ensure
			is_instance_free_set: is_instance_free = value
		end

	set_deferred (b: like is_deferred)
			-- Set `is_deferred' to `b'.
		do
			is_deferred := b
		end

	set_once (b: like is_once)
			-- Set `is_once' to `b'.
		do
			is_once := b;
		end;

	set_object_relative_once (b: like is_object_relative_once)
			-- Set `is_object_relative_once' to `b'.
		do
			is_object_relative_once := b
		end

	set_external (b: like is_external)
			-- Set `is_external' to `b'.
		do
			is_external := b
		end;

	set_arguments (args: like arguments)
			-- Assign `args' to `arguments'.
		do
			arguments := args
		end

	set_has_precondition (b: BOOLEAN)
			-- Assign `b' to `has_precondition'.
		do
			has_precondition := b
		end

	set_has_postcondition (b: BOOLEAN)
			-- Assign `b' to `has_postcondition'.
		do
			has_postcondition := b
		end

	set_inline_agent_nr (nr: INTEGER)
			-- Assign `nr' to `inline_agent_nr'.
		do
			inline_agent_nr := nr
		end

	set_is_invariant (b: BOOLEAN)
			-- Assign `b' to `is_invariant'.
		do
			is_invariant := b
		end

	set_enclosing_body_id (id: INTEGER)
			-- Assign `id' to `enclosing_body_id'.
		do
			enclosing_body_id := id
		end

feature {COMPILER_EXPORTER} -- Implementation

	body_id_for_ast: INTEGER
		do
			if is_inline_agent then
				Result := enclosing_body_id
			else
				Result := Precursor
			end
		end

	associated_feature_i: FEATURE_I
			-- Assocated feature_i
		do
			if is_inline_agent then
				Result := associated_class.eiffel_class_c.inline_agent_of_id (feature_id)
			else
				Result := Precursor
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
