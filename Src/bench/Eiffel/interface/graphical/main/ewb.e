indexing

	description: 
		"Abstract root class for gui eiffelbench class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB

inherit

	WINDOWS;
	EIFFEL_ENV;
	ISED_X_SLAVE;
	GRAPHICS;
	ARGUMENTS
		rename
			command_line as arguments_line
		end
	SHARED_BENCH_LICENSES;
	SHARED_CONFIGURE_RESOURCES;
	SHARED_BATCH_COMPILER;
	SHARED_EIFFEL_PROJECT

feature -- Initialization

	make is
			-- Create and map the first window: the system window.
		local
			screen: SCREEN;
			temp: STRING;
			new_resources: EB_RESOURCES
		do
			if not retried then
					-- Check that environment variables
					-- are properly set.
				temp := Execution_environment.get ("EIFFEL4");
				if (temp = Void) or else temp.empty then
					io.error.putstring 
						("ISE Eiffel4: the environment variable $EIFFEL4 is not set%N");
					die (-1)
				end;
				temp := Execution_environment.get ("PLATFORM");
				if (temp = Void) or else temp.empty then
					io.error.putstring 
						("ISE Eiffel4: the environment variable $PLATFORM is not set%N");
					die (-1)
				end;

					-- Read the resource files

				if argument_count > 0 and then
					(argument (1).is_equal ("-bench") or
					else argument (1).is_equal ("-from_bench"))
				then
					Eiffel_project.set_batch_mode (False);
					init_connection (argument (1).is_equal ("-bench"));
					if init_license then
						if toolkit = Void then end;
						init_windowing;
						iterate
					end;
				else
					Eiffel_project.set_batch_mode (True);
					if init_license then
						!! new_resources.initialize;
						start_batch_compiler;
						discard_licenses;
					end;
				end;
			else
					-- Ensure clean exit in case of exception
				die (-1)
			end;
		rescue
			discard_licenses;
			if not Eiffel_project.batch_mode then
					-- The rescue in BASIC_ES will display the tag
				io.error.putstring ("ISE Eiffel4: Session aborted%N");
				io.error.putstring ("Exception tag: ");
				temp := original_tag_name;
				if temp /= Void then
					io.error.putstring (temp);
				end;
				io.error.new_line;
			end;
			if not fail_on_rescue then
				retried := True;
				retry
			end;
		end;

feature -- Properties

	retried: BOOLEAN;
			-- For rescues

end -- class EWB
