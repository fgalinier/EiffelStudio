indexing
	description: "Objects that represent an EV_TITLED_WINDOW generated by Build."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIND_EIFFEL_FEATURE_NAME_DIALOG

inherit
	FIND_EIFFEL_FEATURE_NAME_DIALOG_IMP

--create
--	make
--	
--feature -- Initialization
--
--	make (a_window: MAIN_WINDOW) is
--			-- init `parent_window'.
--		require
--			non_void_a_window: a_window /= Void
--		do
--			parent_window := a_window
--			initialize
--		ensure
--			parent_window_set: parent_window = a_window implies parent_window /= Void
--		end

feature -- Access

	parent_window: MAIN_WINDOW
			-- parent window.


feature -- Status Setting

	set_parent_window (a_window: MAIN_WINDOW) is
			-- init `parent_window'.
		require
			non_void_a_window: a_window /= Void
		do
			parent_window := a_window
		ensure
			parent_window_set: parent_window = a_window implies parent_window /= Void
		end


feature {NONE} -- Implementation

	user_initialization is
			-- Called by `select_actions' of `execute'.
		local
			l_list: ARRAYED_LIST [EV_LIST_ITEM]
			cache: CACHE
			l_item: EV_LIST_ITEM
		do
			set_size (10, 10)
			--set_default_push_button (ok_btn)
			--set_default_cancel_button (cancel_btn)
		end

	on_search is
			-- Called by `change_actions' of `assemblies_combo'.
		local
			types: LINKED_LIST [SPECIFIC_TYPE]
			edit: EDIT_FACTORY
			finder: FINDER
			eiffel_class_name_to_search: STRING
		do
			create edit.make (parent_window)
			create finder
			eiffel_class_name_to_search := eiffel_class_name.text
			eiffel_class_name_to_search.to_upper
			types := finder.find_eiffel_type_name (eiffel_class_name_to_search)
			edit.edit_result_search_eiffel_type_name (types)
		end

	on_cancel is
			-- Called by `change_actions' of `assemblies_combo'.
		do
			destroy
		end

	on_enter (a_key: EV_KEY) is
			-- Called by `key_press_actions' of `eiffel_class_name'.
		local
			key_constant: EV_KEY_CONSTANTS
		do
			create key_constant
			if a_key.code = key_constant.key_enter then
				on_search
			end
		end

invariant
	non_void_parent_window: parent_window /= Void

end -- FIND_EIFFEL_FEATURE_NAME_DIALOG