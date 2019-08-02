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

let parse str : command = 
  let splitlist = String.split_on_char ' ' str in
  let filtered = List.filter (fun x -> x<>"") splitlist in
  match filtered with 
  | [] -> raise Empty 
  | "quit"::[] -> Quit
  | "see"::[] -> See 
  | "observe"::t -> Observe t 
  | "water"::t -> Water t 
  | "plant"::t -> Plant t
  | "spray"::t -> Spray t 
  | "harvest"::t -> Harvest t
  | "inventory"::[] -> Inventory
  | "go"::[] -> Go
  | "dig"::[] -> Dig
  | "lumber"::[] -> Lumber
  | "eat"::t -> Eat t
  | "steal"::t -> Steal t
  | "sell"::t -> Sell t
  | "buy"::t -> Buy t
  | "use"::t -> Use t
  | "attack"::[] -> Attack
  | "run"::[] -> Run
  | _::_ -> raise Malformed
