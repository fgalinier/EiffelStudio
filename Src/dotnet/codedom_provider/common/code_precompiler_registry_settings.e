indexing
	description: "Registry settings used by Eiffel Codedom Compiler for precompiler"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PRECOMPILER_REGISTRY_SETTINGS

inherit
	CODE_REGISTRY_KEYS

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature -- Access

	directory (a_ace_file_name: STRING): STRING is
			-- Precompile directory for precompile with file name `a_ace_file_name'
			-- Note: this feature does not guarentee the existence of the actual directory
		require
			non_void_ace_file_name: a_ace_file_name /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := Config_table.item (a_ace_file_name)
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

feature -- Status Report

	has_directory (a_ace_file_name: STRING): BOOLEAN is
			-- Does precompile with ace file `a_ace_file_name' have associated directory?
		require
			non_void_ace_file_name: a_ace_file_name /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Result := Config_table.has (a_ace_file_name)
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
		
feature -- Basic Operation

	add_precompile (a_ace_file_name, a_directory: STRING) is
			-- Add precompile with ace file `a_ace_file_name' to be compiled in `a_directory'.
		require
			non_void_ace_file_name: a_ace_file_name /= Void
			non_void_directory: a_directory /= Void
			not_has_directory: not has_directory (a_ace_file_name)
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Config_table.put (a_directory, a_ace_file_name)	
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

	change_precompile_directory (a_ace_file_name, a_directory: STRING) is
			-- Change directory to `a_directory' for precompile with ace file name `a_ace_file_name'.
		require
			non_void_ace_file_name: a_ace_file_name /= Void
			non_void_directory: a_directory /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Config_table.replace (a_directory, a_ace_file_name)
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end
	
	remove_precompile (a_ace_file_name: STRING) is
			-- Remove settings for precompile with ace file `a_ace_file_name'.
		require
			non_void_ace_file_name: a_ace_file_name /= Void
			has_directory: has_directory (a_ace_file_name)
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				Config_table.remove (a_ace_file_name)
			end
		rescue
			Event_manager.process_exception
			l_retried := True
			retry
		end

feature {NONE} -- Private Access

	Config_table: CODE_REGISTRY_TABLE is
			-- Table holding precompile ace files path and directories
		once
			create Result.make (Precompile_folders_key, Precompile_ace_files_key)
		end

end -- class CODE_PRECOMPILER_REGISTRY_SETTINGS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------