indexing
	description: "Class text field in class tool.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_TEXT_FIELD

inherit

	WINDOWS;
	EB_CONSTANTS;
	COMMAND;
	TEXT_FIELD
		rename
			make as text_field_make
		end;
	SHARED_EIFFEL_PROJECT

creation

	make

feature -- Initialization

	make (a_parent: COMPOSITE; a_tool: CLASS_W) is
			-- Initialize the text field "Class_name".
			-- Set up the activate actions.
		do
			text_field_make ("", a_parent);
			add_activate_action (Current, Void);
			tool := a_tool
		end;

feature -- Properties

	new_class_win: NEW_CLASS_W;
			-- New window for a class tool.

	tool: CLASS_W;
			-- Class tool

feature -- Updating

	update_choice_position is
			-- Update the text area after a resize
		do
			if choice /= Void then
				choice.update_position
			end;
		end;

	update_text is
			-- Update the text area after a resize
		do
			set_text (text)
		end;

feature -- Closure

	close_choice_window is
		do
			if choice /= Void then	
				choice.popdown
			end
		end

feature {NONE} -- Implementation

	choice: CHOICE_W;
			-- Window for user choices.

	class_list: LINKED_LIST [CLASS_I];
			-- List of classes displayed in `choice'

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute the command.
		local
			classi_stone: CLASSI_STONE;
			classc_stone: CLASSC_STONE;
			cname: STRING;
			clusters: LINKED_LIST [CLUSTER_I];
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I];
			class_i: CLASS_I;
			mp: MOUSE_PTR;
			choice_position: INTEGER;
			at_pos: INTEGER;
			cluster: CLUSTER_I;
			cluster_name: STRING;
			pattern: STRING_PATTERN
--			matcher: KMP_WILD
			classes: EXTEND_TABLE [CLASS_I, STRING]
		do
			if (choice /= Void) and then (arg = choice) then
				check
					class_list /= Void
				end;
				choice_position := choice.position;
				if choice_position /= 0 then
					class_i := class_list.i_th (choice_position);
					cname := clone (class_i.name);
					cname.to_upper;
					set_text (cname);
					execute (class_i)
				else
					class_list := Void
				end;
			elseif project_initialized then
				class_i ?= arg;
				if class_i = Void then
					cname := clone (text);
					cname.left_adjust;
					cname.right_adjust;
					if cname.empty then
						warner (tool.popup_parent).gotcha_call (Warning_messages.w_Specify_a_class)
					else
						cname.to_lower;
						!! pattern.make (0);
						pattern.append (cname);
						if not pattern.has_wild_cards then
							!! mp.set_watch_cursor;
							at_pos := cname.index_of ('@', 1);
							if at_pos = 0 then
								class_list := Eiffel_universe.classes_with_name (cname)
								mp.restore;
								if class_list.empty then
									class_list := Void;
									if new_class_win = Void then
										!! new_class_win.make (tool)
									end;
									new_class_win.call (cname, tool.cluster)
								elseif class_list.count = 1 then
									class_i := class_list.first;
									class_list := Void
								else
									display_choice
								end
							elseif at_pos = cname.count then
								cname.head (cname.count - 1);
								set_text (cname);
								execute (Void)
							else
								cluster_name := cname.substring (at_pos + 1, cname.count)
								if at_pos > 1 then
									cname := cname.substring (1, at_pos - 1)
								else
									cname := ""
								end;
								cluster := Eiffel_universe.cluster_of_name (cluster_name);
								mp.restore;
								if cluster = Void then
									warner (tool.popup_parent).gotcha_call
										(Warning_messages.w_Cannot_find_cluster (cluster_name))
								else
									class_i := cluster.classes.item (cname)
									if class_i = Void then
										if new_class_win = Void then
											!! new_class_win.make (tool)
										end
										new_class_win.call (cname, cluster)
									end
								end	
							end
						else
							from
								!! mp.set_watch_cursor
								!! sorted_classes.make
--								!! matcher.make (cname, "")
								clusters := Eiffel_universe.clusters
								clusters.start
							until
								clusters.after
							loop
								from
									classes := clusters.item.classes
									classes.start
								until
									classes.after
								loop
--									matcher.set_text (classes.key_for_iteration) 
--									if matcher.search_for_pattern then
									if pattern.matches (classes.key_for_iteration) then
										sorted_classes.put_front (classes.item_for_iteration)
									end
									classes.forth
								end
								clusters.forth
							end

							sorted_classes.sort;
							class_list := sorted_classes;
							mp.restore;
							display_choice
						end
					end
				end;
				if class_i /= Void then
					if class_i.compiled then
						!! classc_stone.make (class_i.compiled_eclass)
						tool.process_class (classc_stone);
					else
						!! classi_stone.make (class_i)
						tool.process_classi (classi_stone);
					end
				end
			end
		end;

	display_choice is
				-- Display class names from `class_list' to `choice'.
		require
			class_list_not_void: class_list /= Void
		local
			class_names: ARRAYED_LIST [STRING];
			class_i, last_class: CLASS_I;
			cname, last_name: STRING
			first_ambiguous: BOOLEAN
		do
			!! class_names.make (class_list.count);
			from class_list.start until class_list.after loop
				class_i := class_list.item;
				cname := clone (class_i.name);
				if
					last_class /= Void and then
					last_class.name.is_equal (cname)
				then
					if not first_ambiguous then
						first_ambiguous := True
						last_name := class_names.last;
						last_name.extend ('@');
						last_name.append (last_class.cluster.cluster_name)
					end
					cname.to_upper;
					cname.extend ('@');
					cname.append (class_i.cluster.cluster_name)
				else
					cname.to_upper;
					first_ambiguous := False
				end;
				class_names.extend (cname);
				last_class := class_i;
				class_list.forth
			end;
			if choice = Void then
				!! choice.make_with_widget (parent, Current)
			end;
			choice.popup (Current, class_names, Interface_names.t_Select_class)
		end

end -- class CLASS_TEXT_FIELD
