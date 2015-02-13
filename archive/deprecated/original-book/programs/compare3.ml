(*
 *
 * ----------------------------------------------------------------
 *
 * @begin[license]
 * Copyright (C) 2006 Mojave Group, Caltech
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 * Author: Jason Hickey
 * @email{jyh@cs.caltech.edu}
 * @end[license]
 *)
(* less-than: negative; equal: zero; greater-than: positive *)
type comparison = int

class type comparable =
object ('self)
   method compare : 'self -> comparison
end

class int_comparable (i : int) =
object
   method representation = i
   method compare : 'a. (< representation : int; .. > as 'a) -> comparison =
      (fun j -> Pervasives.compare i j#representation)
end

class string_comparable (s : string) =
object
   method representation = s
   method compare : 'a. (< representation : string; .. > as 'a) -> comparison =
      (fun s2 -> String.compare s s2#representation)
end

class int_print_comparable i =
object
   inherit int_comparable i
   method print = print_int i
end

class string_print_comparable s =
object
   inherit string_comparable s
   method print = print_string s
end;;

let i = new int_print_comparable 10;;
let i' = (i :> int_comparable);;

let compare_int (e1 : #int_comparable) (e2 : #int_comparable) =
   e1#compare e2;;

let sort_int (l : #int_comparable list) =
   List.sort compare_int l;;

let l = List.map (new int_print_comparable) [9; 1; 3; 2];;
List.iter (fun i -> i#print) (sort_int l);;

(*
 * -*-
 * Local Variables:
 * Fill-column: 100
 * End:
 * -*-
 * vim:ts=3:et:tw=100
 *)