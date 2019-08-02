(** A [field] represents a location in which plants can be grown and
    facilitates their planting, growth, and harvest *)
module type Field = sig

  (** [t] is the represntational type for a field *)
  type t

  (** [empty] is the empty field, represented by an empty list *)
  val empty : t

  (** [is_empty f] is true if field [f] contains no plants, else false*)
  val is_empty : t -> bool

  (** [sow] plants a seed ['a] *)
  val sow : t -> 'a -> t

  (** [harvest] harvests the specified plant, removing it from the field *)
  val remove : t -> 'a -> t

  (* (** [observe f] is a string representation of the field
       suitable for observation *)
     val observe : 'a -> 'a field -> string *)

end