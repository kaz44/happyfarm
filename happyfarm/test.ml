open OUnit2
open Command
open State
let init_state : t = 
  {
    field = [("1", nullplant);("2", nullplant);("3" ,nullplant);
             ("4", nullplant);("5", nullplant);("6", nullplant);
             ("7", nullplant);("8", nullplant);("9", nullplant);];
    basement = basement_farm;
    resources = [
      {i_name = "water";amount = 999999; description = ""; 
       item_value = 0; hunger_value = 0;edible = false};
      {i_name = "spray";amount = 999999; description = ""; 
       item_value = 0; hunger_value = 0;edible = false};
      {i_name = "corn seed"; amount = 3; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "potato seed"; amount = 5; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "cherry seed"; amount = 5; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "peach seed"; amount = 5; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "watermelon seed"; amount = 5; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "tomato seed"; amount = 5; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "strawberry seed"; amount = 5; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
    ];

    plant_dict = [("corn",corn); ("apple", apple);
                  ("peach",peach);("watermelon",watermelon);
                  ("cherry",cherry);("strawberry",strawberry);
                  ("tomato",tomato);("potato",potato);("banana",banana);
                  ("chad",chad);("brad",brad);("paul",paul)];
    time = 0;
    current_room = your_farm;
    next_rooms = [store];

    all_rooms = [your_farm;store;neighbor;forest;basement];

    farm = neighbor_farm;
    hp = 500;
    hunger = 500;
    wallet = 500;
    opponent = nothing;
    move = corn_cannon;
  }
(* States for Testing*)
let state_with_corn =
  {init_state with field = [("1", corn);("2", nullplant);("3" ,nullplant);
                            ("4", nullplant);("5", nullplant);("6", nullplant);
                            ("7", nullplant);("8", nullplant);("9", nullplant)];}

let bandages = 
  {
    i_name = "bandages";
    description = "Use these bandages to heal 50 hp. Or dress up like a mummy.";
    amount = 1;
    item_value = 15;
    hunger_value = 50;
    edible= false;
  }

let state_for_eating_corn_seed = 
  {init_state with hunger = init_state.hunger;
                   resources = [
                     {i_name = "water";amount = 999999; description = ""; 
                      item_value = 0; hunger_value = 0;edible = false};
                     {i_name = "spray";amount = 999999; description = ""; 
                      item_value = 0; hunger_value = 0;edible = false};
                     {i_name = "corn seed"; amount = 2; description = ""; 
                      item_value = 1; hunger_value = 0;edible = true};
                     {i_name = "potato seed"; amount = 5; description = ""; 
                      item_value = 1; hunger_value = 0;edible = true};
                     {i_name = "cherry seed"; amount = 5; description = ""; 
                      item_value = 1; hunger_value = 0;edible = true};
                     {i_name = "peach seed"; amount = 5; description = ""; 
                      item_value = 1; hunger_value = 0;edible = true};
                     {i_name = "watermelon seed"; amount = 5; description = ""; 
                      item_value = 1; hunger_value = 0;edible = true};
                     {i_name = "tomato seed"; amount = 5; description = ""; 
                      item_value = 1; hunger_value = 0;edible = true};
                     {i_name = "strawberry seed"; amount = 5; description = ""; 
                      item_value = 1; hunger_value = 0;edible = true};];}

let state_for_harvest_corn_seed =
  {state_with_corn with field = [("1", nullplant);("2", nullplant);("3" ,nullplant);
                                 ("4", nullplant);("5", nullplant);("6", nullplant);
                                 ("7", nullplant);("8", nullplant);("9", nullplant)];
                        resources = [
                          {i_name = "water";amount = 999999; description = ""; 
                           item_value = 0; hunger_value = 0;edible = false};
                          {i_name = "spray";amount = 999999; description = ""; 
                           item_value = 0; hunger_value = 0;edible = false};
                          {i_name = "corn seed"; amount = 4; description = ""; 
                           item_value = 1; hunger_value = 0;edible = true};
                          {i_name = "potato seed"; amount = 5; description = ""; 
                           item_value = 1; hunger_value = 0;edible = true};
                          {i_name = "cherry seed"; amount = 5; description = ""; 
                           item_value = 1; hunger_value = 0;edible = true};
                          {i_name = "peach seed"; amount = 5; description = ""; 
                           item_value = 1; hunger_value = 0;edible = true};
                          {i_name = "watermelon seed"; amount = 5; description = ""; 
                           item_value = 1; hunger_value = 0;edible = true};
                          {i_name = "tomato seed"; amount = 5; description = ""; 
                           item_value = 1; hunger_value = 0;edible = true};
                          {i_name = "strawberry seed"; amount = 5; description = ""; 
                           item_value = 1; hunger_value = 0;edible = true};];
                        time = 1;}

let test_res_1 = [
  {i_name = "corn"; 
   amount = 5; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true}
]

let test_res_2 = [
  {i_name = "peach"; 
   amount = 5; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true}
]

let test_res_3 = [
  {i_name = "peach"; 
   amount = 3; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true}
]

let test_res_4 = [
  {i_name = "corn"; 
   amount = 5; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true};
  {i_name = "peach"; 
   amount = 5; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true}
]

let test_res_5 = [
  {i_name = "corn"; 
   amount = 5; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true};
  {i_name = "peach"; 
   amount = 5; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true}
]

let test_res_7 = [
  {i_name = "peach"; 
   amount = 5; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true};
  {i_name = "corn"; 
   amount = 5; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true}
]

let test_res_6 = [
  {i_name = "corn"; 
   amount = 6; 
   description = ""; 
   item_value = 2; 
   hunger_value = 0; 
   edible = true}
]

let state_for_selling_corn_seed = 
  {init_state with   wallet = init_state.wallet + corn_seed.item_value;
                     resources = [
                       {i_name = "water";amount = 999999; description = ""; 
                        item_value = 0; hunger_value = 0;edible = false};
                       {i_name = "spray";amount = 999999; description = ""; 
                        item_value = 0; hunger_value = 0;edible = false};
                       {i_name = "corn seed"; amount = 2; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "potato seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "cherry seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "peach seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "watermelon seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "tomato seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "strawberry seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};];}


let state_for_buying_corn_seed = 
  {init_state with   wallet = init_state.wallet - corn_seed.item_value;
                     resources = [
                       {i_name = "water";amount = 999999; description = ""; 
                        item_value = 0; hunger_value = 0;edible = false};
                       {i_name = "spray";amount = 999999; description = ""; 
                        item_value = 0; hunger_value = 0;edible = false};
                       {i_name = "corn seed"; amount = 4; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "potato seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "cherry seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "peach seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "watermelon seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "tomato seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "strawberry seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};];}


let your_starting_inventory = 
  [
    {i_name = "corn seed"; amount = 4; description = ""; 
     item_value = 1; hunger_value = 0;edible = true};

  ]
let item_traded = [{i_name = "corn seed"; amount = 3; description = ""; 
                    item_value = 1; hunger_value = 0;edible = true}]
let item_received = {i_name = "tomato seed"; amount = 2; description = ""; 
                     item_value = 1; hunger_value = 0;edible = true}
let your_ending_inventory = 
  [

    {i_name = "tomato seed"; amount = 2; description = ""; 
     item_value = 1; hunger_value = 0;edible = true};
    {i_name = "corn seed"; amount = 1; description = ""; 
     item_value = 1; hunger_value = 0;edible = true};

  ]

let their_starting_inventory = 
  [
    {i_name = "corn seed"; amount = 4; description = ""; 
     item_value = 1; hunger_value = 0;edible = true};
    {i_name = "tomato seed"; amount = 5; description = ""; 
     item_value = 1; hunger_value = 0;edible = true};
  ]

let their_ending_inventory = 
  [
    {i_name = "corn seed"; amount = 7; description = ""; 
     item_value = 1; hunger_value = 0;edible = true};
    {i_name = "tomato seed"; amount = 3; description = ""; 
     item_value = 1; hunger_value = 0;edible = true};
  ]

let state_for_selling_2_corn_seed = 
  {init_state with   wallet = init_state.wallet + 2*corn_seed.item_value;
                     resources = [
                       {i_name = "water";amount = 999999; description = ""; 
                        item_value = 0; hunger_value = 0;edible = false};
                       {i_name = "spray";amount = 999999; description = ""; 
                        item_value = 0; hunger_value = 0;edible = false};
                       {i_name = "corn seed"; amount = 1; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "potato seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "cherry seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "peach seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "watermelon seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "tomato seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "strawberry seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};];}


let state_for_buying_2_corn_seed = 
  {init_state with   wallet = init_state.wallet - 2*corn_seed.item_value;
                     resources = [
                       {i_name = "water";amount = 999999; description = ""; 
                        item_value = 0; hunger_value = 0;edible = false};
                       {i_name = "spray";amount = 999999; description = ""; 
                        item_value = 0; hunger_value = 0;edible = false};
                       {i_name = "corn seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "potato seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "cherry seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "peach seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "watermelon seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "tomato seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};
                       {i_name = "strawberry seed"; amount = 5; description = ""; 
                        item_value = 1; hunger_value = 0;edible = true};];}
(* Plants for Testing *)
let new_corn = 
  {corn with nowater = 1;
             nospray = 1;}

(* Start of Command Tests *)
let make_command_test 
    (name: string) 
    (s: string) 
    (expected_output: command) : test =
  name >:: (fun _ ->
      assert_equal expected_output (parse s))

let exception_test
    (name: string) 
    (s: string) : test = 
  name >:: (  fun _ ->
      let f = fun () -> parse s in 
      assert_raises (Malformed) f;
    )

let command_tests =
  [
    (* Quit Tests *)
    make_command_test "test_quit" "quit" (Quit);
    (* See Tests *)
    make_command_test "test_see" "see" (See);
    (* Observe Tests *)
    make_command_test "test_observe" "observe 1" (Observe ["1"]);
    (* Water Tests *)
    make_command_test "test_water" "water 1" (Water ["1"]);
    (* Plant Tests *)
    make_command_test "test_plant" "plant corn" (Plant ["corn"]);
    (* Spray Tests *)
    make_command_test "test_spray" "spray 1" (Spray ["1"]);
    (* Harvest Tests *)
    make_command_test "test_harvest" "harvest 1" (Harvest ["1"]);
    (* Inventory Tests *)
    make_command_test "test_inventory" "inventory" (Inventory);
    (* Dig Tests *)
    make_command_test "test_dig" "dig" (Dig);
    (* Lumber Tests *)
    make_command_test "test_lumber" "lumber" (Lumber);
    (* Eat Tests *)
    make_command_test "test_eat" "eat corn" (Eat ["corn"]);
    (* Steal Tests *)
    make_command_test "test_steal" "steal 1" (Steal ["1"]);
    (* Sell Tests *)
    make_command_test "test_sell" "sell corn 1" (Sell ["corn";"1"]);
    (* Buy Tests *)
    make_command_test "test_buy" "buy watering 1" (Buy["watering";"1"]);
    (* Use Tests *)
    make_command_test "test_use" "use gummy" (Use ["gummy"]); 
    (* Inventory Tests *)
    make_command_test "test_inventory" "inventory" (Inventory);
    (* Go Tests *)
    make_command_test "test_go" "go" (Go);
  ]

(* Start of State Tests *)
(* Update Hunger Tests *)
let make_hunger_test 
    (name : string)
    (t: State.t)
    (expected_output: int) = 
  name >:: (fun _ ->
      assert_equal expected_output (update_hunger t))

let hunger_test = 
  [
    make_hunger_test "test_hunger" init_state 490;
  ]

(* Trade  Tests *)
let make_trade_test 
    (name:string)
    (npc_res: item list) 
    (player_res : item list) 
    (farmer_item : item)  
    (player_items : item list)
    (expected_output: item list * item list) = 
  name >:: (fun _ ->
      assert_equal expected_output (make_trade npc_res player_res farmer_item player_items))

let trade_test = 
  [
    make_trade_test "test trade" their_starting_inventory your_starting_inventory item_received item_traded (their_ending_inventory,your_ending_inventory);
  ]

(* Update HP Tests *)
let make_hp_test 
    (name : string)
    (t: State.t)
    (expected_output: int) = 
  name >:: (fun _ ->
      assert_equal expected_output (update_hp t))

let hp_test = 
  [
    make_hp_test "test_hp" init_state 500;
  ]

(* Find Plant in Field Tests *)
let make_find_plant_test 
    (name : string)
    (field : (string * plant) list)
    (plant_id : string)
    (expected_output : plant) = 
  name >:: (fun _ ->
      assert_equal expected_output (find_plant_in_field field plant_id))

let find_plant_test =
  [
    make_find_plant_test "test find plant" init_state.field "1" nullplant;
  ]

(* Water Plant Tests *)
let make_water_test 
    (name : string)
    (field : (string * plant) list)
    (plant_id : string)
    (t : State.t)
    (expected_output : (string * plant) list) = 
  name >:: (fun _ ->
      assert_equal expected_output (water_plant field plant_id t))

let water_test =
  [
    make_water_test "test water" init_state.field "1" init_state init_state.field;
  ]

(* Spray Plant Tests *)
let make_spray_test 
    (name : string)
    (plant_id : string)
    (field : (string * plant) list)
    (expected_output : (string * plant) list) = 
  name >:: (fun _ ->
      assert_equal expected_output (spray_plant plant_id field))

let spray_test =
  [
    make_spray_test "test spray" "1" init_state.field init_state.field;
  ]

(* Grow Plant Tests *)
let make_grow_test
    (name : string)
    (t : State.t)
    (plant_id : string)
    (expected_output : plant) = 
  name >:: (fun _ -> 
      assert_equal expected_output (grow t plant_id))

let grow_test = 
  [
    make_grow_test "test grow" state_with_corn "1" new_corn;
  ]

(* Harvest Plant Tests *)
let make_harvest_test
    (name : string)
    (plant_id : string)
    (t : State.t)
    (expected_output : State.t) = 
  name >:: (fun _ ->
      assert_equal expected_output (harvest t plant_id))

let harvest_test = 
  [
    make_harvest_test "test harvest" "1" state_with_corn state_for_harvest_corn_seed; 
  ]


(* Sell Tests *)
let make_sell_test
    (name : string)
    (item_name : string)
    (amt: int)
    (t : State.t)
    (expected_output : State.t) = 
  name >:: (fun _ ->
      assert_equal expected_output (sell_crop t item_name amt ))

let sell_test = 
  [
    make_sell_test "test sell 1 corn seed" "corn seed" 1 init_state state_for_selling_corn_seed; 
    make_sell_test "test sell 2 corn seed" "corn seed" 2 init_state state_for_selling_2_corn_seed; 
  ]


(* Buy Tests *)
let make_buy_test
    (name : string)
    (item_name : string)
    (amt: int)
    (t : State.t)
    (expected_output : State.t) = 
  name >:: (fun _ ->
      assert_equal expected_output (buy_item t item_name amt ))

let buy_test = 
  [
    make_buy_test "test buy 1 corn seed" "corn seed" 1 init_state state_for_buying_corn_seed; 
    make_buy_test "test buy 2 corn seed" "corn seed" 2 init_state state_for_buying_2_corn_seed; 
  ]

(* Eat Tests *)
let make_eat_test 
    (name : string)
    (item_list : string list)
    (t : State.t)
    (expected_output : State.t) = 
  name >:: (fun _ ->
      assert_equal expected_output (eat item_list t))

let eat_test = 
  [
    make_eat_test "test eat" ["corn";"seed"] init_state state_for_eating_corn_seed;
  ]

(* Trading Tests *)
let make_check_in_inv_test 
    (name : string)
    (res : item list)
    (item_name : string)
    (amt : int) 
    (expected_output : bool)=
  name >:: (fun _ ->
      assert_equal expected_output (check_in_inv res item_name amt))

let check_inv_tests =
  [
    make_check_in_inv_test "check inv for corn seed" init_state.resources "corn seed" 1 true;
    make_check_in_inv_test "check inv for too many corn seeds" init_state.resources "corn seed" 20 false;
    make_check_in_inv_test "check inv for corn" init_state.resources "corn" 1 false;
  ]

let make_trade_calc_test 
    (name : string)
    (player_items: item list)
    (acc: item list)
    (amt: int)
    (expected_output : item list) = 
  name >:: (fun _ ->
      assert_equal expected_output (trade_calc player_items acc amt))

let trade_calc_tests =
  [
    make_trade_calc_test "corn for $10" test_res_1 [] 10 test_res_1;
    make_trade_calc_test "peach for $10" test_res_2 [] 10 test_res_2;
    make_trade_calc_test "peach for $5" test_res_2 [] 5 test_res_3;
    make_trade_calc_test "corn for $11" test_res_6 [] 11 test_res_6;
    make_trade_calc_test "corn and peach for 20" test_res_5 [] 20 test_res_7;
  ]

let suite =
  "test suite for A8"  >::: List.flatten 
    [
      (* Command tests *)
      command_tests;
      (* State tests *)
      hunger_test;
      hp_test;
      find_plant_test;
      water_test;
      spray_test;
      grow_test;
      harvest_test;
      eat_test;
      check_inv_tests;
      trade_calc_tests;
      buy_test;
      sell_test;
    ]

let _ = run_test_tt_main suite 