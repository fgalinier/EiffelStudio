-- Access to a local

class LOCAL_B 

inherit

	ACCESS_B
		redefine
			enlarged, read_only, is_local, is_creatable,
			make_byte_code, register_name,
			creation_access,
			assign_code, expanded_assign_code, reverse_code,
			make_end_assignment, make_end_reverse_assignment,
			bit_assign_code
		end
	
feature 

	position: INTEGER;
			-- Position of the local in the list `locals' of the root 
			-- byte code

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end;

	read_only: BOOLEAN is false;
			-- Is the access only a read-only one ?

	type: TYPE_I is
			-- Local type
		do
			Result := context.byte_code.locals.item (position);
		end;

	is_local: BOOLEAN is True;
			-- Is Current an access to a local variable ?

	is_creatable: BOOLEAN is True;
			-- Can an access to a local variable be the target for
			-- a creation ?

	creation_access (t: TYPE_I): LOCAL_CR_B is
			-- Creation access for a local variable
		do
			!!Result.make (t);
			Result.set_position (position);
		end;

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			local_b: LOCAL_B;
		do
			local_b ?= other;
			if local_b /= Void then
				Result := position = local_b.position;
			end;
		end;

	enlarged: LOCAL_BL is
			-- Enlarge current node
		do
			!!Result;
			Result.fill_from (Current);
		end;

	register_name: STRING is
			-- The "loc<num>" string
		do
			Result := Buffer;
			Result.wipe_out;
			Result.append ("loc");
			Result.append (position.out);
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an access to a local variable.
		do
			ba.append (Bc_local);
			ba.append_short_integer (position);
		end;

	make_end_assignment (ba: BYTE_ARRAY) is
			-- Finish the assignment to the current access
		do
			ba.append_short_integer (position);
		end;

	bit_assign_code: CHARACTER is
			-- Bits assignment code 
		do
			Result := Bc_lbit_assign;
		end;

	assign_code: CHARACTER is
			-- Simple assignment code
		do
			Result := Bc_lassign;
		end;

	expanded_assign_code: CHARACTER is
			-- Expanded assignment code
		do
			Result := Bc_lexp_assign;
		end;

	make_end_reverse_assignment (ba: BYTE_ARRAY) is
			-- Generate reverse assignment byte code
		do
			ba.append_short_integer (position);
		end;

	reverse_code: CHARACTER is
			-- Reverse assignment code
		do
			Result := Bc_lreverse;
		end;

end
