(**[water] represents the thirst of a plant*)
type water = OK | NeedsWater | ReallyNeedsWater | Dead   

(**[health] represents the sickness of a plant*)                    
type health = OK | Sick | ReallySick | Dead 

(**[growth] represents the life cycle of a plant*)
type growth = Empty | Seed   | Halfripe   | Ripe   | Rotten | Dead 

(**[living] represents if a plant is living or dead*)
type living = Alive | Dead 

(**[item] represents something you can put in your inventory to use*)
type item = 
  {
    i_name: string;
    description: string;
    amount: int;
    item_value: int;
    hunger_value: int;
    edible: bool
  }

(**[room] represents the places in the game*)
type room = 
  {
    r_id: string;
    description: string list 
  }

(**[move] represents an attack that the player or an AI can use*)
type move = 
  {
    m_name : string;
    description : string;
    image : string;
    battle_string : string;
    (* attack is an int 0-100 *)
    attack : int; 
    (* accuracy is an int 0-100 *)
    accuracy : int;
  }

(**[plant] represents something the player can grow, harvest, and sell*)
type plant = 
  {
    name:string;
    id: string;
    image: string;
    description:string;
    seed_name:string;
    growth:growth;
    water:water;
    health: health;
    growthfactor:int;
    nowater:int;
    oknowater:int;
    nospray:int;
    oknospray:int;
    plant_time:int;
    unit_price:int;
    living:living;
    move : move
  } 

(**[enemy] represents an AI that the player can engage in combat with*)
type enemy = 
  {
    e_name : string;
    description : string;
    image : string;
    hp : int;
    move : move;
    weakness : string;
    loot : item list;
  }

(**[farm] represents the place that the player or AI grows crops*)
type farm = 
  {
    farmer_emoji : string;
    farmer_description: string;
    farmer_dialogue: string list;
    replies: string list;
    farm_name: string;
    lst: (string * plant) list ;
    inventory: item list;
    farmer:bool
  }

(**[t] represents the state of the game*)
type t =
  {
    field: (string * plant) list ;
    resources: item list;
    plant_dict : (string * plant) list;
    time : int;
    current_room : room;
    next_rooms: room list;
    all_rooms : room list; 
    hp : int;
    hunger : int;
    wallet : int;
    opponent : enemy;
    basement : farm ;
    move: move;
    farm: farm;
  }
(***** Plant Dictionary *****)
val corn : plant

val apple : plant

val peach : plant

val watermelon : plant

val cherry : plant

val strawberry : plant

val tomato : plant

val potato : plant

val banana : plant

val chad : plant

val brad : plant

val paul : plant


(***** Item Dictionary *****)
(**[gold] can be found in the forest and sold for money*)
val gold : item

(**[satanic_power] can be attained if you defeat Satan, and is necessary to win*)
val satanic_power : item

(**[lumber] can be found in the forest and sold for money*)
val lumber : item

(**[corn_seed] can be planted in a field and grows into corn*)
val corn_seed : item

(**[strawberry_seed] can be planted in a field and grows into strawberry*)
val strawberry_seed : item

(**[peach_seed] can be planted in a field and grows into peach*)
val peach_seed : item

(** [potato_seed] can be planted in a field and grows into peach *)
val potato_seed : item 

(** [watermelon_seed] can be planted in a field and grows into watermelon *)
val watermelon_seed : item

(***** Enemy Dictionary *****)

(**[worm] can be found in the forest. It will attack you if you dig there*)
val worm : enemy

(**[boar] can be found in the forest. It has a medium chance of attacking
    when you dig *)
val boar: enemy

(** [bear] can be found in the forest. It has a small chance of attacking 
     when you dig *)
val bear : enemy

(**[satan] can be found in the your basement after you plant three heads*)
val satan : enemy

(**[wandering_priest] is a wandering monster that will randomly encounter the 
   player. When defeated, the priest drops a bible.*)
val wandering_priest : enemy

(** [snake] can be found in the forest. It has a chance of attacking you 
     when you lumber *)
val snake : enemy

(**[monkey] can be found in the forest. It will attack you if you lumber there*)
val monkey : enemy

(** [dragon] can be found in the forest. It has a low chance of attacking
     when you lumber *)
val dragon : enemy

(**[neighbor1] is Chad, your first neighbor that you have to defeat. He drops
   his head as loot*)
val neighbor1: enemy

(**[neighbor2] is Brad, your second neighbor that you have to defeat. He drops
   his head as loot*)
val neighbor2 : enemy

(**[neighbor3] is Paul, your third neighbor that you have to defeat. He drops
   his head as loot*)
val neighbor3 : enemy 

(**[nothing] is the player's opponent when they are not in combat*)
val nothing : enemy

(***** Helper Functions *****)

(**[store_inv] is a list of items that you can buy at the store*)
val store_inv : item list

(**[init_state] is the starting state of the game*)
val init_state : t

(**[nullplant] is what is planted in a field slot if 
   there is no real plant there*)
val nullplant: plant

(**[neighbor] is a room that contains your next neighbor opponent*)
val neighbor: room 

(**[basement_farm] is a room that contains your satanic worshipping setup*)
val basement_farm: farm

(**[neighbor_farm] is the init state of your first opponent's farm*)
val neighbor_farm: farm

(**[neighbor2_farm] is the init state of your second opponent's farm*)
val neighbor2_farm : farm 

(**[neighbor3_farm] is the init state of your third opponent's farm*)
val neighbor3_farm : farm

(**[store] is a room that you can buy and sell things at*)
val store: room

(**[basement] is a room that you fight satan at*)
val basement: room

(**[forest] is a room that you dig or lumber at*)
val forest: room

(**[corn_cannon] is a move that deals damage after eating corn *)
val corn_cannon: move 

(** [update_hunger st] decrements hunger by a certain amount 
    depending on the current value of hunger in [st]. *)
val update_hunger : t -> int

(** [update_hp st] decrements hp if st.hunger is 0.*)
val update_hp : t -> int

(** [find_plant_in_field field plant_id] returns the plant associated with 
    the plant_id [plant_id]. 
    Raises: NoPlantInField if the plant is not in the field *)
val find_plant_in_field : (string * plant) list -> string -> plant


(**[random_plant_farm field st farm] updates farm with a 
   random plant with 50% chance planted in field *)
val random_plant_farm: (string * plant) list -> t -> farm -> farm


(**[decrease_item_amt] is the item list with the amount of the item
   corresponding to [item_name] decreased by 1.
   Raises: NoItem when the [item_name] is the name of an item that 
   does not exist in resources. *)
val decrease_item_amt: string -> item list -> int -> item list 


(**[store_inv] is the item list of purchasable things at the store. *)
val store_inv : item list 


(** [get_item_names] is a string list of all the item names in [itemlist] *)
val get_item_names : item list -> string list 

(**[water_waterstatus] returns an updated water status after you water once *)
val water_waterstatus  : plant -> water * int

(** [water_plant] returns the field with the
    plant corresponding to [plant_id] watered once*)
val water_plant : (string * plant) list -> string -> t -> (string * plant) list

(**[find_plant_name] is the plant in [plantlist] 
   that corresponds to a specific [plant_id] *)
val find_plant_name : (string * plant) list -> string -> plant

(**[spray_helper] updates the state after [plant_id] receives one spray*)
val spray_helper : t -> string -> t

(** [spray_plant_helper] updates the health of [plant_id] after one spray *)
val spray_plant_helper : string -> (string * plant) list -> health

(**[spray_plant] updates the field with [plant_id] sprayed once*)
val spray_plant: string -> (string * plant) list -> (string * plant) list

(**[water] updates the state after the 
   plant corresponding to [plant_id] is watered once*)
val water :t -> string -> t

(** [grow t plant_id] grows the plant if growthfactor is reached, 
    updates water and health status *)
val grow : t -> string -> plant

(**[harvest_ai] is the state after the ai harvests the plant
   corresponding to [plant_id] *)
val harvest_ai : t -> string -> t

(**[plant_plant] returns Illegal if there are no nullplants left in the field, 
   or updates the field with the next available nullplant turned into [plant]*)
val plant_plant :t -> string -> (string * plant) list -> (string * plant) list

(**[plant_head] returns Illegal if there are no nullplants left in the field,
   raises InvalidPlant if the plant of plant_name is not a head,  
   or updates the field with the next available nullplant turned into [plant]*)
val plant_head :t -> string -> (string * plant) list -> (string * plant) list

(**[plant_plant_state] raises FullField if the field has no more slots or
   updates the state after [plant] is planted*)
val plant_plant_state :t -> string -> t

(**[plant_head_state] raises FullField if the field has no more slots or
   updates the state after [plant] is planted*)
val plant_head_state :t -> string -> t

(**[plant_plant_state] is a state representing the world after 
   a plant is planted
   Raises [FullField] if the field has no more slots *)
val plant_plant_state2 :t -> t

(** [plant_from_plant_name st plant_name] returns the value associated with key 
    [plant_name] in the list of pairs st.plant_dict. 
    Raise: Not_found if there is no value associated with a in the list l. *)
val plant_from_plant_name : t -> string -> plant

(** [pretty_print field count acc row_len]
    is the formatted string representing the [field] *)
val pretty_print : string list -> int -> string -> int -> string

(** [print_hp_bar hp] gives hp bar as a string image representing [hp], 
    which is an int based representation of the player's hp. *)
val print_hp_bar : int -> string

(** [print_hunger_bar hunger] gives hunger bar as a string image 
    representing [hunger], which is an int based 
    representation of the player's hunger. *)
val print_hunger_bar : int -> string

(** [print_dig item] gives a string representation 
    of the [item] a player finds while digging. *)
val print_dig : item -> string

(** [make_field field] is the string containing all the formatted
    plots in the field. *)
val make_field : (string * plant) list -> string list

(** [make_plot p] is the formatted string 
    representing the plot with plant [p] *)
val make_plot: plant -> string

(** [observe_plant p_id field] is the formatted string representing 
    the current statistics of the plant matching [p_id] in field [field] 
    Raises [NoPlantInfield] if there is no plant in [field] with id [p_id]*)
val observe_plant : string -> (string * plant) list -> string

(** [harvest_plant plant] harvests the specified plant. Removing it 
    from the field and depositing the contents into the player's inventory 
    Raises [NoSuchPlantInField] if there is no plant in [field] with id [p_id]*)
val harvest_plant :(string * plant) list -> string  -> item list * string 

(** [harvest plant_id state] is the state resulting from the plant 
    corresponding to [plant_id] being harvested. 
    Updates [resources] with new inventory items
    Increments [time] by one. *)
val harvest : t -> string -> t

(** [item_from_item_name name item_list] finds the item in [item_list] 
    with it's name equal to [name].
    Raises: NoItem if there is no item with name [name]. *)
val item_from_item_name : string -> item list -> item

(**[get_id] is the id of the [plant]*)
val get_id: plant -> string 

(**[get_item_value] gets the item value of [item]*)
val get_item_value: item -> int

(**[find_room_from_id] finds the room from the room id  *)
val find_room_from_id : string -> room list -> room

(** [dig_helper t] takes in a state [t] and returns a new state with the gold
    item added to a player's resources. The new state also updates hp and 
    hunger. *)
val dig_helper : t -> t

(** [lumber_helper t] takes in a state [t] and returns a new state with lumber
    added to a player's resources. The function also prints out how many
    pieces of wood were added to the player's inventory. The new state also 
    updates hp and hunger. *)
val lumber_helper : t -> t

(** [next_rooms] takes in current room and gives room list w/o current room *)
val next_rooms: room -> room list -> room list -> room list

(**[room_id_from_room_list room_list] returns a list of room ids from the list*)
val room_id_from_room_list: room list -> string list

(** [go_state] is the state after you go to a different room*)
val go_state: room -> t -> room list -> t

(** [your_farm] is the room that represents your farm*)
val your_farm : room

(** [sell_crop state item amt] is the state resulting from the sale of 
    [amt] [item]s if the sale is valid.*)
val sell_crop : t -> string -> int -> t

(** [buy_item state item_name amt] is the state resulting from the purchase
    of [amt] [item_name]s if that purchase is legal *)
val buy_item : t -> string -> int -> t

(** [check_in_inv res item_name amt] is true if the player inventory 
    contains [item] with amount = [amt] else false *)
val check_in_inv : item list -> string -> int -> bool

(** [trade_calc player_items acc amt] is the item list 
    containing the minimum amount of items whose values add up to [amt] *)
val trade_calc : item list -> item list -> int -> item list

(** [make_trade npc_res player_res farmer_item player_items] is a pair 
    containing the item lists representing thye new inventories of both 
    the npc and the player once a trade is completed *)
val make_trade : 
  item list -> item list -> item -> item list -> item list * item list

(** [eat item state] gives a new state with updated hunger and resources based 
    on the [item] consumed and the current [state].
    Raises: NoItem if [item] is not in a player's state.resources *)
val eat : string list -> t -> t

(** [attack_helper st] returns the updated state with changed opponent hp based 
    on the player's current move. *)
val attack_helper : t -> t

(** [opponent_helper st] returns the state of the player after the opponent 
    acts in the combat. *)
val opponent_helper : t -> t

(**[caneat item st] updates the state with hunger decrease if 
   something is eaten,raises CantEat if item isn't edible*)
val caneat : item -> t -> t

(** [random_farmer] is the farm with a 
    random possibility of the neighbor appearing*)
val random_farmer : farm -> farm
(* val dialogue2 : string -> string 
   val battle : string -> string  *)

(** [update_inventory res new_items] is an item list containng the items from
    [res] with the addition of [new_items] *)
val update_inventory : item list -> item list -> item list


(** [FullField] is raised when the player tries to plant 
    something in a full field *)
exception FullField

(** [NoMoney] is raised when the player tries to 
    buy something but has no money *)
exception NoMoney

(** [NotEnough] is raised when the player tries to buy something but 
    doesn't have enough money *)
exception NotEnough

(** [CantEat] is raised when the player tries to eat something non edible *)
exception CantEat

(** [NoItem] is raised when the player tries to reference a nonexisting item *)
exception NoItem

(** [InvalidPlant] is raised when the player tries to 
    reference a nonexistent plant *)
exception InvalidPlant

(** [NoPlantInField] is raised when the player tries to reference 
    something that doesn't exist in that field *)
exception NoPlantInField

(** [NoSuchPlant] is raised when the player tries to 
    reference a nonexistent plant *)
exception NoSuchPlant

(** [NoSuchRoom] is raised when the player tries to 
    go to a room that doesn't exist *)
exception NoSuchRoom 
