indexing

	description: "Eiffel class generated by the 2.3 to 3 translator";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$";
	author: "E. Letellier, J.P. Sarkis & S. Villette";
	product: EiffelCase;
	keywords: Graphical_figure

class CLOSURE 


creation

	make

feature -- Initialization

	make is
			-- Create a closure
		do
			!!up_left;
			!!down_right;
			empty := true;
			infinite := false
		end; 
	
feature -- Access 

	up_left: COORD_XY_FIG;
			-- Upper left corner

	down_right: COORD_XY_FIG;
			-- Bottom right corner

feature -- Comparison

	includes (other: like Current): BOOLEAN is
			-- Does the rectangle surround `other'?
		require
			rectangle_exists: other /= Void;
			rectangle_not_empty: not other.empty
		do
			if not infinite  and not other.infinite then
				if not empty then
					Result := 
						other.up_left >= up_left and then 
						other.down_right <= down_right
				end
			else
				Result := true
			end
		end; -- includes

	override (clip: CLIP): BOOLEAN is
			-- Does rectangle override clip zone ?
		require
			clip /= Void and then down_right /= Void 
			and up_left /= Void  and clip.upper_left /= Void
		do
			if not infinite then
				Result := not empty and then
						(segment_override (clip.upper_left.x, clip.upper_left.x + clip.width, up_left.x, down_right.x) and then 
						segment_override (clip.upper_left.y, clip.upper_left.y + clip.height, up_left.y, down_right.y));
			else
				Result := true
			end
		end; -- override

	segment_override (a1, b1, a2, b2 : INTEGER): BOOLEAN is
		require
			b1 >= a1 and b2 >=a2
		do
				if not infinite then
					Result := ((a1 >= a2) and then (a1 <= b2)) or else
							((a1 <= a2) and then (a2 <= b1));
				else
					Result := true
				end
		end; -- segment_override


feature -- Conversion

	as_clip: CLIP is
			-- `clip` equivallent of `Current`
		do
			!! Result;
			Result.set (up_left, down_right.x-up_left.x, down_right.y-up_left.y)
		end;

feature -- Modification & Insertion

	
	set (x, y, width, height: INTEGER) is
			-- Set coordinates and size of closure.
		require
			width >= 0;
			height >= 0
		do
			wipe_out;
			if width+height > 0 then
				up_left.set (x, y);
				down_right.set (x+width, y+height);
				empty := false
			else
				empty := true
			end
		end;

	set_bound (p1, p2: COORD_XY_FIG) is
			-- Set coordinates
		require
			p1_exists: p1 /= Void;
			p2_exists: p2 /= Void
		do
			wipe_out;
			enlarge (p1);
			enlarge (p2)
		end; 

	enlarge (p: COORD_XY_FIG) is
			-- Enlarge the rectangle in order to include `p'
		require
			point_exists: p /= Void
		do
			if not infinite then
				if empty then
					up_left.set (p.x, p.y);
					down_right.set (p.x, p.y);
					empty := false
				else
					up_left.set_min (p);
					down_right.set_max (p)
				end
			end
		ensure
			not empty
		end; -- enlarge	

	merge (other: like Current) is
			-- Enlarge the rectangle in order to include `other'.
		require
			rectangle_exists: other /= Void
		do
			if not infinite and not other.infinite then
				if not other.empty then
					if empty then
						up_left.set (other.up_left.x, other.up_left.y);
						down_right.set (other.down_right.x, other.down_right.y);
						empty := false
					else
						up_left.set_min (other.up_left);
						down_right.set_max (other.down_right)
					end
				end
			else
				set_infinite
			end
		end; -- merge

	merge_clip (clip: CLIP) is
			-- Enlarge the rectangle in order to include `clip'.
		require
			clip_exists: clip /= Void
		local
			clip_up_left, clip_down_right: COORD_XY_FIG;
		do
			if not infinite then
				!!clip_up_left;
				clip_up_left.set (clip.upper_left.x, clip.upper_left.y);
				!!clip_down_right;
				clip_down_right.set
					(clip.upper_left.x+clip.width, clip.upper_left.y+clip.height);
				if empty then
					up_left.set (clip_up_left.x, clip_up_left.y);
					down_right.set (clip_down_right.x, clip_down_right.y);
					empty := false
				else
					up_left.set_min (clip_up_left);
					down_right.set_max (clip_down_right)
				end
			end
		ensure
			not empty
		end; -- merge_clip

	set_infinite is
		do
			infinite := true;
			empty := false
		ensure
			not_empty: not empty
		end;

	set_finite is
		do
			infinite := false
		end;

feature -- Removal	
	wipe_out is
			-- Wipe out the closure
		do
			empty := true;
			infinite := false
		ensure
			empty
		end -- wipe_out


feature -- Status report

	empty: BOOLEAN;
			-- Is the closure empty ?

	infinite: BOOLEAN;
			-- Infinite closure ?

invariant

	empty_implies_not_infinite: empty implies not infinite;
	infinite_implies_not_empty: infinite implies not empty


end -- class CLOSURE 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
