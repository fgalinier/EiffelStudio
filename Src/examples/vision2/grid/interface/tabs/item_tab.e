indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	ITEM_TAB

inherit
	ITEM_TAB_IMP

	GRID_ACCESSOR
		undefine
			copy, default_create, is_equal
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			list_item: EV_LIST_ITEM
		do
			item_finder.set_prompt ("Item Finder : ")
			item_finder.motion_actions.extend (agent finding_item)
			create list_item.make_with_text ("None")
			pixmap_holder.extend (list_item)
			create list_item
			list_item.set_pixmap (image1)
			pixmap_holder.extend (list_item)
			create list_item
			list_item.set_pixmap (image2)
			pixmap_holder.extend (list_item)
			create list_item
			list_item.set_pixmap (image3)
			pixmap_holder.extend (list_item)
			create list_item
			list_item.set_pixmap (image4)
			pixmap_holder.extend (list_item)
			create list_item
			list_item.set_pixmap (image5)
			pixmap_holder.extend (list_item)
		end

feature {NONE} -- Implementation

	found_item: EV_GRID_ITEM
	
	finding_item (an_item: EV_GRID_ITEM) is
			--
		local
			row_index, column_index: INTEGER
		do
			if an_item /= Void then
				item_frame.enable_sensitive
				item_operations_frame.enable_sensitive
				found_item := an_item
				row_index := found_item.row.index
				column_index := found_item.column.index
				item_x_index.change_actions.block
				item_x_index.set_value (column_index)
				item_x_index.change_actions.resume
				item_y_index.change_actions.block
				item_y_index.set_value (row_index)
				item_y_index.change_actions.resume
				update_item_data (column_index, row_index)
			else
				found_item := Void
				if item_frame.is_sensitive then
					item_frame.disable_sensitive
					item_operations_frame.disable_sensitive
				end
			end
		end
	
	item_x_index_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `item_x_index'.
		do
			--found_item := grid.item (a_value, item_y_index.value)
			update_item_data (a_value, item_y_index.value)
		end
	
	item_y_index_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `item_y_index'.
		do
			--found_item := grid.item (item_x_index.value, a_value)
			update_item_data (item_x_index.value, a_value)
		end
		
	update_item_data (an_x, ay: INTEGER) is
			-- Display data for item at grid position `an_x', `a_y'.
		local
			label_item: EV_GRID_LABEL_ITEM
			deselectable: EV_DESELECTABLE
		do
			if found_item /= Void then
				main_box.enable_sensitive
				label_item ?= found_item
				if label_item /= Void then
					textable_container.enable_sensitive
					textable_entry.change_actions.block
					textable_entry.set_text (label_item.text)
					textable_entry.change_actions.resume
					left_border_container.enable_sensitive
					left_border_spin_button.change_actions.block
					left_border_spin_button.set_value (label_item.left_border)
					left_border_spin_button.change_actions.resume
					spacing_container.enable_sensitive
					spacing_spin_button.change_actions.block
					spacing_spin_button.set_value (label_item.spacing)
					spacing_spin_button.change_actions.resume
					pixmap_holder.select_actions.block
					if label_item.pixmap = Void then
						pixmap_holder.first.enable_select
					elseif label_item.pixmap = image1 then
						pixmap_holder.i_th (2).enable_select
					elseif label_item.pixmap = image2 then
						pixmap_holder.i_th (3).enable_select
					elseif label_item.pixmap = image3 then
						pixmap_holder.i_th (4).enable_select
					elseif label_item.pixmap = image4 then
						pixmap_holder.i_th (5).enable_select
					elseif label_item.pixmap = image5 then
						pixmap_holder.i_th (6).enable_select
					end
					pixmap_holder.select_actions.resume
					alignment_container.enable_sensitive
					if label_item.is_left_aligned then
						alignment_combo.i_th (1).select_actions.block
						alignment_combo.i_th (1).enable_select
						alignment_combo.i_th (1).select_actions.resume
					elseif label_item.is_center_aligned then
						alignment_combo.i_th (2).select_actions.block
						alignment_combo.i_th (2).enable_select
						alignment_combo.i_th (2).select_actions.resume
					elseif label_item.is_right_aligned then
						alignment_combo.i_th (3).select_actions.block
						alignment_combo.i_th (3).enable_select
						alignment_combo.i_th (3).select_actions.resume
					end
				else
					textable_container.disable_sensitive
					left_border_container.disable_sensitive
					spacing_container.disable_sensitive
					alignment_container.disable_sensitive
				end
				deselectable ?= found_item
				if deselectable /= Void then
					is_selected.enable_sensitive
					is_selected.select_actions.block
					if deselectable.is_selected then
						is_selected.enable_select
					else
						is_selected.disable_select
					end
					is_selected.select_actions.resume
				else
					is_selected.disable_sensitive
				end
			else
				main_box.disable_sensitive
			end
		end
		
	textable_entry_changed is
			-- Called by `change_actions' of `textable_entry'.
		local
			textable: EV_TEXTABLE
		do
			textable ?= found_item
			if textable /= Void then
				textable.set_text (textable_entry.text)
			end
		end
		
	is_selected_selected is
			-- Called by `select_actions' of `is_selected'.
		local
			deselectable: EV_DESELECTABLE
		do
			deselectable ?= found_item
			if deselectable /= Void then
				if deselectable.is_selected then
					deselectable.disable_select
				else
					deselectable.enable_select
				end
			end
		end

	remove_item_button_selected is
			-- Called by `select_actions' of `remove_item_button'.
		do
			grid.remove_item (found_item.column.index, found_item.row.index)
			update_item_data (item_x_index.value, item_y_index.value)
		end

	left_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `left_border_spin_button'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.set_left_border (a_value)
			end
		end

	spacing_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `spacing_spin_button'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.set_spacing (a_value)
			end
		end

	pixmap_holder_item_selected is
			-- Called by `select_actions' of `pixmap_holder'.			
		local
			selected_item_index: INTEGER
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				selected_item_index := pixmap_holder.index_of (pixmap_holder.selected_item, 1)
				inspect selected_item_index
				when 1 then
					label_item.remove_pixmap
				when 2 then
					label_item.set_pixmap (image1)
				when 3 then
					label_item.set_pixmap (image2)
				when 4 then
					label_item.set_pixmap (image3)
				when 5 then
					label_item.set_pixmap (image4)
				when 6 then
					label_item.set_pixmap (image5)
				else
					check
						invalid_index: False
					end
				end
			end
		end

	left_alignment_item_selected is
			-- Called by `select_actions' of `left_alignment_item'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.align_text_left
			end
		end
	
	center_alignment_item_selected is
			-- Called by `select_actions' of `center_alignment_item'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.align_text_center
			end
		end
	
	right_alignment_item_selected is
			-- Called by `select_actions' of `right_alignment_item'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.align_text_right
			end
		end

	apply_pixmap_row_button_selected is
			-- Called by `select_actions' of `apply_pixmap_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_pixmap: EV_PIXMAP
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_pixmap := original_item.pixmap
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_pixmap (original_pixmap)
				end
				counter := counter + 1
			end
		end
	
	apply_pixmap_column_selected is
			-- Called by `select_actions' of `apply_pixmap_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_pixmap: EV_PIXMAP
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_pixmap := original_item.pixmap
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_pixmap (original_pixmap)
				end
				counter := counter + 1
			end
		end
	
	apply_alignment_row_button_selected is
			-- Called by `select_actions' of `apply_alignment_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_alignment: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_alignment := original_item.text_alignment
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					if original_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left then
						label_item.align_text_left
					elseif original_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center then
						label_item.align_text_center
					else
						label_item.align_text_right
					end
					label_item.set_pixmap (original_item.pixmap)
				end
				counter := counter + 1
			end
		end
	
	apply_alignment_column_button_selected is
			-- Called by `select_actions' of `apply_alignment_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_alignment: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_alignment := original_item.text_alignment
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					if original_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left then
						label_item.align_text_left
					elseif original_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center then
						label_item.align_text_center
					else
						label_item.align_text_right
					end
					label_item.set_pixmap (original_item.pixmap)
				end
				counter := counter + 1
			end
		end
	
	apply_left_border_row_button_selected is
			-- Called by `select_actions' of `apply_left_border_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_left_border: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_left_border := original_item.left_border
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_left_border (original_left_border)
				end
				counter := counter + 1
			end
		end
	
	apply_left_border_column_button_selected is
			-- Called by `select_actions' of `apply_left_border_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_left_border: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_left_border := original_item.left_border
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_left_border (original_left_border)
				end
				counter := counter + 1
			end
		end
	
	apply_spacing_row_button_selected is
			-- Called by `select_actions' of `apply_spacing_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_spacing: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_spacing := original_item.spacing
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_spacing (original_spacing)
				end
				counter := counter + 1
			end
		end
	
	apply_spacing_column_button_selected is
			-- Called by `select_actions' of `apply_spacing_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_spacing: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_spacing := original_item.spacing
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_spacing (original_spacing)
				end
				counter := counter + 1
			end
		end

end -- class ITEM_TAB

