note
	description: "[
		Handles requests and delegates them to the appropriate servlet. Is
		reponsible for sending back the response to the client.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	SERVLET_HANDLER

create
	make

feature {NONE} -- Initialization

	make
		do
			create {HASH_TABLE[STATELESS_SERVLET, STRING]} stateless_servlets.make (10)
		end

feature -- Access

	stateless_servlets: TABLE [STATELESS_SERVLET, STRING]
			-- The stateless servlets

feature -- Processing

	process (a_request: REQUEST; a_socket: NETWORK_STREAM_SOCKET)
			-- Processes an incoming request and sends it back to the server
		do
		   	a_socket.independent_store (handle_request(a_request))
	       	a_socket.close
		end

	handle_request (request: REQUEST): RESPONSE
			-- Routes the request to the appropriate controller
		local
			servlet: detachable SERVLET
		do
			servlet := find_servlet (request)
			if attached servlet then
				Result := servlet.handle_request (request)
			else
				create Result.make
				Result.text.put_string ("Application not found: %"" + request.file_identifier + "%"")
			end
		end

	find_servlet (request: REQUEST): detachable SERVLET
			-- Searches for the servlet requested by `request'
			-- 1. Stateless servlet?
			-- 2. Servlet in session?
			-- 3. If not found := Void
		do
			if attached {STATELESS_SERVLET} stateless_servlets [request.file_identifier] as servlet then
				Result := servlet
			else
				--Result := request.session.get_stateful_servlet
			end
		end

--	extract_web_app_name (message: STRING): STRING
--			-- Extracts the webapp name from the get-parameter.
--		do
--			Result := message.substring (16, message.count)
--			Result := Result.substring (1, Result.substring_index (" ", 1)-1)
--		end
--		
	--	build_request (message: STRING): REQUEST
--			-- Transforms a plain text message into a {REQUEST} object
--			-- for further use in the servlet.
--			-- Session is retrieved and set
--		do
--			-- TODO: Proper session creation, management etc.
--			--create Result.make (extract_web_app_name (message).as_upper + "_SERVLET", create {SESSION})
--			create Result.make_from_string (message)
--		end


note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
