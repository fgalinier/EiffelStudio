-- DC-set real body indexes.

class DLE_REAL_BODY_INDEX

inherit

	DLE_COMPILER_ID;
	REAL_BODY_INDEX
		undefine
			is_dynamic, compilation_id
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation
 
	counter: REAL_BODY_INDEX_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Real_body_index_counter.item (Dle_compilation)
		end

end -- class DLE_REAL_BODY_INDEX
