
class NAMER_CMD 

inherit

	EB_UNDOABLE;

feature {NONE}

	name: STRING is 
		do
			Result := Command_names.set_visual_name_cmd_name
		end; 

	failed: BOOLEAN;

	namable: NAMABLE;

	old_visual_name: STRING;

	work (argument: NAMABLE) is
		do
			namable := argument;
			if namable.visual_name /= Void then	
				old_visual_name := clone (namable.visual_name);
			end;
		end;
	
feature 

	undo is
		local
			new_name: STRING;
		do
			new_name := namable.visual_name;
			namable.set_visual_name (old_visual_name);
			old_visual_name := new_name;
		end;

	redo is
		do
			undo
		end;
	
end
