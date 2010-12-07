note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_COMMAND_NODE_WIDGET

inherit
	ER_COMMAND_NODE_WIDGET_IMP
		redefine
			create_interface_objects
		end

feature {NONE} -- Initialization

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do

		end

	create_interface_objects
			-- <Precursor>
		do
				-- Initialize before calling Precursor all the attached attributes
				-- from the current class.

				-- Proceed with vision2 objects creation.
			Precursor
		end

feature -- Command

	set_tree_node_data (a_data: detachable ER_TREE_NODE_COMMAND_DATA)
			--
		do
			tree_node_data := a_data
			if attached a_data as l_data then
				if attached a_data.command_name as l_command_name then
					name.set_text (l_command_name)
				else
					name.remove_text
				end

				if attached a_data.label_title as l_label_title then
					label.set_text (l_label_title)
				else
					label.remove_text
				end

				if attached a_data.large_image as l_large_image then
					large_image.set_text (l_large_image)
				else
					large_image.remove_text
				end

				if attached a_data.small_image as l_small_image then
					small_image.set_text (l_small_image)
				else
					small_image.remove_text
				end
			end
		end

feature {NONE} -- Implementation

	tree_node_data: detachable ER_TREE_NODE_COMMAND_DATA
			--

	on_text_change
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_command_name (name.text)
			end
		end

	on_label_text_change
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_label_title (label.text)
			end
		end

	on_small_image_change
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_small_image (small_image.text)
			end
		end

	on_large_image_change
			-- <Precursor>
		do
			if attached tree_node_data as l_data then
				l_data.set_large_image (large_image.text)
			end
		end

end
