indexing

	description:
			"Run the specified query.";
	default:	"First time: NOTHING; subsequent times: last expression.";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_RUN_PROF

inherit
	EWB_CMD
		rename
			name as run_cmd_name,
			abbreviation as run_abb,
			help_message as run_prof_help
		redefine
			loop_action
		end;
	SHARED_QUERY_VALUES
			
feature {NONE} -- Execute

	loop_action is
		do
			execute;
		end;

	execute is
			-- don't know exactly how, but that comes.
			-- maybe this is good, maybe not ( ;-) / :-( )
		local
			executer: E_SHOW_PROFILE_QUERY
		do
			create_profiler_query;
			create_profiler_options;

			if any_active_query then
				print_active_query;
					-- Do the computation.
				!! executer.make (output_window, profiler_query, profiler_options);
				if last_output /= Void then
					executer.set_last_output (last_output);
				end;
				executer.execute;
				last_output := executer.last_output;
			else
				output_window.put_string ("No active queries");
				output_window.new_line;
				io.putstring ("You should first manipulate the subqueries%N");
			end;
		end;

feature {NONE} -- Attributes

	last_output: PROFILE_INFORMATION;
		-- Last output generated by the run of the query.
		-- Needed for the query-feature last_output.

	profiler_query: PROFILER_QUERY
		-- The query to be ran by the query executer.

	profiler_options: PROFILER_OPTIONS
		-- The options to use by the query executer.

feature {NONE} -- Implementation

	any_active_query: BOOLEAN is
			-- Are there any active subqueries?
		do
			Result := profiler_query.subqueries.count >= 1;
		end;

	create_profiler_query is
			-- Creates `profiler_query'.
		do
			!! profiler_query
			profiler_query.set_subqueries (subqueries);
			profiler_query.set_subquery_operators (subquery_operators);
		end;

	create_profiler_options is
			-- Creates `profiler_options'.
		do
			!! profiler_options;
			profiler_options.set_output_names (output_names);
			profiler_options.set_filenames (filenames);
			profiler_options.set_language_names (language_names);
		end;

	print_active_query is
		do
			from
				output_window.put_string ("Query:%N======%N%N");
				subqueries.start;
				subquery_operators.start;
			until
				subqueries.after
			loop
				if subqueries.item.is_active then
					output_window.put_string (subqueries.item.column);
					output_window.put_char (' ');
					output_window.put_string (subqueries.item.operator);
					output_window.put_char (' ');
					output_window.put_string (subqueries.item.value);
					if not subquery_operators.after then
						if subquery_operators.item.is_active then
							output_window.put_char (' ');
							output_window.put_string (subquery_operators.item.actual_operator);
						end;
					end;
					output_window.put_char ('%N');
				end;
				subqueries.forth;
				if not subquery_operators.after then
					subquery_operators.forth;
				end;
			end;
		end;

end -- class EWB_RUN_PROF
