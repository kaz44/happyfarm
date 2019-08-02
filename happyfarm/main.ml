open Command
open State

(** [str_from_strlist strlist] is the string containing 
    the entries of [strlist] with spaces between the entries*)
let rec str_from_strlist (strlist: string list): string = 
  match strlist with 
  |[] -> ""
  |h::t -> 
    if List.length t >= 1 then h ^ " " ^ (str_from_strlist t) else 
      h ^(str_from_strlist t)

(** [formatted_str_from_strlist strlist] is the string containing 
    the entries of [strlist] with spaces and commas between the entries*)
let rec formatted_str_from_strlist (strlist: string list): string = 
  match strlist with 
  |[] -> ""
  |h::t -> 
    if List.length t >= 1 then h ^ " | " ^ (formatted_str_from_strlist t) else 
      h ^ (formatted_str_from_strlist t) 

let rec store_str_from_itemlist (itemlist: item list) : string = 
  match itemlist with 
  | [] -> ""
  | h::t -> 
    if List.length t >= 1 
    then h.i_name ^ ": $" ^ string_of_int h.item_value 
         ^ "\n" ^ (store_str_from_itemlist t) 
    else h.i_name ^ ": $" ^ string_of_int h.item_value  
         ^ (store_str_from_itemlist t) 


let inventorylist (list:item list) = 
  List.map (fun x -> x.i_name ^ " " ^ string_of_int x.amount ) list

(** [check_game_over st] checks if the hp of the player is at 0 based on st.hp. 
    if player's hp is 0, then a game-over message is printed 
    and the game quits. *)
let check_game_over (st : State.t) = 
  if List.mem satanic_power st.resources then (
    ANSITerminal.(print_string [red]
                    "
     ___________________66666666666__________________
     ____________66666_______________66666___________ 
     ________6666________________________666_________ 
     ______666__6_________________________6_666______ 
     ____666_____66____________________666____66_____ 
     ___66_______66666______________66666______666___ 
     __66_________6___66__________66___66_______666__ 
     _66__________66_______6666________66_________666 
     666___________66_____666_66______66___________66 
     66____________6666____________6666___________666 
     66___________6666______________6666__________666 
     66________666______________________666_______666 
     66_____666______66____________66______666____666 
     666__66666666666666666666666666666666666666__66_ 
     _66_______________6_________66______________666_ 
     __66______________66________66_____________666__ 
     ___66______________6_______66_____________666___ 
     ______666_____________666______________666______ 
     ________6666___________6_________666____________ 
     ___________66666_______6____66666_______________ 
     ____________________6666666_____________________
     ");
    ANSITerminal.(print_string [red]
                    ("You've attained the power of the devil. Congratulations. \n")); 
    exit 0 )
  else 

  if st.hp <= 0 
  then (if st.opponent = nothing then 
          (print_endline "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀";
           print_endline "hp: 💀";
           ANSITerminal.(print_string [red]
                           "Your hp has reached 0. You have failed. \nYour family starved to death.\n"); 
           exit 0)
        else if st.opponent <> nothing then 
          (print_endline "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀";
           print_endline "hp: 💀";
           ANSITerminal.(print_string [red]
                           ("You were defeated by " ^ 
                            st.opponent.e_name ^ 
                            ". Your hp has reached 0. You have failed." ^ 
                            "\nYour family starved to death.\n")); 

           exit 0)
        else (print_endline "💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀";
              print_endline "hp: 💀";
              ANSITerminal.(print_string [red]
                              "Your hp has reached 0. You have failed. \nYour family starved to death.\n"); 
              exit 0))

(** [check_opponent_hp st] checks if the hp of the opponent is 0. *)
let check_opponent_hp st = 
  if st.opponent.weakness = st.move.m_name then
    (st.opponent.hp - 3*st.move.attack) <=0 else
    (st.opponent.hp - st.move.attack)<=0

(** [check_opponent_hp st] checks if the hp of the opponent is 0. *)
let check_opponent_hp st = 
  if st.opponent.weakness = st.move.m_name then
    (st.opponent.hp - 3*st.move.attack) <=0 else
    (st.opponent.hp - st.move.attack)<=0

let rec fieldprint field = 
  match field with 
  | [] -> print_endline "";
  | h::t -> print_endline( (fst h)); fieldprint t 

let rec fieldprint2 field = 
  match field with 
  | [] -> print_endline "";
  | h::t -> print_endline( (snd h).id); fieldprint2 t 

let rec play_helper (current_state : State.t) =
  try 
    if (Random.int 10 = 0) && current_state.time >= 12 then (
      ANSITerminal.(print_string[Blink;Bold;red]
                      "A PREDATOR APPEARS IN YOUR FARM AND IS READY TO FIGHT!!!");
      ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
      play_helper (combat_helper({current_state with opponent = monkey})))
    else
      check_game_over current_state;
    print_endline "============================================================";
    print_endline(pretty_print(make_field current_state.field) (1) "" (3));
    print_endline (List.nth (current_state.current_room).description 0);    
    print_endline "";    
    print_endline("time: " ^ string_of_int current_state.time);
    print_endline("hp: " ^ print_hp_bar current_state.hp);
    print_endline("hunger: " ^ print_hunger_bar current_state.hunger); 
    print_endline "What do you want to do now? \n";
    print_endline "============================================================";
    print_string  "> ";
    match parse (read_line()) with
    | Plant p -> 
      (try 
         p
         |> str_from_strlist
         |> plant_plant_state current_state 
         |> plant_plant_state2
         |> play_helper
       with 
       | NoItem -> print_endline ("You don't have any seeds to plant this.")
       | FullField -> 
         print_endline "Your field is full." );
      play_helper( current_state)
    | See ->
      print_endline(pretty_print (make_field current_state.field) (1) "" (3) );
      play_helper(current_state)
    | Observe p ->  
      print_endline(observe_plant (str_from_strlist p) current_state.field);
      play_helper(current_state)
    | Spray p -> 
      (try          
         p
         |> str_from_strlist
         |> spray_helper current_state 
         |> plant_plant_state2
         |> play_helper 
       with
       |NoItem -> 
         print_endline "You are out of spray.";
         play_helper current_state
       |NoPlantInField -> 
         print_endline "This plant does not exist in your field.";
         play_helper ( current_state))

    | Inventory -> 
      print_endline 
        ("Your inventory contains: " 
         ^ (current_state.resources 
            |> inventorylist
            |> formatted_str_from_strlist ));
      play_helper ( current_state);

    | Water p -> 
      (try 
         p
         |> str_from_strlist
         |> find_plant_name current_state.field  
         |> get_id 
         |> water current_state 
         |> plant_plant_state2 
         |> play_helper
       with
       |NoItem -> 
         print_endline "You are out of water."; 
         play_helper ( current_state)
       |NoPlantInField -> 
         print_endline "This plant does not exist in your field.";
         play_helper ( current_state))

    | Harvest p ->
      (try 
         let harvest_info = 
           p 
           |> str_from_strlist 
           |> harvest_plant current_state.field in 
         let harvest_contents = 
           harvest_info
           |> fst 
           |> inventorylist 
           |> formatted_str_from_strlist in
         let harvest_msg = snd(harvest_info) in 
         print_endline ("You received: " ^ 
                        harvest_contents ^ "\n" ^ harvest_msg ^ "\n");
         p 
         |> str_from_strlist 
         |> harvest current_state 
         |> play_helper 
       with 
       | NoPlantInField -> 
         print_endline "This plant does not exist in your field";
         play_helper(current_state))

    | Eat t -> 
      (try 
         let food_str = str_from_strlist t in
         let food = item_from_item_name food_str current_state.resources in  
         let state = caneat food current_state in 
         print_endline ("You ate " ^ (str_from_strlist t) ^ "!"); 
         play_helper (plant_plant_state2 state);
       with 
       | NoItem ->
         print_endline ((str_from_strlist t) ^ " is not in your inventory!");
         play_helper (current_state)
       |CantEat ->  print_endline ("You can't eat that! What is wrong with u");
         play_helper (current_state))

    | Go -> 
      if Random.int 50 = 0 then (
        ANSITerminal.(print_string[Blink;Bold;red]
                        "BATTLE MODE HAS COMMENCED");
        play_helper (combat_helper
                       ({current_state with opponent = wandering_priest})))
      else 
        (print_endline ("Where do you want to go?"); 
         ANSITerminal.(print_string [blue]"🗺️  * WORLD MAP * 🗺️\n\n");  
         ([]
          |> next_rooms current_state.current_room (current_state.all_rooms) 
          |> room_id_from_room_list 
          |> formatted_str_from_strlist 
          |> print_endline );

         match read_line () with 
         | room_id when room_id = "spooky forest"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> forest_helper 

         | room_id when room_id = "your basement"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> basement_helper 

         | room_id when room_id = "the store"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> store_helper 

         | room_id when room_id = "your neighbor's house" -> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> neighbor_helper 

         | _ -> print_endline "You can't go here";
           play_helper current_state)

    | Use u ->  
      (try (let item_str = str_from_strlist u in 
            let item = item_from_item_name item_str current_state.resources in 
            let new_res = decrease_item_amt item_str current_state.resources 1 
            in
            let st = {current_state with 
                      hp = current_state.hp + item.hunger_value;
                      resources = new_res;} in
            print_endline ("You used " ^ item_str ^ "! It healed " 
                           ^ (string_of_int item.hunger_value) ^ " hp.");
            play_helper (st)) 
       with 
       | _ -> print_endline "You don't have this item";
         play_helper current_state)

    | Quit -> print_endline ("💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀");
      ANSITerminal.(print_string [red]
                      "You gave up. Your farm is gone.\nYour family starved to death.\n");
      exit 0
    | _ -> print_endline "You can't do that here!"; 
      (play_helper current_state)
  with
  | Malformed -> print_endline "Malformed input. Try again.";
    play_helper (current_state) 
  | NoSuchRoom -> print_endline "Illegal room"; 
    play_helper(current_state)  
  | _ -> print_endline "Illegal move"; 
    play_helper (current_state)  

and forest_helper (current_state : State.t) = 
  try 
    check_game_over current_state;
    print_endline "============================================================";
    print_endline (List.nth (current_state.current_room).description 0);
    print_endline "🌲☠️🌲☠️🌲☠️🌲☠️🌲☠️🌲";
    print_endline "";
    print_endline("time: " ^ string_of_int current_state.time);
    print_endline("hp: " ^ print_hp_bar current_state.hp);
    print_endline("hunger: " ^ print_hunger_bar current_state.hunger);
    print_endline "What do you want to do now? \n";
    print_endline "============================================================";
    print_string  "> ";
    match parse (read_line()) with
    | Dig -> 
      let rand = Random.int 10 in
      if rand < 5 then (
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
        forest_helper (combat_helper({current_state with opponent = worm}))
      )
      else if rand < 3 then (
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
        forest_helper (combat_helper({current_state with opponent = boar}))
      )
      else if rand < 1 then (
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
        forest_helper (combat_helper({current_state with opponent = bear}))
      )
      else print_endline (print_dig gold); 
      forest_helper (dig_helper current_state)

    | Lumber -> 
      let rand = Random.int 10 in
      if rand < 1 then (
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
        forest_helper (combat_helper({current_state with opponent = dragon}))
      )
      else if rand < 4 then (
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
        forest_helper (combat_helper({current_state with opponent = monkey}))
      )
      else if rand < 6 then (
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
        forest_helper (combat_helper({current_state with opponent = snake}))
      )
      else print_endline (print_dig lumber); 
      forest_helper (lumber_helper current_state)

    | Inventory -> 
      print_endline 
        ("Your inventory contains: " 
         ^ (current_state.resources 
            |> inventorylist
            |> formatted_str_from_strlist ));
      forest_helper current_state;

    | Eat t -> 
      (try 
         let food_str = str_from_strlist t in
         let food = item_from_item_name food_str current_state.resources in  
         let state = caneat food current_state in 
         print_endline ("You ate " ^ (str_from_strlist t) ^ "!"); 
         forest_helper (plant_plant_state2 state);
       with 
       | NoItem ->
         print_endline ((str_from_strlist t) ^ " is not in your inventory!");
         forest_helper (current_state)
       |CantEat ->  print_endline ("You can't eat that! What is wrong with u");
         forest_helper (current_state))

    | Go -> 
      if Random.int 50 = 0 then (
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
        forest_helper (combat_helper
                         ({current_state with opponent = wandering_priest})))
      else   
        (print_endline ("Where do you want to go?"); 
         ANSITerminal.(print_string [blue]"🗺️  * WORLD MAP * 🗺️\n\n");  
         ([]
          |> next_rooms current_state.current_room current_state.all_rooms 
          |> room_id_from_room_list 
          |> formatted_str_from_strlist 
          |> print_endline);

         match read_line () with 
         | room_id when room_id = "your farm" -> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> play_helper

         | room_id when room_id = "the store"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> store_helper

         | room_id when room_id = "your neighbor's house"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> neighbor_helper

         | room_id when room_id = "your basement"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> basement_helper 

         | _ -> print_endline "You can't go here";
           forest_helper current_state)

    | Use u ->        
      (try (let item_str = str_from_strlist u in 
            let item = item_from_item_name item_str current_state.resources in 
            let new_res = decrease_item_amt item_str current_state.resources 1 
            in
            let st = {current_state with 
                      hp = current_state.hp + item.hunger_value;
                      resources = new_res;} in
            print_endline ("You used " ^ item_str ^ "! It healed " 
                           ^ (string_of_int item.hunger_value) ^ " hp.");
            forest_helper (st)) 
       with 
       | _ -> print_endline "You don't have this item";
         forest_helper current_state)

    | Quit -> print_endline ("💀💀💀💀💀💀💀💀💀💀💀💀💀�����💀💀💀💀💀💀");
      ANSITerminal.(print_string [red]
                      "You gave up. Your farm is gone.\nYour family starved to death.\n");
      exit 0
    | _ -> print_endline "You can't do that here!"; 
      (forest_helper current_state)
  with
  | Malformed -> print_endline "Malformed input. Try again.";
    forest_helper current_state 
  | NoSuchRoom -> print_endline "Illegal room"; 
    forest_helper current_state 
  | _ -> print_endline "Illegal move"; 
    forest_helper current_state 

and store_helper (current_state : State.t) =
  try 
    check_game_over current_state;
    print_endline "============================================================";
    print_endline (List.nth (current_state.current_room).description 0);
    print_endline ("💰💰💰store inventory💰💰💰: \n" ^ 
                   store_str_from_itemlist ( store_inv));
    (* print_endline("💰💰💰💰💰💰💰💰💰💰💰"); *)
    print_endline "";   
    print_endline("time: " ^ string_of_int current_state.time);
    print_endline("hp: " ^ print_hp_bar current_state.hp);
    print_endline("hunger: " ^ print_hunger_bar current_state.hunger);
    (* print_endline("hunger: " ^ print_hunger_bar current_state.hunger); *)
    print_endline("funds: $" ^ string_of_int current_state.wallet);
    print_endline "What do you want to do now? \n";
    print_endline "============================================================";
    print_string  "> ";
    match parse (read_line()) with
    | Buy (h::t) -> (try (
        let item_amt = int_of_string(h) in
        let item_name = str_from_strlist t in 
        print_endline ("You bought " ^ string_of_int (item_amt) 
                       ^ " " ^ item_name);
        print_endline (item_from_item_name item_name store_inv).description;
        store_helper (buy_item current_state item_name item_amt)) 
       with 
       | NoMoney -> print_endline "You're outta money. Sad."; 
         store_helper current_state 
       | NotEnough -> print_endline "You don't have enough money. Sad."; 
         store_helper current_state)

    | Sell (h::t) -> 
      (try 
         let item_amt = int_of_string(h) in
         let item_name = str_from_strlist t in 
         print_endline ("You sold "^(string_of_int item_amt)^" "^item_name^"!");
         store_helper (sell_crop current_state item_name item_amt)
       with 
       | NoItem -> print_endline"You don't have this item";
         store_helper current_state)

    | Inventory -> 
      print_endline 
        ("Your inventory contains: " 
         ^ (current_state.resources 
            |> inventorylist
            |> formatted_str_from_strlist ));
      store_helper current_state;

    | Eat t -> 
      (try 
         let food_str = str_from_strlist t in
         let food = item_from_item_name food_str current_state.resources in  
         let state = caneat food current_state in 
         print_endline ("You ate " ^ (str_from_strlist t) ^ "!"); 
         store_helper (plant_plant_state2 state);
       with 
       | NoItem ->
         print_endline ((str_from_strlist t) ^ " is not in your inventory!");
         store_helper (current_state)
       |CantEat ->  print_endline ("You can't eat that! What is wrong with u");
         store_helper (current_state))

    | Go -> 
      if Random.int 50 < 1 then (
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
        store_helper (combat_helper
                        ({current_state with opponent = wandering_priest})))
      else 
        (print_endline ("Where do you want to go?"); 
         ANSITerminal.(print_string [blue]"🗺️  * WORLD MAP * 🗺️\n\n");  
         ([]
          |> next_rooms current_state.current_room current_state.all_rooms 
          |> room_id_from_room_list 
          |> formatted_str_from_strlist 
          |> print_endline);

         match read_line () with 
         | room_id when room_id = "your farm" -> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> play_helper

         | room_id when room_id = "spooky forest"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> forest_helper

         | room_id when room_id = "your basement"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> basement_helper

         | room_id when room_id = "your neighbor's house"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> neighbor_helper
         | _ -> print_endline "You can't go here";
           store_helper current_state)

    | Use u ->  
      (try (let item_str = str_from_strlist u in 
            let item = item_from_item_name item_str current_state.resources in 
            let new_res = decrease_item_amt item_str current_state.resources 1 
            in
            let st = {current_state with 
                      hp = current_state.hp + item.hunger_value;
                      resources = new_res;} in
            print_endline ("You used " ^ item_str ^ "! It healed " 
                           ^ (string_of_int item.hunger_value) ^ " hp.");
            store_helper (st)) 
       with 
       | _ -> print_endline "You don't have this item";
         store_helper current_state)

    | Quit -> print_endline ("💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀");
      ANSITerminal.(print_string [red]
                      "You gave up. Your farm is gone.\nYour family starved to death.\n");
      exit 0
    | _ -> print_endline "You can't do that here!"; 
      (store_helper current_state)

  with
  | Malformed -> print_endline "Malformed input. Try again.";
    store_helper current_state
  | NoSuchRoom -> print_endline "Illegal room"; 
    store_helper current_state 
  | _ -> print_endline "Illegal move"; 
    store_helper current_state 

and basement_helper (current_state: State.t) = 
  if  not(List.mem nullplant 
            (List.map (fun x -> snd x )current_state.basement.lst))
  then (ANSITerminal.(print_string [red]
                        "
     ___________________66666666666__________________
     ____________66666_______________66666___________ 
     ________6666________________________666_________ 
     ______666__6_________________________6_666______ 
     ____666_____66____________________666____66_____ 
     ___66_______66666______________66666______666___ 
     __66_________6___66__________66___66_______666__ 
     _66__________66_______6666________66_________666 
     666___________66_____666_66______66___________66 
     66____________6666____________6666___________666 
     66___________6666______________6666__________666 
     66________666______________________666_______666 
     66_____666______66____________66______666____666 
     666__66666666666666666666666666666666666666__66_ 
     _66_______________6_________66______________666_ 
     __66______________66________66_____________666__ 
     ___66______________6_______66_____________666___ 
     ______666_____________666______________666______ 
     ________6666___________6_________666____________ 
     ___________66666_______6____66666_______________ 
     ____________________6666666_____________________
     ");
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");

        basement_helper (combat_helper({current_state with opponent = satan})))
  else 
    try 
      print_endline "";    
      print_endline ("You are currently at " ^ current_state.basement.farm_name 
                     ^ " " ^ current_state.basement.farmer_emoji);
      print_endline (current_state.basement.farmer_description);
      check_game_over current_state;
      print_endline "============================================================";  
      print_endline ("You are currently at " ^ current_state.basement.farm_name 
                     ^ " " ^ current_state.basement.farmer_emoji);
      print_endline (current_state.basement.farmer_description);
      print_endline (List.nth (current_state.current_room).description 0);
      print_endline "";
      print_endline
        (pretty_print
           (make_field (current_state.basement).lst) (1) "" (3));
      print_endline "";   
      print_endline("time: " ^ string_of_int current_state.time);
      print_endline("hp: " ^ print_hp_bar current_state.hp);
      print_endline("hunger: " ^ print_hunger_bar current_state.hunger);
      print_endline "What do you want to do now? \n";
      print_endline "============================================================";
      print_string  "> ";
      match parse (read_line()) with

      | Use u ->  
        (try (let item_str = str_from_strlist u in 
              let item = item_from_item_name item_str current_state.resources in 
              let new_res = decrease_item_amt item_str current_state.resources 1 
              in
              let st = {current_state with 
                        hp = current_state.hp + item.hunger_value;
                        resources = new_res;} in
              print_endline ("You used " ^ item_str ^ "! It healed " 
                             ^ (string_of_int item.hunger_value) ^ " hp.");
              basement_helper (st)) 
         with 
         | _ -> print_endline "You don't have this item";
           basement_helper current_state)

      | Eat t -> 
        (try 
           let food_str = str_from_strlist t in
           let food = item_from_item_name food_str current_state.resources in  
           let state = caneat food current_state in 
           print_endline ("You ate " ^ (str_from_strlist t) ^ "!"); 
           basement_helper (plant_plant_state2 state);
         with 
         | NoItem ->
           print_endline ((str_from_strlist t) ^ " is not in your inventory!");
           basement_helper (current_state)
         |CantEat -> print_endline ("You can't eat that! What is wrong with u");
           basement_helper (current_state))

      | Inventory ->       
        print_endline 
          ("Your inventory contains: " 
           ^ (current_state.resources 
              |> inventorylist
              |> formatted_str_from_strlist ));
        basement_helper (plant_plant_state2 current_state);

      | Plant p -> 
        (try 
           p
           |> str_from_strlist
           |> plant_head_state current_state
           |> plant_plant_state2
           |> basement_helper
         with 
         | NoItem -> print_endline "You don't have any seeds to plant this."
         | InvalidPlant -> print_endline "You shouldn't plant this here. You should bury your evidence here instead."
         | FullField -> 
           print_endline "Your field is full." );
        basement_helper(current_state)

      | Go ->       
        if Random.int 50 < 1 then (
          ANSITerminal.(print_string[Blink;Bold;red]
                          "BATTLE MODE HAS COMMENCED");
          play_helper (combat_helper
                         ({current_state with opponent = wandering_priest})))
        else 
          (print_endline ("Where do you want to go?"); 
           ANSITerminal.(print_string [blue]"🗺️  * WORLD MAP * 🗺️\n\n");  
           ([]
            |> next_rooms current_state.current_room current_state.all_rooms 
            |> room_id_from_room_list 
            |> formatted_str_from_strlist 
            |> print_endline);

           match read_line () with 
           | room_id when room_id = "spooky forest"-> 
             []
             |> next_rooms current_state.current_room current_state.all_rooms 
             |> (current_state
                 |> go_state (find_room_from_id room_id 
                                current_state.all_rooms))
             |> plant_plant_state2 
             |> forest_helper 

           | room_id when room_id = "the store"-> 
             []
             |> next_rooms current_state.current_room current_state.all_rooms 
             |> (current_state
                 |> go_state (find_room_from_id room_id 
                                current_state.all_rooms))
             |> plant_plant_state2 
             |> store_helper 

           | room_id when room_id = "your neighbor's house" -> 
             []
             |> next_rooms current_state.current_room current_state.all_rooms 
             |> (current_state
                 |> go_state (find_room_from_id room_id 
                                current_state.all_rooms))
             |> plant_plant_state2 
             |> neighbor_helper 

           | _ -> print_endline "You can't go here";
             basement_helper current_state)

      | Quit -> print_endline ("💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀");
        ANSITerminal.(print_string [red]
                        "You gave up. Your farm is gone.\nYour family starved to death.\n");
        exit 0
      | _ -> print_endline "You can't do that here!"; 
        (basement_helper current_state)

    with
    | Malformed -> print_endline "Malformed input. Try again.";
      basement_helper current_state
    | NoSuchRoom -> print_endline "Illegal room"; 
      basement_helper current_state 
    | _ -> print_endline "Illegal move"; 
      basement_helper current_state 

and neighbor_helper (current_state : State.t) =
  try 
    check_game_over current_state;
    print_endline "============================================================";   
    print_endline ("You are currently at " ^ 
                   current_state.farm.farm_name ^ " " 
                   ^ current_state.farm.farmer_emoji);
    print_endline (current_state.farm.farmer_description);
    print_endline 
      ("FARMER'S INVENTORY: " 
       ^ ((current_state.farm).inventory
          |> inventorylist
          |> formatted_str_from_strlist ));
    check_game_over current_state;
    print_endline (List.nth (current_state.current_room).description 0);
    print_endline "";
    print_endline (pretty_print(make_field(current_state.farm).lst) (1) "" (3));
    if current_state.farm.farmer = true
    then 
      (  
        print_endline(current_state.farm.farmer_emoji 
                      ^ List.nth current_state.farm.farmer_dialogue 0);
        print_endline (List.nth current_state.farm.replies 0);
        let rec dialogue (num:int)= 
          match read_line() with 
          | "1" -> (print_endline
                      (current_state.farm.farmer_emoji ^
                       List.nth current_state.farm.farmer_dialogue 1); 
                    print_endline (List.nth current_state.farm.replies 1);
                    match read_line() with
                    | "2" -> 
                      print_endline 
                        (current_state.farm.farmer_emoji ^
                         List.nth current_state.farm.farmer_dialogue 2)
                    | "1" -> 
                      ANSITerminal.(print_string[Blink;Bold;red]
                                      "BATTLE MODE HAS COMMENCED\n");
                      if current_state.farm.farm_name = "Chad's farm" then 
                        ([]
                         |> (current_state.all_rooms
                             |> next_rooms current_state.current_room)
                         |> (({current_state with opponent = neighbor1})
                             |> combat_helper 
                             |> (current_state.all_rooms
                                 |> find_room_from_id "your farm"
                                 |> go_state))
                         |> play_helper)
                      else if current_state.farm.farm_name = "Brad's farm" then 
                        ([]
                         |> (current_state.all_rooms
                             |> next_rooms current_state.current_room)
                         |> (({current_state with opponent = neighbor2})
                             |> combat_helper 
                             |> (current_state.all_rooms
                                 |> find_room_from_id "your farm"
                                 |> go_state))
                         |> play_helper)
                      else if current_state.farm.farm_name = "Paul's farm" then 
                        ([]
                         |> (current_state.all_rooms
                             |> next_rooms current_state.current_room)
                         |> (({current_state with opponent = neighbor3})
                             |> combat_helper 
                             |> (current_state.all_rooms
                                 |> find_room_from_id "your farm"
                                 |> go_state))
                         |> play_helper)
                    | _ -> print_endline("pick a number from 1 to 2"); 
                      dialogue 10)

          | "2" -> (print_endline 
                      (current_state.farm.farmer_emoji ^
                       List.nth current_state.farm.farmer_dialogue 3);
                    print_endline (List.nth current_state.farm.replies 2);
                    match read_line() with
                    | "1" ->ANSITerminal.(print_string[Blink;Bold;red]
                                            "BATTLE MODE HAS COMMENCED");
                      if current_state.farm.farm_name = "Chad's farm" then 
                        ([]
                         |> (current_state.all_rooms
                             |> next_rooms current_state.current_room)
                         |> (({current_state with opponent = neighbor1})
                             |> combat_helper 
                             |> (current_state.all_rooms
                                 |> find_room_from_id "your farm"
                                 |> go_state))
                         |> play_helper)
                      else if current_state.farm.farm_name = "Brad's farm" then 
                        ([]
                         |> (current_state.all_rooms
                             |> next_rooms current_state.current_room)
                         |> (({current_state with opponent = neighbor2})
                             |> combat_helper 
                             |> (current_state.all_rooms
                                 |> find_room_from_id "your farm"
                                 |> go_state))
                         |> play_helper)
                      else if current_state.farm.farm_name = "Paul's farm" then 
                        ([]
                         |> (current_state.all_rooms
                             |> next_rooms current_state.current_room)
                         |> (({current_state with opponent = neighbor3})
                             |> combat_helper 
                             |> (current_state.all_rooms
                                 |> find_room_from_id "your farm"
                                 |> go_state))
                         |> play_helper)

                    | "2" ->ANSITerminal.(print_string[Blink;Bold;red]
                                            "BATTLE MODE HAS COMMENCED");
                      if current_state.farm.farm_name = "Chad's farm" then 
                        ([]
                         |> (current_state.all_rooms
                             |> next_rooms current_state.current_room)
                         |> (({current_state with opponent = neighbor1})
                             |> combat_helper 
                             |> (current_state.all_rooms
                                 |> find_room_from_id "your farm"
                                 |> go_state))
                         |> play_helper)
                      else if current_state.farm.farm_name = "Brad's farm" then 
                        ([]
                         |> (current_state.all_rooms
                             |> next_rooms current_state.current_room)
                         |> (({current_state with opponent = neighbor2})
                             |> combat_helper 
                             |> (current_state.all_rooms
                                 |> find_room_from_id "your farm"
                                 |> go_state))
                         |> play_helper)
                      else if current_state.farm.farm_name = "Paul's farm" then 
                        ([]
                         |> (current_state.all_rooms
                             |> next_rooms current_state.current_room)
                         |> (({current_state with opponent = neighbor3})
                             |> combat_helper 
                             |> (current_state.all_rooms
                                 |> find_room_from_id "your farm"
                                 |> go_state))
                         |> play_helper)
                    | _ -> print_endline("pick a number from 1 to 2"); 
                      dialogue 10)
          | "3" -> print_endline(current_state.farm.farmer_emoji 
                                 ^ " Sure, partner! What do you want?");
            let desired_plant = read_line() in 
            let farmer_inventory = current_state.farm.inventory in
            if (check_in_inv farmer_inventory desired_plant 1) 
            then let farmer_crop = 
                   item_from_item_name desired_plant farmer_inventory in
              print_endline ("I've got " ^ (string_of_int farmer_crop.amount) 
                             ^ " of those, how many do you want?");
              let player_amount = read_line() in 
              if 
                player_amount 
                |> int_of_string 
                |> check_in_inv farmer_inventory desired_plant 
              then 
                try (
                  let trade_info = 
                    trade_calc current_state.resources [] 
                      ((int_of_string player_amount)*farmer_crop.item_value) in
                  print_endline 
                    ("For " ^ player_amount 
                     ^ " " ^ desired_plant ^ " I want " 
                     ^ formatted_str_from_strlist (inventorylist trade_info) 
                     ^ ". Does that sound good to you?");
                  let player_confirm = read_line() in
                  if player_confirm = "Y" 
                  then 
                    let trade_result = 
                      make_trade 
                        farmer_inventory 
                        current_state.resources 
                        {farmer_crop with amount = int_of_string player_amount} 
                        trade_info in 
                    print_endline "Trade Succesful";
                    neighbor_helper {current_state with 
                                     resources = (snd trade_result); 
                                     farm = {current_state.farm with 
                                             inventory = (fst trade_result)}}
                  else print_endline ("That's too bad.. maybe next time"))
                with 
                |_ -> print_endline ("You don't have enough of the things I want.");
              else print_endline ("Sorry, I don't have that many")
            else (print_endline "Sorry, I don't have any of those right now.")
          | _ -> print_endline("pick a number from 1 to 3"); 
            dialogue 10 in dialogue 10 ) 
    else print_endline("");
    check_game_over current_state;
    print_endline "============================================================";  
    print_endline("time: " ^ string_of_int current_state.time);
    print_endline("hp: " ^ print_hp_bar current_state.hp);
    print_endline("hunger: " ^ print_hunger_bar current_state.hunger);
    print_endline "What do you want to do now? \n";
    print_endline "============================================================";  
    print_string  "> ";
    match parse (read_line()) with
    | Steal p -> 
      (try
         let harvest_info = 
           p 
           |> str_from_strlist 
           |> harvest_plant current_state.farm.lst in 
         let harvest_contents = 
           harvest_info
           |> fst 
           |> inventorylist 
           |> formatted_str_from_strlist in
         let harvest_msg = snd(harvest_info) in 
         print_endline ("You received: " ^ 
                        harvest_contents ^ "\n" ^ harvest_msg ^ "\n");
         if (current_state.farm).farmer = true then 
           (print_endline(current_state.farm.farmer_emoji 
                          ^" HEY NEIGHBOR! HOW DARE YOU STEAL FROM ME!!!");
            match read_line() with 
            | _ -> print_endline (current_state.farm.farmer_emoji 
                                  ^" NOTHING YOU SAY WILL HELP YOU NOW!!!"); 
              ANSITerminal.(print_string[Blink;Bold;red]
                              "BATTLE MODE HAS COMMENCED");
              if current_state.farm.farm_name = "Chad's farm" then 
                {current_state with opponent = neighbor1}
                |> combat_helper 
                |> neighbor_helper 
              else if current_state.farm.farm_name = "Brad's farm" then 
                {current_state with opponent = neighbor2}
                |> combat_helper 
                |> neighbor_helper 
              else if current_state.farm.farm_name = "Paul's farm" then 
                {current_state with opponent = neighbor3}
                |> combat_helper 
                |> neighbor_helper 
           ) 
         else (
           print_endline ("You stole: " ^ harvest_contents 
                          ^ "\n" ^ harvest_msg ^ "\n");
           print_endline ("Why did you do that?! You've committed a crime! But at least you have more food now...") );        
         p 
         |> str_from_strlist 
         |> harvest_ai current_state 
         |> neighbor_helper
       with 
       | NoPlantInField -> 
         print_endline "This plant does not exist in your field";
         neighbor_helper(current_state)
       | NoSuchPlant -> 
         print_endline "You harvested nothing. There's nothing on that plot of soil.";
         neighbor_helper(current_state))

    | Use u ->  
      (try (let item_str = str_from_strlist u in 
            let item = item_from_item_name item_str current_state.resources in 
            let new_res = decrease_item_amt item_str current_state.resources 1 
            in
            let st = {current_state with 
                      hp = current_state.hp + item.hunger_value;
                      resources = new_res;} in
            print_endline ("You used " ^ item_str ^ "! It healed " 
                           ^ (string_of_int item.hunger_value) ^ " hp.");
            neighbor_helper (st)) 
       with 
       | _ -> print_endline "You don't have this item";
         neighbor_helper current_state)

    | Eat t -> 
      (try 
         let food_str = str_from_strlist t in
         let food = item_from_item_name food_str current_state.resources in  
         let state = caneat food current_state in 
         print_endline ("You ate " ^ (str_from_strlist t) ^ "!"); 
         neighbor_helper (plant_plant_state2 state);
       with 
       | NoItem ->
         print_endline ((str_from_strlist t) ^ " is not in your inventory!");
         neighbor_helper (current_state)
       |CantEat ->  print_endline ("You can't eat that! What is wrong with u");
         neighbor_helper (current_state))

    | Inventory -> 
      print_endline 
        ("Your inventory contains: " 
         ^ (current_state.resources 
            |> inventorylist
            |> formatted_str_from_strlist ));
      neighbor_helper (plant_plant_state2 current_state);

    | Go ->       
      if Random.int 50 < 1 then (
        ANSITerminal.(print_string[Blink;Bold;red]"BATTLE MODE HAS COMMENCED");
        play_helper (combat_helper
                       ({current_state with opponent = wandering_priest})))
      else
        (print_endline ("Where do you want to go?"); 
         ANSITerminal.(print_string [blue]"🗺️  * WORLD MAP * 🗺️\n\n");  
         ([]
          |> next_rooms current_state.current_room current_state.all_rooms 
          |> room_id_from_room_list 
          |> formatted_str_from_strlist 
          |> print_endline);

         match read_line () with 
         | room_id when room_id = "your farm" -> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> play_helper

         | room_id when room_id = "spooky forest"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> forest_helper

         | room_id when room_id = "the store"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> store_helper

         | room_id when room_id = "your basement"-> 
           []
           |> next_rooms current_state.current_room current_state.all_rooms 
           |> (current_state
               |> go_state (find_room_from_id room_id current_state.all_rooms))
           |> plant_plant_state2 
           |> basement_helper 

         | _ -> print_endline "You can't go here";
           neighbor_helper current_state)

    | Quit -> print_endline ("💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀");
      ANSITerminal.(print_string [red]
                      "You gave up. Your farm is gone.\nYour family starved to death.\n");
      exit 0
    | _ -> print_endline "You can't do that here!"; 
      (neighbor_helper current_state)
  with
  | Malformed -> print_endline "Malformed input. Try again.";
    neighbor_helper current_state
  | NoSuchRoom -> print_endline "Illegal room"; 
    neighbor_helper current_state 
  | _ -> print_endline "Illegal move"; 
    neighbor_helper current_state 

and combat_helper (current_state : State.t) = 
  try 
    check_game_over current_state;
    print_endline "";
    print_endline("your hp: " ^ print_hp_bar current_state.hp);
    print_endline("😀\n");
    print_endline("enemy hp: " ^ print_hp_bar (current_state.opponent).hp);
    print_endline current_state.opponent.image;
    print_endline ("📜: " ^ current_state.opponent.description); 
    print_endline ("Your opponent's weakness is " 
                   ^ current_state.opponent.weakness);
    print_endline "";   
    print_endline "============================================================";
    print_string  "> ";
    match parse (read_line()) with
    | Attack -> 
      let player_hit = (Random.int 100) <= current_state.move.accuracy in
      let enemy_hit = (Random.int 100) <= current_state.opponent.move.accuracy 
      in
      if not (check_opponent_hp current_state) then 
        if (not player_hit) then 
          print_endline ("You missed!") else 
        if  current_state.opponent.weakness = current_state.move.m_name 
        then
          (print_endline ("You used " ^ current_state.move.m_name ^ 
                          "! It was super effective. You dealt: " ^ 
                          string_of_int (3*current_state.move.attack) 
                          ^ " damage!" );
          )
        else

          print_endline 
            ("You used " ^ current_state.move.m_name 
             ^ "! You dealt: " ^ string_of_int (current_state.move.attack) 
             ^ " damage!" );
      print_endline ("😀 " ^ current_state.move.image 
                     ^ " " ^ current_state.opponent.image);
      print_endline "";
      if not (check_opponent_hp current_state) 
      then (
        print_endline (current_state.opponent.image 
                       ^ " " ^ current_state.opponent.move.image ^ " 😀");
        if enemy_hit then 
          (print_endline (current_state.opponent.e_name 
                          ^ " used " ^ current_state.opponent.move.m_name 
                          ^ " on you!\nYou lost: " 
                          ^ string_of_int(current_state.opponent.move.attack) 
                          ^ " hp!" ))
        else 
          print_endline (current_state.opponent.e_name ^ " missed!");
        let temp_state = attack_helper current_state in 
        if temp_state.opponent.hp <= 0 
        then combat_helper(temp_state) else
        if player_hit&&enemy_hit 
        then combat_helper(opponent_helper(attack_helper current_state)) 
        else if player_hit then 
          combat_helper((attack_helper current_state))else 
        if enemy_hit then 
          combat_helper(opponent_helper( current_state)) 
        else combat_helper(current_state)  )
      (* Your opponent is dead so we return to normal life *)
      else 
        (print_endline ("Congrats! You've defeated "
                        ^ current_state.opponent.e_name ^ "!");
         print_endline 
           (current_state.opponent.e_name 
            ^ "'s corpse dissintegrated and it turned into: " 
            ^ formatted_str_from_strlist 
              (get_item_names current_state.opponent.loot) 
            ^ ". You take it and put it in your inventory." );
         if (current_state.opponent.e_name = "chad the cheery cherry man" 
             || current_state.opponent.e_name = "brad the bitchy banana man" 
             || current_state.opponent.e_name = "paul the preppy potato man")
         then print_endline (current_state.opponent.e_name 
                             ^ "'s farm is now your farm!") 
         else print_endline ("Yay!!");
         attack_helper current_state)
    | Use u ->  
      (try (let item_str = str_from_strlist u in 
            let item = item_from_item_name item_str current_state.resources in 
            let new_res = decrease_item_amt item_str current_state.resources 1 
            in
            let st = {current_state with 
                      hp = current_state.hp + item.hunger_value;
                      resources = new_res;} in
            print_endline ("You used " ^ item_str ^ "! It healed " 
                           ^ (string_of_int item.hunger_value) ^ " hp.");
            print_endline (current_state.opponent.image ^ " " 
                           ^ current_state.opponent.move.image ^ " 😀");
            print_endline (current_state.opponent.e_name ^ " used " 
                           ^ current_state.opponent.move.m_name 
                           ^ " on you!\nYou lost: " 
                           ^ string_of_int(current_state.opponent.move.attack) 
                           ^ " hp!" );
            combat_helper(opponent_helper( st));)
       with 
       | _ -> print_endline ("You don't have this item!");
         combat_helper(opponent_helper(current_state)))
    | Eat t -> 
      (try 
         let food_str = str_from_strlist t in
         let food = item_from_item_name food_str current_state.resources in  
         let st = {(caneat food current_state) with 
                   move =(plant_from_plant_name current_state food_str).move} in
         print_endline ("You ate " ^ (str_from_strlist t) ^ "!");
         let move_name = 
           (plant_from_plant_name current_state food_str).move.m_name in
         print_endline ("You can now use " ^ move_name ^ "!");
         print_endline (current_state.opponent.image 
                        ^ " " ^ current_state.opponent.move.image ^ " 😀");
         print_endline (current_state.opponent.e_name ^ " used " 
                        ^ current_state.opponent.move.m_name 
                        ^ " on you!\nYou lost: " 
                        ^ string_of_int(current_state.opponent.move.attack) 
                        ^ " hp!" );
         combat_helper(opponent_helper( st));
       with 
       |CantEat ->  print_endline "You can't eat that! What is wrong with you";
         combat_helper (current_state)
       | NoItem ->
         print_endline ((str_from_strlist t) ^ " is not in your inventory!");
         combat_helper (current_state))

    | Inventory -> 
      print_endline 
        ("Your inventory contains: " 
         ^ (current_state.resources 
            |> inventorylist
            |> formatted_str_from_strlist ));
      combat_helper (current_state);
    | Run -> 
      if current_state.opponent = satan 
      then (print_endline ("You cannot run!!! You cannot hide!!! The power of Satan compels You. This is where you make your final stand."); 
            combat_helper (current_state) )
      else (
        print_endline ("You ran away! You bring great shame to your family."); 
        current_state)
    | Quit -> print_endline ("💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀");
      ANSITerminal.(print_string [red]
                      "You gave up. Your farm is gone.\nYour family starved to death.\n");
      exit 0
    | _ -> print_endline "You can't do that here!"; 
      (combat_helper current_state)
  with
  | Malformed -> print_endline "Malformed input. Try again.";
    combat_helper current_state
  | _ -> print_endline "Illegal move"; 
    combat_helper current_state 

let play_game () =
  play_helper (init_state) 

let main () =
  ANSITerminal.(print_string [blue;Bold]
                  "\n\nWELCOME TO THE FARMING GAME.");
  ANSITerminal.(print_string [red]" 
                  You will have your own farm to grow and harvest crops. 
                  Make sure to water them well and spray them with medicinal spray when they get sick! 
                  Try not to let any of them die! 
                  Instructions:
                  [Inventory] lets you see inside your inventory. 
                  [Plant] plants a seed into your farm. 
                  [Observe] observes a specific plant.
                  [Water],[Spray],[Harvest] waters sprays and harvests a plant. 
                  [Quit] to quit\n");
  print_endline "Press a key to start.";
  print_string  "> ";
  match read_line () with
  |_-> play_game ()

let () = main ()
