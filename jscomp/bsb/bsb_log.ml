(* Copyright (C) 2017- Authors of BuckleScript
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)

let color_enabled = ref (Unix.isatty Unix.stdin)
let set_color ppf =
  Format.pp_set_formatter_tag_functions ppf 
    ({ (Format.pp_get_formatter_tag_functions ppf () ) with
       mark_open_tag = (fun s ->  if !color_enabled then  Ext_color.ansi_of_tag s else Ext_string.empty) ;
       mark_close_tag = (fun _ ->  if !color_enabled then Ext_color.reset_lit else Ext_string.empty);
     })


let setup () = 
  begin 
    Format.pp_set_mark_tags Format.std_formatter true ;
    Format.pp_set_mark_tags Format.err_formatter true;
    Format.pp_set_mark_tags Format.str_formatter true;
    set_color Format.std_formatter ; 
    set_color Format.err_formatter;
    set_color Format.str_formatter
  end



let print_string_args (args : string array) =
  for i  = 0 to Array.length args - 1 do
    print_string (Array.unsafe_get args i) ;
    print_string Ext_string.single_space;
  done ;
  print_newline ()
