-- Class id counter associated with a DC-set.

class DLE_CLASS_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	SHARED_WORKBENCH;
	CLASS_SUBCOUNTER
		redefine
			next_id, next_protected_id
		end

creation

	make

feature -- Access

	next_id: DLE_CLASS_ID is
			-- Next class id
		local
			dle_system: DLE_SYSTEM_I
		do
			count := count + 1;
			!! Result.make (count);
			dle_system ?= System;
			dle_system.dynamic_class_ids.put (Result)
		end;

	next_protected_id: DLE_CLASS_ID is
			-- Next protected class id
		local
			dle_system: DLE_SYSTEM_I
		do
			count := count + 1;
			!DLE_PROTECTED_CLASS_ID! Result.make (count);
			dle_system ?= System;
			dle_system.dynamic_class_ids.put (Result)
		end

end -- class DLE_CLASS_SUBCOUNTER
