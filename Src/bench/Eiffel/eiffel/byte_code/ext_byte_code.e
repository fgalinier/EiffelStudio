-- Byte code for external features

class EXT_BYTE_CODE 

inherit

	STD_BYTE_CODE
		rename
			generate as old_generate
		redefine
			generate_return_exp,generate_arguments, generate_compound,
			generate_arg_declarations, is_external
		end;

	STD_BYTE_CODE
		redefine
			generate,
			generate_return_exp,generate_arguments, generate_compound,
			generate_arg_declarations, is_external
		select
			generate
		end
	
feature 

	external_name: STRING;
			-- External name to call

	encapsulated: BOOLEAN;
			-- Has the call to `external_name' to be 
			-- encapsulated ?

	c_type_desc: STRING;
			-- C type specified by the user: can be Void

	set_external_name (s: STRING) is
			-- Assign `s' to `external_name'.
		do
			external_name := s;
		end;

	set_encapsulated (e: BOOLEAN) is
			-- Assign `e' to `encapsulated'
		do
			encapsulated := e;
		end;

	set_c_type_desc (s: STRING) is
			-- Assign `s' to `c_type_desc'.
		do
			c_type_desc := s;
		end;

	is_external: BOOLEAN is
			-- Is the current byte code a byte code for external
			-- features ?
		do
			Result := True;
		end;

	generate is
			-- Byte code generation
		do
			if encapsulated then
				old_generate;
			end;
		end;

	generate_compound is
			-- Call the external function
		do
			if context.result_used or postcondition /= Void or context.has_invariant then
				generated_file.putstring ("Result = ");
			else
				generated_file.putstring ("return ");
			end;
			generated_file.putstring (external_name);
			generated_file.putchar ('(');
			generate_arguments;
			generated_file.putchar (')');
			generated_file.putchar (';');
			generated_file.new_line;
		end;

	generate_return_exp is
			-- Generate the final return
		do
			if context.result_used or postcondition /= Void or context.has_invariant then
				generated_file.putstring ("return Result;");
				generated_file.new_line;
			end;
		end;

	generate_arguments is
			-- Generate C arguments, if any, in the definition.
		local
			i, count: INTEGER;
		do
			if arguments /= Void then
				from
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					generated_file.putstring ("arg");
					generated_file.putint (i);
					i := i + 1;
					if i <= count then
						generated_file.putstring (", ");
					end;
				end;
			end;
		end;

	generate_arg_declarations is
			-- Declare C parameters, if any, as part of the definition.
		local
			arg: TYPE_I;
			i, count: INTEGER;
		do
			if arguments /= Void then
				from
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					arg := real_type (arguments.item (i));
					arg.c_type.generate (generated_file);
					generated_file.putstring ("arg");
					generated_file.putint (i);
					generated_file.putchar (';');
					generated_file.new_line;
					i := i + 1;
				end;
			end;
		end;
			
end
