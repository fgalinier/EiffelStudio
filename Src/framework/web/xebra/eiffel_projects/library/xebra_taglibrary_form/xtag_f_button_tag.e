note
	description: "[
		A button tag to display a html button. It has to be placed into a
		{XTAG_F_FORM_TAG}.
		Everytime the button is pushed (and the validation was successfull) a (defined)
		action is performed. The action is a function with one argument. It expects
		the filled out object of the form and returns the page to which the server
		should redirect.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_F_BUTTON_TAG

inherit
	XTAG_TAG_SERIALIZER
		redefine
			generates_render
		end

create
	make

feature -- Initialization

	make
		do
			make_base
			create value.make ("")
			create action.make ("")
		ensure
			value_attached: attached value
			action_attached: attached action
		end

feature -- Access

	value: XTAG_TAG_ARGUMENT
			-- Caption of the button

	action: XTAG_TAG_ARGUMENT
			-- Name of the feature which will be executed
			-- when the button is pressed

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_button_id: STRING
		do
			if attached {LIST [STRING]} a_variable_table [{XTAG_F_FORM_TAG}.Form_agent_var] as l_form_expressions then
				if attached {STRING} a_variable_table [{XTAG_F_FORM_TAG}.Form_var_key] as l_wrap_object_name then
					l_button_id := a_servlet_class.render_html_page.new_uid

					a_servlet_class.render_html_page.append_expression (
						response_variable_append + "(%"<button name=%%%"" +
						l_button_id + "%%%" type=%%%"submit%%%">" +
						value.value (current_controller_id) + "</button>%")")

					a_servlet_class.render_html_page.append_expression ("agent_table [%"" + l_button_id + "%"] := agent (a_request: XH_REQUEST) do")
					a_servlet_class.render_html_page.append_expression ("if fill_bean (a_request) then")
					a_servlet_class.render_html_page.append_expression (current_controller_id + "." + action.value (current_controller_id) + " (" + l_wrap_object_name + ")")
					a_servlet_class.render_html_page.append_expression ("end")
					a_servlet_class.render_html_page.append_expression ("end -- XTAG_F_BUTTON_TAG")

					l_form_expressions.extend ("if attached a_request.arguments [%"" + l_button_id + "%"] then -- XTAG_F_BUTTON_TAG")
					l_form_expressions.extend ("agent_table [%"" + l_button_id + "%"].call ([a_request])")
					l_form_expressions.extend ("end")
				end
			end
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			if a_id.is_equal ("value") then
				value := a_attribute
			end
			if a_id.is_equal ("action") then
				action := a_attribute
			end
		end

	generates_render: BOOLEAN = True

end
