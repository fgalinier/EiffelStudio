note
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	PROMPT_WINDOWS

inherit
	TERMINAL_IMP
		rename
			make as terminal_make
		redefine
			class_name
		end

	PROMPT_I

create
	make

feature {NONE} -- Initialization

	make (a_prompt: PROMPT; man: BOOLEAN; oui_parent: COMPOSITE)
		do
			managed := man
		end

feature -- Status report

	selection_text: STRING
			-- Return the selected text
		do
			if realized then
				Result := selection_edit.text
			else
				Result := private_selection_text
			end
		end

feature -- Status setting

	hide_apply_button
			-- Make apply button invisible.
		do
			apply_shown := False
			if exists then
				apply_button.hide
				resize_children
			end
		end

	hide_cancel_button
			-- Make cancel button invisible.
		do
			cancel_shown := False
			if exists then
				cancel_button.hide
				resize_children
			end
		end

	hide_help_button
			-- Make help button invisible.
		do
			help_shown := False
			if exists then
				help_button.hide
				resize_children
			end
		end

	hide_ok_button
			-- Make ok button invisible.
		do
			ok_shown := False
			if exists then
				ok_button.hide
				resize_children
			end
		end

	set_apply_label (a_label: STRING)
			-- Set `a_label' as label for apply button,
			-- by default this label is `apply'.
		do
			if exists then
				apply_button.set_text (a_label.twin)
				resize_children
			end
			private_apply_label := a_label.twin
		end

	set_cancel_label (a_label: STRING)
			-- Set `a_label' as label for cancel button,
			-- by default this label is `cancel'.
		do
			if exists then
				cancel_button.set_text (a_label)
				resize_children
			end
			private_cancel_label := a_label.twin
		end

	set_help_label (a_label: STRING)
			-- Set `a_label' as label for help button,
			-- by default this label is `help'.
		do
			private_help_label:= a_label.twin
			if exists then
				help_button.set_text (a_label)
				resize_children
			end
		end

	set_ok_label (a_label: STRING)
			-- Set `a_label' as label for ok button,
			-- by default this label is `ok'.
		do
			private_ok_label := a_label.twin
			if exists then
				ok_button.set_text (a_label)
				resize_children
			end
		end

	set_selection_label (a_label: STRING)
			-- Set `a_label' as selection label,
			-- by default this label is `selection'.
		do
			if a_label /= Void then
				private_selection_label := a_label.twin
			else
				private_selection_label := Void
			end
			if exists then
				selection_static.set_text (a_label)
				resize_children
			end
		end

	set_selection_text (a_text: STRING)
			-- Current text in selection box
		do
			private_selection_text := a_text.twin
			if exists then
				selection_edit.set_text (a_text)
				resize_children
			end
		end

	show_apply_button
			-- Make apply button visible.
		do
			apply_shown := True
			if exists then
				apply_button.show
				resize_children
			end
		end

	show_cancel_button
			-- Make cancel button visible.
		do
			cancel_shown := True
			if exists then
				cancel_button.show
				resize_children
			end
		end

	show_help_button
			-- Make help button visible.
		do
			help_shown := True
			if exists then
				help_button.show
				resize_children
			end
		end

	show_ok_button
			-- Make ok button visible.
		do
			ok_shown := True
			if exists then
				ok_button.show
				resize_children
			end
		end

feature -- Element change

	add_apply_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute
			-- when apply button is activated.
		do
			apply_actions.add (Current, a_command, arg)
		end

	add_ok_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute
			-- when ok button is activated.
		do
			ok_actions.add (Current, a_command, arg)
		end

	add_cancel_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute
			-- when cancel button is activated.
		do
			cancel_actions.add (Current, a_command, arg)
		end

	add_help_action (a_command: COMMAND; arg: ANY)
			-- Add `a_command' to the list of action to execute
			-- when help button is activated.
		do
			help_actions.add (Current, a_command, arg)
		end

feature -- Removal

	remove_apply_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to
			-- execute when apply button is activated.
		do
			apply_actions.remove (Current, a_command, arg)
		end

	remove_cancel_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to
			-- execute when cancel button is activated.
		do
			cancel_actions.remove (Current, a_command, arg)
		end

	remove_help_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to
			-- execute when help button is activated.
		do
			help_actions.remove (Current, a_command, arg)
		end

	remove_ok_action (a_command: COMMAND; arg: ANY)
			-- Remove `a_command' from the list of action to
			-- execute when ok button is activated.
		do
			ok_actions.remove (Current, a_command, arg)
		end

feature {NONE} -- Implementation

	resize_children
			-- resize children with an appropriate size.
		do
			check
				to_do: False
			end
		end

	ok_shown: BOOLEAN

	apply_shown: BOOLEAN

	help_shown: BOOLEAN

	cancel_shown: BOOLEAN

	private_ok_label: STRING

	private_apply_label: STRING

	private_cancel_label: STRING

	private_help_label: STRING

	private_selection_text: STRING

	private_selection_label: STRING

	ok_button: WEL_PUSH_BUTTON

	help_button: WEL_PUSH_BUTTON

	cancel_button: WEL_PUSH_BUTTON

	apply_button: WEL_PUSH_BUTTON

	selection_edit: WEL_EDIT

	selection_static: WEL_STATIC

	class_name: STRING
			-- Class name
		once
			Result := "EvisionPrompt"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- PROMPT_WINDOWS

