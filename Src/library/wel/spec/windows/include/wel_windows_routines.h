/*
 * WEL_WINDOWS_ROUTINES.H
 */

#ifndef __WEL_WINDOWS_ROUTINES__
#define __WEL_WINDOWS_ROUTINES__

#ifndef __WEL__
#	include <wel.h>
#endif

#define cwel_key_down(key) (EIF_BOOLEAN) (GetKeyState (key) & 1)	
#define cwel_key_locked(key) (EIF_BOOLEAN) (GetKeyState (key) & 0x1000)	

#endif  /* __WEL_WINDOWS_ROUTINES__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
