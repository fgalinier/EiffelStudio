
--=========================== class COMMAND_HOLE ====================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- Hole which can receive command stones.
-- Output of behavior function.
--
--===================================================================

class COMMAND_HOLE 

inherit

	LABELS;
	ELMT_HOLE
		rename
			make as elmt_hole_make
		redefine
			stone, associated_function,
			associated_symbol, associated_label,
			compatible
		end


creation

	make

	
feature 

	make (a_parent: COMPOSITE; func: BEHAVIOR_EDITOR) is
		do
			elmt_hole_make (a_parent, func);
		end;

	stone: CMD_INST_STONE;
	
	compatible (s: CMD_INST_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

feature {NONE}

	associated_function: BEHAVIOR_EDITOR;

	associated_symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_pixmap
		end;

	associated_label: STRING is
		do
			Result := Command_label
		end

end
