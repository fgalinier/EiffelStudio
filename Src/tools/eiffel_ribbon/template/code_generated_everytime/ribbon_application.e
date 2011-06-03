note
	description: "[
					Objects that represent the Ribbon Vision2 application.%
					%The original version of this class has been generated by EiffelRibbon
																									]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

class
	RIBBON_APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		local
			l_app: EV_APPLICATION
		do
			create l_app
			create_interface_objects
			main_window.show$SHOW_OTHER_WINDOWS
			l_app.launch
		end

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do
			create main_window$CREATE_OTHER_WINDOWS
		end

	main_window: MAIN_WINDOW
		-- Main window of `Current'.
$REGISTER_OTHER_WINDOWS
end
