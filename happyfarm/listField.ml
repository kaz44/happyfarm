open Field
open Plant 

(** a [listField] is a [field] implemented as a List *)
module ListField : Field = struct

  type t = Plant list 

  let empty = []

  let is_empty s = s = []

  let sow f p = p :: f

  let remove f p = List.filter (fun x -> x = p) f

end 