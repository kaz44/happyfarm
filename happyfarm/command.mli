type object_phrase = string list

type command = 
  (* Your Farm Commands *) 
  | Plant of object_phrase 
  | See (* Also in store *)
  | Observe of object_phrase
  | Water of object_phrase 
  | Spray of object_phrase
  | Harvest of object_phrase  
  (* Store Commands *)
  | Buy of object_phrase
  | Sell of object_phrase
  (* Neighbor's Farm Commands *)
  | Steal of object_phrase
  | Trade of object_phrase
  (* Spooky Forest Commands *)
  | Dig
  | Lumber
  (* Combat Commands *)
  | Attack
  | Run
  (* Universal Commands *)
  | Eat of object_phrase
  | Quit
  | Inventory
  | Go
  | Use of object_phrase

exception Malformed
exception Empty

val parse: string -> command
