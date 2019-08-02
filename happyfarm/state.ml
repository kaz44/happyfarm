
type water = OK | NeedsWater | ReallyNeedsWater 
           | Dead                          
type health = OK | Sick | ReallySick 
            | Dead 
type growth = Empty | Seed | Halfripe   | Ripe   | Rotten | Dead 

type living = Alive | Dead 

type item =
  {
    i_name: string;
    description: string;
    amount: int; 
    item_value: int;
    hunger_value: int;
    edible: bool;
  }

type room = 
  {
    r_id: string;
    description: string list;
  }

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
    living: living;
    move : move;
  }

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

type farm = {
  farmer_emoji : string;
  farmer_description : string;
  farmer_dialogue : string list;
  replies : string list;
  farm_name : string;
  lst : (string * plant) list;
  inventory : item list;
  farmer : bool;
}

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
    basement : farm;
    move: move;
    farm: farm;
  }

(******** Move Dictionary ********)
let corn_cannon = 
  {
    m_name = "corn cannon";
    description = "Shoot corn kernels from your fingertips.";
    battle_string = "Pew pew";
    image = "💥💨🌽";
    attack = 10; 
    accuracy = 90;
  }

let cherry_chomper = 
  {
    m_name = "cherry chomper";
    description = "A cherry in the form of a vore monster tries to chomp your enemy";
    battle_string = "mONCH CRONCH";
    image = "🍒🍒💀";
    attack = 20; 
    accuracy = 80;
  }

let potassium_pandemic = 
  {
    m_name = "potassium pandemic";
    description = "Destroy your opponent from the inside by causing potassium overdose.";
    battle_string = "How do monkeys eat so much of this.";
    image = "🍌😷😵";
    attack = 30;
    accuracy = 70;
  }

let berry_big_bop = 
  {
    m_name = "berry big bop";
    description = "Just bop 'em.";
    battle_string = "BOP";
    image = "🤜🍓💥";
    attack = 30;
    accuracy = 90;
  }

let granny_smith_grenade = 
  {
    m_name = "granny smith grenade";
    description = "An explosive burst of sour flavor";
    battle_string = "BOOM";
    image = "💥🍏💥";
    attack = 40;
    accuracy = 60;
  }

let peach_punisher =
  {
    m_name = "peach_punisher";
    description = "Destroy your opponents with the power of peaches";
    battle_string = "A full moon rises";
    image = "🍑👊👊";
    attack = 40;
    accuracy = 70;
  }

let tomato_tranfusion = 
  {
    m_name = "tomato transfusion";
    description = "Replace your opponent's blood with tomato juice.";
    battle_string = "You get a strange thrill out of impersonating a nurse.";
    image = "🍅💉🤫";
    attack = 60;
    accuracy = 50;
  }

let melon_mash = 
  {
    m_name = "melon mash";
    description = "Fairly straightforward, bash your opponent's head in with a melon.";
    battle_string = "Is that blood or watermelon juice?";
    image = "🍉🤯🍉";
    attack = 70;
    accuracy = 40;
  }

let starch_storm = 
  {
    m_name = "starch storm";
    description = "Call upon the potato lords to summon a storm of starch directed at your opponent.";
    battle_string = "WHOOSH";
    image="🌪️🥔🌪️";
    attack = 80;
    accuracy = 30;
  }

let holy_hose = 
  {
    m_name = "holy hose";
    description = "Spray holy water upon your enemies.";
    battle_string = "Splash! Now you're wet with my farming juices!!!!";
    image = "🌊😩🌊";
    attack = 80; 
    accuracy = 70;
  }

(* Enemy Moves *)

let satanic_smite= 
  {
    m_name = "satanic smite";
    description = "GET DICKED ON.";
    battle_string = "UnngnhgGHGHJGH yes daddy";
    image = "🍆😩💦";
    attack = 100; 
    accuracy = 80;
  }

let exorcism = 
  {
    m_name = "exorcism";
    description = "Guaranteed to rid you of your demons.";
    battle_string = "Begone demon!";
    image = "✝️✝️✝️";
    attack = 1000;
    accuracy = 90;  
  }

(******** Plant Dictionary ********)
let nullplant:plant = 
  {
    name="";
    id= "";
    image= "__";
    description="";
    growth=Empty;
    seed_name = "";
    water=OK;
    health= OK;
    growthfactor=0;
    nowater=0;
    oknowater=0;
    nospray=0;
    oknospray=0;
    plant_time=0;
    unit_price=0;
    living = Alive;
    move = corn_cannon;
  }

let corn = 
  {
    name = "corn";
    id = "1";
    image = "🌽";
    seed_name = "corn seed";
    description= "yellow vegetable tastes good";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 3;
    nowater= 0;
    oknowater= 6;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=2;
    living=Alive;
    move = corn_cannon;
  } 

let apple = 
  {
    name = "apple";
    id = "apple1";
    image = "🍎";
    seed_name = "apple seed";
    description= "a healthy red fruit";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 5;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=1;
    living=Alive;
    move = granny_smith_grenade;
  }

let peach = 
  {
    name = "peach";
    id = "sdjglksdg";
    image = "🍑";
    seed_name = "peach seed";
    description= "The fleshy, pinkish-orange fruit of the fuzzy peach, shown with green leaves and sometimes a stem.";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 4;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=2;
    living=Alive;
    move = peach_punisher;
  } 

let cherry = 
  {
    name = "cherry";
    id = "peafsdch";
    seed_name = "cherry seed";
    image = "🍒";
    description= "Small Red Fruit taste good";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 3;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=1;
    living=Alive;
    move = cherry_chomper;
  } 

let watermelon = 
  {
    name = "watermelon";
    id = "swwww";
    seed_name = "watermelon seed";
    image = "🍉";
    description= "Big watery red fruit";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 2;
    nowater= 0;
    oknowater= 2;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=3;
    living=Alive;
    move = melon_mash;
  } 

let banana = 
  {
    name = "banana";
    id = "swrrwwt";
    seed_name = "banana seed";
    image = "🍌";
    description= "Great snack for a child or monkey. Or Brad.";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 3;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=1;
    living=Alive;
    move = potassium_pandemic;
  } 

let strawberry = 
  {
    name = "strawberry";
    id = "swrrwwt";
    seed_name = "strawberry seed";
    image = "🍓";
    description= "Small seedy berry red fruit";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 3;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=1;
    living=Alive;
    move = berry_big_bop;
  } 

let tomato = 
  {
    name = "tomato";
    id = "fsdg";
    image = "🍅";
    seed_name = "tomato seed";
    description= "Is it a fruit? Is it a vegetable? You can use it to make ketchup";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 3;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=1;
    living=Alive;
    move = tomato_tranfusion;
  } 

let potato = 
  {
    name = "potato";
    id = "fsdg";
    image = "🥔";
    seed_name = "potato seed";
    description= "A whole potato—such as a russet, used for baking, mashing, or frying—shown with a few eyes on its golden-brown skin. ";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 3;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=2;
    living=Alive;
    move = starch_storm;
  } 

let chad = 
  {
    name = "chad";
    id = "sdjglksdg";
    image = "🤠";
    seed_name = "chad head";
    description= "The remains of Chad.";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 4;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=2;
    living=Alive;
    move = corn_cannon;
  } 
let brad = 
  {
    name = "brad";
    id = "sdjglksdg";
    image = "👨‍🌾";
    seed_name = "brad head";
    description= "The remains of Brad.";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 4;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=2;
    living=Alive;
    move = corn_cannon;
  } 
let paul = 
  {
    name = "paul";
    id = "sdjglksdg";
    image = "👨‍";
    seed_name = "paul head";
    description= "The remains of Paul.";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 4;
    nowater= 0;
    oknowater= 10;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=2;
    living=Alive;
    move = corn_cannon;
  } 
let eggplant = 
  {
    name = "eggplant";
    id = "swwww";
    seed_name = "eggplant seed";
    image = "🍆";
    description= "Owooooo what's this? A thick, juicy, long purple rod perfect for stuffing in your farm!";
    growth= Seed ;
    water= NeedsWater;
    health= OK;
    growthfactor= 2;
    nowater= 0;
    oknowater= 2;
    nospray=0;
    oknospray=5;
    plant_time=0;
    unit_price=3;
    living=Alive;
    move = holy_hose;
  } 

let bible = 
  {
    name = "bible";
    id = "bible";
    seed_name = "bible page";
    image = "";
    description = "The Holy Book of God";
    growth = Ripe;
    water = NeedsWater;
    health = OK;
    growthfactor = 1;
    nowater = 0;
    oknowater = 1;
    nospray = 0;
    oknospray = 1;
    plant_time = 0;
    unit_price = 0;
    living = Alive;
    move = exorcism;
  }

(******** End Plant Dictionary ********)

let move_dictionary = [("corn", corn_cannon); 
                       ("apple", granny_smith_grenade); 
                       ("cherry", cherry_chomper);
                       ("peach", peach_punisher);
                       ("watermelon", melon_mash);
                       ("banana", potassium_pandemic);
                       ("strawberry", berry_big_bop);
                       ("tomato", tomato_tranfusion);
                       ("potato", starch_storm);
                       ("eggplant", holy_hose);
                       ("bible", exorcism);
                      ]

(******** Room Dictionary ********)
let your_farm :room = 
  {
    r_id= "your farm";
    description = ["this is your farm"];
  }
let store : room = 
  {
    r_id = "the store";
    description = ["you can sell your crops or buy resources"]
  }
let basement : room = 
  {
    r_id = "your basement";
    description = ["It has the makings of fine living space. It seems you
                    have other plans for it..."]
  }
let neighbor : room = 
  {
    r_id = "your neighbor's house";
    description= [""]
  }
let forest : room = 
  {
    r_id = "spooky forest";
    description = ["OooOOOooOOOOOoo sP00pY.....\nA spooky forest. You sense you are not alone..."]
  }
(******** End Room Dictionary ********)

(******** Item Dictionary *********)
let gold = 
  {
    i_name = "gold";
    description = "It's so shiny";
    amount = 0;
    item_value = 100;
    hunger_value = 0;
    edible= false;
  }  

let lumber = 
  {
    i_name = "lumber";
    description = "Looks strong. Good for building.";
    amount = 0;
    item_value = 10;
    hunger_value = 0;
    edible= false;
  }

let corn_seed = 
  {
    i_name = "corn seed";
    description = "It's the seed of a corn.";
    amount = 1;
    item_value = 1;
    hunger_value = 1;
    edible= true;
  }

let eggplant_seed = 
  {
    i_name = "eggplant seed";
    description = "It's the seed of a wonderous purple vegetable.";
    amount = 1;
    item_value = 1;
    hunger_value = 1;
    edible= true;
  }

let cherry_seed = 
  {
    i_name = "cherry seed";
    description = "It's the seed of a cherry.";
    amount = 1;
    item_value = 1;
    hunger_value = 1;
    edible= true;
  }

let strawberry_seed = 
  {
    i_name = "strawberry seed";
    description = "It's the seed of a strawberry.";
    amount = 1;
    item_value = 1;
    hunger_value = 1;
    edible= true;
  }

let apple_seed = 
  {
    i_name = "apple seed";
    description = "It's the seed of a apple.";
    amount = 1;
    item_value = 1;
    hunger_value = 1;
    edible= true;
  }

let peach_seed = 
  {
    i_name = "peach seed";
    description = "It's the seed of a peach.";
    amount = 1;
    item_value = 1;
    hunger_value = 1;
    edible= true;
  }

let potato_seed = 
  {
    i_name = "potato seed";
    description = "It's the seed of a potato.";
    amount = 1;
    item_value = 1;
    hunger_value = 1;
    edible= true;
  }

let watermelon_seed = 
  {
    i_name = "watermelon seed";
    description = "It's the seed of a watermelon";
    amount = 1;
    item_value = 1;
    hunger_value = 1;
    edible = true;
  }

let tomato_seed = 
  {
    i_name= "tomato seed";
    description= "The seed of a tomato.";
    amount= 1; 
    item_value=1;
    hunger_value= 1;
    edible= true;
  }

let banana_seed = 
  {
    i_name= "banana seed";
    description= "The seed of a banana.";
    amount= 1; 
    item_value=1;
    hunger_value= 1;
    edible= true;
  }

let chad_head = 
  {
    i_name= "chad head";
    description= "what's Chad doing in your inventory? Oh boy better bury him.";
    amount= 1; 
    item_value=1000;
    hunger_value= 100;
    edible= false;
  }

let satanic_power = 
  {
    i_name= "Satanic power";
    description= "You've killed the devil and gained his powers.";
    amount= 1; 
    item_value=1000;
    hunger_value= 100;
    edible= false;
  }

let brad_head = 
  {
    i_name= "brad head";
    description= "what's brad doing in your inventory? Oh boy better bury him.";
    amount= 1; 
    item_value=1000;
    hunger_value= 100;
    edible= false;
  }
let paul_head = 
  {
    i_name= "paul head";
    description= "what's paul doing in your inventory? Oh boy better bury him.";
    amount= 1; 
    item_value=1000;
    hunger_value= 100;
    edible= false;
  }

let watering_machine = 
  {
    i_name = "watering machine";
    description = "Waters your plants for you automatically every 10 turns.\n
    How convenient!";
    amount = 1;
    item_value = 100;
    hunger_value = 0;
    edible= false;
  }

let spraying_machine = 
  {
    i_name = "spraying machine";
    description = "Ideally sprays your plants for you automatically.\n
    But it's kinda broken so it only works 40% of the time. 
    Oh well... at least it's cheap.";
    amount = 1;
    item_value = 50;
    hunger_value = 0;
    edible= false;
  }

let bandaid = 
  {
    i_name = "bandaid";
    description = "A small bandaid that heals 20 hp";
    amount = 500;
    item_value = 1;
    hunger_value = 20;
    edible= false;
  }

let bandages = 
  {
    i_name = "bandages";
    description = "Use these bandages to heal 50 hp. Or dress up like a mummy.";
    amount = 1;
    item_value = 15;
    hunger_value = 50;
    edible= false;
  }

let holy_potion = 
  {
    i_name = "holy potion";
    description = "Use this holy potion to heal 200 hp.";
    amount = 1;
    item_value = 200;
    hunger_value = 200;
    edible= false;
  }

let water = 
  {
    i_name = "water";
    description = "For watering your thirsty plants";
    amount = 1;
    item_value = 5;
    hunger_value = 0;
    edible= false;
  }

let spray = 
  {
    i_name = "spray";
    description = "For spraying your sick plants";
    amount = 1;
    item_value = 10;
    hunger_value = 0;
    edible= true;
  }

(* Inventory of the store *)
let store_inv = 
  [
    corn_seed;
    strawberry_seed;
    peach_seed;
    watermelon_seed;
    potato_seed;
    tomato_seed;
    apple_seed;
    watering_machine;
    spraying_machine;
    bandaid;
    bandages;
    spray;
    water; 
    holy_potion;
  ]

(******** End Item Dictionary *********)

let recipe_list = 
  [
    ("cherry pie", [("cherry", 5);("strawberry",5)]);
    ("banana bread", [("banana", 7)]);
    ("peach cobbler", [("peach", 3); ("apple",4)])
  ]

(******** Farm Dictionary ********)
let neighbor_farm :farm = 
  {
    farmer_emoji = "🤠";
    farmer_description = "\n Chad is cheery and loves cherries. He loves talking with his neighbors, \n except for when he gets mad. which is a lot";
    farm_name= "Chad's farm";
    farmer_dialogue=  [" howdy neighbor!";
                       " How are you doing on this fine day?\n";
                       " Well that's great! I'm doing swell! I just been hearing people stealing crops around here. Gosh darn those diddly doo bobs. Hope we safe around here! You aint gonna steal from poor lil me right? Hehooooo";
                       " HOW DARE YE ASK ME SUCH A DARN THING!!! I'LL FIGHT YOU RIGHT HERE AND NOW!!!!";
                       " Sure, partner! What do you want?"
                      ];
    replies = ["pick options:\n>1- Howdy!\n>2- Give me your crops!\n>3- Let's trade!\n";
               "pick options:\n>1- I had a bad day, let's fight TO THE DEATH!!\n>2- I'm good how are you?!!!";
               "pick options:\n>1- WAIT WHY???? I'M TOO YOUNG TO DIE!!!\n>2- FINE LET'S fIGHT TO THE DEATH!!!";
              ];
    lst= [("1", nullplant);("2", nullplant);("3" ,nullplant);
          ("4", nullplant);("5", nullplant);("6", nullplant);
          ("7", nullplant);("8", nullplant);("9", nullplant);] ;
    inventory= [];
    farmer=false
  }
let neighbor2_farm :farm = 
  {
    farmer_emoji = "👨‍🌾";
    farmer_description = "brad is bitchy but he sure does love bananas! he will suck everyone's bananas because that's how much he likes them!\n
     Everyone knows brad loves bananas and they tease him for being such a slut for bananas, which is why he's a bitch to everyone now.\n
      Let him succ bananas in peace";
    farm_name= "Brad's farm";
    farmer_dialogue=  [" Hey~ !";
                       " Boy am I craving bananas right now\n";
                       " Hnnng I could really use a banana right now. I don't need it... I don't need it... I NEEEEEED ITTTTTTTTTTTTT";
                       " How dare you noT LIKE BANANAS?! FIGHT ME RIGHT NOW!!";
                       " Sure honey~ Anything you want from me?~"
                      ];
    replies = ["pick options:\n>1- Hi..?\n>2- I hate bananas!\n>3- Wanna trade?!\n";
               "pick options:\n>1- Ew how could you like bananas? They're disgusting.\n>2- Uhh that's cool I guess?";
               "pick options:\n>1- I'd really prefer not to but if you insist...\n>2- FINE BY ME!!!";

              ];
    lst= [("1", nullplant);("2", nullplant);("3" ,nullplant);
          ("4", nullplant);("5", nullplant);("6", nullplant);
          ("7", nullplant);("8", nullplant);("9", nullplant);] ;
    inventory= [];
    farmer=false
  }
let neighbor3_farm :farm = 
  {
    farmer_emoji ="👨‍" ;
    farmer_description = "paul is preppy and loves eating potato chips. \n
    Sadly, due to his potato addiction, his figure is not the best for his hobby of trying on preppy clothes. \n
    Often, he breaks into his daughter's room and other young lady's rooms to steal their preppy clothing. \n
    Unfortunately, he has a potato body. Sad.";
    farm_name= "Paul's farm";
    farmer_dialogue=  [" Hey there!";
                       " Bunch of farmers been beheaded recently. Better watch out out there!\n";
                       " There aren't any leads yet. I can't believe the police haven't done anything.";
                       " W-whAT DID YOU JUST SAY? mY POTATO BODY IS BEAUTIFUL AND WHOEVER THINKS OTHERWISE MUST BE  E L I M I N A T E D";
                       " Yea I'll trade you. Anything but my potato chips though. Those stays with me."
                      ];
    replies = ["pick options:\n>1- Hi!!\n>2- Dude you're kinda fat\n>3- Do you wanna trade?\n";
               "pick options:\n>1- Wow your fashion taste is horrible...\n>2- Oh my... who could be doing such a thing?!!!";
               "pick options:\n>1- I won't go easy on you!!\n>2- HAHAHA TIME FOR YOU TO DIE!!";

              ];
    lst= [("1", nullplant);("2", nullplant);("3" ,nullplant);
          ("4", nullplant);("5", nullplant);("6", nullplant);
          ("7", nullplant);("8", nullplant);("9", nullplant);] ;
    inventory= [];
    farmer=false
  }
let basement_farm : farm = 
  {
    farmer_emoji ="" ;
    farmer_description = "The room pulses with mysterious malicious power... Did you always have this place? Something compels you to plant special things here... and maybe what you always desired in your dreams will be summoned...";
    farm_name= "Your basement";
    farmer_dialogue= [];
    replies = [];
    lst= [("1", nullplant);("2", nullplant);("3" ,nullplant);] ;
    inventory= [];
    farmer=false}

let null_farm : farm = 
  {
    farmer_emoji ="" ;
    farmer_description = "You've conquered all your neighbors. There's nothing left for you here.";
    farm_name= "Nothing farm";
    farmer_dialogue= [];
    replies = [];
    lst= [("1", nullplant);("2", nullplant);("3" ,nullplant);
          ("4", nullplant);("5", nullplant);("6", nullplant);
          ("7", nullplant);("8", nullplant);("9", nullplant);] ;
    inventory= [];
    farmer=false
  }

(******** End Farm Dictionary ********)

(******** Enemy Dictionary ********)

let nothing = 
  {
    e_name = "nothing";
    description = "It is nothing";
    image = "";
    hp = 0;
    move = corn_cannon;
    weakness = "";
    loot = [gold];
  }

(* Enemies encountered while digging *)

let worm = 
  {
    e_name = "worm";
    description = "A foe unworthy of your time";
    image = "🐛";
    hp = 30;
    move = corn_cannon;
    weakness = "corn cannon";
    loot = [corn_seed];
  }

let boar = 
  {
    e_name = "boar";
    description = "A large and well-fed wild boar. It looks like it could've killed a drunken king. It enjoys digging and doesn't want any competition.";
    image = "🐗";
    hp = 60;
    move = peach_punisher;
    weakness = "granny smith grenade";
    loot = [peach_seed];
  }

let bear = 
  {
    e_name = "bear";
    description = "A giant grizzly bear. You've interrupted his dinner.";
    image = "🐻";
    hp = 100;
    move = starch_storm;
    weakness = "tomato transfusion";
    loot = [potato_seed];
  }

(* Enemies encountered while lumbering *)

let snake = 
  {
    e_name = "snake";
    description = "A poisonous opponent born of greed. It lusts for your wealth";
    image="🐍";
    hp = 30;
    move = corn_cannon;
    weakness = "corn cannon";
    loot = [cherry_seed];
  }

let monkey = 
  {
    e_name = "monkey";
    description = "A vicious primate has come for your crops and your life";
    image = "🐵";
    hp = 40;
    move = corn_cannon;
    weakness = "corn cannon";
    loot = [corn_seed];
  }

let dragon = 
  {
    e_name = "dragon";
    description = "The guardian of the forest. He is angered by your disregard for his home";
    image="🐲";
    hp = 100;
    move = melon_mash;
    weakness = "melon mash";
    loot = [watermelon_seed];
  }

(* Enemy Neighbors *)

let neighbor1 = 
  {
    e_name = "chad the cheery cherry man";
    description = "chad is cheery and loves cherries. he loves talking with his neighbors, except for when he gets mad. which is a lot";
    image = "🤠";
    hp = 100;
    move = cherry_chomper;
    weakness = "corn cannon";
    loot = chad_head::cherry_seed::neighbor_farm.inventory;
  }

let satan = 
  {
    e_name = "Satan";
    description = "The Devil Himself.";
    image = "r";
    hp = 2000;
    move = satanic_smite;
    weakness = "exorcism";
    loot = [satanic_power];
  }

let wandering_priest = 
  {
    e_name = "wandering priest";
    description = "He's an old, sickly priest that wanders the roads.";
    image = "🎅";
    hp = 100;
    move = holy_hose;
    weakness = "holy hose";
    loot = [{i_name = "bible";
             description = "";
             amount = 1;
             item_value = 1000;
             hunger_value = 0;
             edible = true;}];
  }

let neighbor2 = 
  {
    e_name = "brad the bitchy banana man";
    description = "brad is bitchy but he sure does love bananas! he will suck everyone's bananas because that's how much he likes them!\n
     Everyone knows brad loves bananas and they tease him for being such a slut for bananas, which is why he's a bitch to everyone now.\n
      Let him succ bananas in peace";
    image = "👨‍🌾";
    hp = 500;
    move = potassium_pandemic;
    weakness = "tomato transfusion";
    loot = brad_head::banana_seed::neighbor_farm.inventory;
  }

let neighbor3 = 
  {
    e_name = "paul the preppy potato man";
    description = "paul is preppy and loves eating potato chips. \n
    Sadly, due to his potato addiction, his figure is not the best for his hobby of trying on preppy clothes. \n
    Often, he breaks into his daughter's room and other young lady's rooms to steal their preppy clothing. \n
    Unfortunately, he has a potato body. Sad.";
    image = "👨‍";
    hp = 1000;
    move = starch_storm;
    weakness = "melon mash";
    loot = paul_head::eggplant_seed::neighbor_farm.inventory;
  }

(** The record representing the final boss, satan*)
let satan = 
  {
    e_name = "Satan";
    description = "The Devil Himself.";
    image = "😈";
    hp = 2000;
    move = satanic_smite;
    weakness = "holy hose";
    loot = [satanic_power];
  }

(******** End Enemy Dictionary ********)

(** [str_from_strlist strlist] is the string containing 
    the entries of [strlist] with spaces between the entries*)
let rec str_from_strlist (strlist: string list): string = 
  match strlist with 
  |[] -> ""
  |h::t -> 
    if List.length t >= 1 then h ^ " " ^ (str_from_strlist t) else 
      h ^(str_from_strlist t)

(** [init_state] is the state when the game first starts *)
let init_state : t = 
  {
    field = [("1", nullplant);("2", nullplant);("3" ,nullplant);
             ("4", nullplant);("5", nullplant);("6", nullplant);
             ("7", nullplant);("8", nullplant);("9", nullplant);];
    basement = basement_farm;
    resources = [
      {i_name = "water";amount = 20; description = ""; 
       item_value = 0; hunger_value = 0;edible = false};
      {i_name = "spray";amount = 20; description = ""; 
       item_value = 0; hunger_value = 0;edible = false};
      {i_name = "corn seed"; amount = 3; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "potato seed"; amount = 2; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "peach seed"; amount = 1; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "watermelon seed"; amount = 1; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "tomato seed"; amount = 1; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "strawberry seed"; amount = 1; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
      {i_name = "apple seed"; amount = 1; description = ""; 
       item_value = 1; hunger_value = 0;edible = true};
    ];

    plant_dict = [("corn",corn); ("apple", apple);
                  ("peach",peach);("watermelon",watermelon);
                  ("cherry",cherry);("strawberry",strawberry);
                  ("tomato",tomato);("potato",potato);("banana",banana);
                  ("chad",chad);("brad",brad);("paul",paul);
                  ("eggplant",eggplant);("bible",bible)];
    time = 0;
    current_room = your_farm;
    next_rooms = [store];

    all_rooms = [your_farm;store;neighbor;forest;basement];

    farm = neighbor_farm;
    hp = 2000;
    hunger = 100;
    wallet = 100;
    opponent = nothing;
    move = corn_cannon;
  }

exception NoItem
exception NotEnough
exception InvalidPlant
exception NoPlantInField
exception FullField
exception NoSuchPlant
exception NoSuchRoom 
exception CantEat
exception NoMoney

(** [get_item_names] is a string list of all the item names in [itemlist] *)
let get_item_names (itemlist: item list) : string list =
  List.map (fun x -> x.i_name) itemlist

let get_id (plant:plant) : string = 
  plant.id

let get_item_value (item: item) : int = 
  item.item_value

(** [update_hp st] decrements hp if st.hunger is 0. ADD more functionality *)
let update_hp (st : t) = 
  if st.hunger = 0 then st.hp - 10 else st.hp

(** [update_hunger st] decrements hunger by a certain amount 
    depending on the current value of hunger in [st]. *)
let update_hunger (st : t) = 
  if st.hunger = 0 then 0 else max (st.hunger - 10) 0

(** [find_plant_in_field field plant_id] returns the plant associated with 
    the plant_id [plant_id]. 
    Raises: NoPlantInField if the plant is not in the field *)
let rec find_plant_in_field field (plant_id : string) : plant = 
  match field with
  | [] -> raise NoPlantInField
  | (k, v) :: t -> if k = plant_id then v else find_plant_in_field t plant_id

(**[decrease_item_amt] is the item list with the amount of the item
   corresponding to [item_name] decreased by [dec_amt].
   Raises: NoItem when the [item_name] is the name of an item that 
   does not exist in resources. *)
let rec decrease_item_amt 
    (item_name:string) 
    (resources: item list) 
    (dec_amt: int) : item list =
  match resources with 
  | [] -> raise NoItem
  | h::t -> if h.i_name = item_name && h.amount > 0 
  (* Updated to make more useful *)
    then {h with i_name = item_name;amount=h.amount-dec_amt}::t
    else h :: decrease_item_amt item_name t dec_amt

(**[increase_item_amt] is the item list with the amount of the item
   corresponding to [item_name] increased by 1.
   Raises: NoItem when the [item_name] is the name of an item that 
   does not exist in resources. *)
let rec increase_item_amt item_name (resources: item list) : item list =
  match resources with 
  | [] -> raise NoItem
  | h::t -> if h.i_name = item_name && h.amount >= 0 
    then {h with i_name = item_name;amount=h.amount+1}::t
    else h :: increase_item_amt item_name t 

(**[water_waterstatus] returns an updated water status of [plant]
   after you water the [plant] once *)
let rec water_waterstatus plant : water * int  =
  match plant.water, plant.nowater with
  |OK,t -> OK,0
  |NeedsWater,t -> OK,0
  |ReallyNeedsWater,t -> NeedsWater,0
  |Dead,t -> Dead,0

(** [water_plant] returns the field with the
    plant corresponding to [plant_id] watered once*)
let rec water_plant (field: (string*plant) list) plant_id (st:t) = 
  match field with 
  |[] -> []
  |(k, v) :: t -> if k = plant_id 
    then  (k, {v with 
               water =  fst (water_waterstatus v); 
               nowater = 0; 
              }) :: t
    else (k,v):: (water_plant t plant_id st) 

(**[water_plant_ai] returns x with x watered once*)
let rec water_plant_ai  (x:(string*plant)) (st:t):(string*plant)= 
  match x with 
  |(k,v) -> 
    (k,{v with 
        water =  fst (water_waterstatus v); 
        nowater = 0; 
       })

(**[water] updates the state after the 
   plant corresponding to [plant_id] is watered once*)
let water st plant_id : t = 
  {st with 
   field = water_plant st.field plant_id st ;
   resources = decrease_item_amt "water" st.resources 1;
  } 

(** [plant_from_plant_name st plant_name] returns the value associated with key 
    [plant_name] in the list of pairs st.plant_dict. 
    Raise: Not_found if there is no value associated with a in the list l. *)
let rec plant_from_plant_name st (plant_name : string) : plant = 
  List.assoc plant_name st.plant_dict

(** [change_plant_id] is the [plant] with its id changed to [new_id] *)
let change_plant_id (plant:plant) (new_id:string) (t:t)= 
  { plant with 
    id =  new_id;
    plant_time = t.time;
  }

(**[find_plant_name] is the plant in [plantlist] 
   that corresponds to a specific [plant_id] *)
let rec find_plant_name (plantlist: (string*plant) list) (plant_id:string)  = 
  match plantlist with 
  | [] -> raise NoSuchPlant
  | (k, v)::t -> if k = plant_id then v else find_plant_name t plant_id

(** [spray_plant_helper] updates the health of [plant_id] after one spray *)
let rec spray_plant_helper plant_id field : health  = 
  let plant = find_plant_in_field field plant_id in 
  match plant.health with 
  | OK -> OK
  | Sick -> OK
  | ReallySick -> Sick
  |Dead -> Dead 

(** [spray_plant_helper2] updates the health of [plant_id] after one spray *)
let  spray_plant_helper2 (plant:plant): health  = 
  match plant.health with 
  | OK -> OK
  | Sick -> OK
  | ReallySick -> Sick
  |Dead -> Dead

(**[spray_plant] updates the field with [plant_id] sprayed once*)
let rec spray_plant (plant_id : string) 
    (field : (string * plant) list) : ((string * plant) list) = 
  match field with 
  | [] -> []
  | (k,v)::t -> if k = plant_id then 
      (k, {v with 
           health=spray_plant_helper plant_id field; 
           nospray=0;
          }) :: t 
    else (k,v):: spray_plant plant_id t

(**[spray_helper] updates the state after [plant_id] receives one spray*)
let spray_helper st (plant_id:string) : t = 
  {st with 
   field = spray_plant plant_id st.field ;
   resources = decrease_item_amt "spray" st.resources 1;
  } 

(** [issick] is the [plant] with the plant's health updated randomly to 
    either sick or healthy *)
let issick (plant: plant): plant = 
  let num = Random.int 10 in 
  if num<=1 then 
    {plant with 
     health=Sick;
    } else
    plant 

(**[isalive] is a plant with the growth updated to Dead if
   the plant died from thirst or sickness or just not being harvested in time *)
let isalive (plant:plant) : plant = 
  if plant.health = Dead || plant.water = Dead || plant.growth = Dead 
  then {plant with growth = Dead} else plant 

(** [grow_helper_field] is the growth of a [plant] when the plant grows *)
let grow_helper_field plant = 
  match plant.growth with 
  | Seed  -> Halfripe 
  | Halfripe  -> Ripe
  | Ripe  -> Rotten 
  | Rotten -> Dead 
  | Dead -> Dead 
  |_ -> Dead

(**[change_growth plant] gives back a plant with growth status incremented *)
let change_growth (plant:plant): plant = 
  {plant with growth = grow_helper_field plant; 
              nowater = plant.nowater + 1; }

(**[caneat item st] updates the state with hunger decrease if something is eaten,
   raises CantEat if item isn't edible*)
let caneat (item:item) (st:t) : t= 
  if item.edible = false then raise CantEat else
    let new_res = decrease_item_amt item.i_name st.resources 1 in
    {st with 
     hunger = st.hunger + item.hunger_value; 
     resources = new_res;}

(** [water_helper_field plant] updates water status of plant one level *)
let water_helper_field plant = 
  match plant.water with 
  | OK -> NeedsWater
  | NeedsWater -> ReallyNeedsWater
  | ReallyNeedsWater -> Dead 
  | Dead -> Dead 

(** [spray_helper_field plant] updates health of plant by one level *)
let spray_helper_field plant = 
  match plant.health with 
  | OK -> OK
  | Sick -> ReallySick
  | ReallySick -> Dead 
  | Dead -> Dead 

(**[change_water plant] changes water status of plant one level *)
let change_water (plant:plant): plant = 
  {plant with water = water_helper_field plant;
              nowater = plant.nowater+ 1;}

(**[revert_water plant] reverts water status of plant one level *)
let revert_water (plant:plant): plant = 
  {plant with water = fst(water_waterstatus plant);
              nowater = snd(water_waterstatus plant);}

(**[revert_spray plant] reverts spray status of plant one level *)
let revert_spray (plant:plant): plant = 
  {plant with health = spray_plant_helper2 plant;
              nospray = 0;}

(**[change_spray plant] changes health of plant one level *)
let change_spray (plant:plant): plant = 
  {plant with health = spray_helper_field plant; 
              nospray=plant.nospray+1;}

(**[change_spray_and_water plant] 
   changes both health and water of plant by one level *)
let change_spray_and_water (plant:plant): plant = 
  {plant with water = water_helper_field plant; 
              health = spray_helper_field plant; 
              nowater = plant.nowater+1; 
              nospray=plant.nospray+1;}

(**[change_spray_and_growth plant] 
   changes health and growth of plant by one level *)
let change_spray_and_growth (plant:plant): plant = 
  {plant with growth = grow_helper_field plant;
              health = spray_helper_field plant; 
              nospray=plant.nospray+1;}

(**[change_water_and_growth plant] 
   changes water and growth of plant by one level *)
let change_water_and_growth (plant:plant): plant = 
  {plant with growth = grow_helper_field plant; 
              water = water_helper_field plant;
              nowater = plant.nowater+1; }

(**[change_spray_water_and_growth plant] changes 
   health, water, and growth of plant by one level *)
let change_spray_water_and_growth (plant:plant): plant = 
  {plant with   growth = grow_helper_field plant; 
                water = water_helper_field plant; 
                health = spray_helper_field plant;
                nowater = plant.nowater+1;
                nospray=plant.nospray+1; }

(**[change_nowater plant] updates the time with no water of a plant. 
   Adds 1 if it hasnt reached amount needed to change status, 
   resets to 0 otherwise *)
let change_nowater (plant:plant): plant = 
  if plant.nowater <= plant.oknowater + 1 then 
    {plant with nowater = plant.nowater+1; }
  else {plant with nowater = 0;}

(**[change_nospray plant] updates the time with no spray of a plant. 
   Adds 1 if it hasnt reached amount needed to change status, 
   resets to 0 otherwise *)
let change_nospray (plant:plant): plant = 
  if plant.nospray <= plant.oknospray + 1 then 
    {plant with nospray = plant.nospray+1}
  else {plant with nospray = 0}

(** [water_machine_helper t field] waters every plant in the field 
    if it's not a nullplant *)
let rec water_machine_helper t field : (string*plant) list= 
  match field with 
  |[] -> []
  |(k,v)::w -> 
    if v <> nullplant then (k,revert_water v)::water_machine_helper t w
    else (k,v)::water_machine_helper t w 

(** [spray_machine_helper t field] sprays every plant in the field 
    if it's not a nullplant *)
let rec spray_machine_helper t field : (string*plant) list= 
  match field with 
  |[] -> []
  |(k,v)::w -> 
    if v <> nullplant then (k,revert_spray v)::spray_machine_helper t w
    else (k,v)::spray_machine_helper t w 

(** [grow t plant_id] grows the plant if growthfactor is reached, 
    updates water and health status *)
let grow (t:t) (plant_id) : plant= 
  let nowater = (find_plant_in_field t.field plant_id) in 
  let plant = change_nowater (change_nospray nowater) in 
  let modnum_g = ((t.time-plant.plant_time) mod (plant.growthfactor)) in 
  let water = (plant.nowater > plant.oknowater) in
  let spray = (plant.nospray > plant.oknospray) in 
  if (modnum_g = 0 && (t.time-plant.plant_time) <> 0) && water && spray
  then change_spray_water_and_growth plant else 
  if (modnum_g = 0 && (t.time-plant.plant_time) <> 0) && water 
  then change_water_and_growth plant else
  if water && spray then change_spray_and_water plant else
  if (modnum_g = 0 && (t.time-plant.plant_time) <> 0) && spray 
  then change_spray_and_growth plant else
  if modnum_g = 0 && (t.time-plant.plant_time)<> 0 
  then change_growth plant else  
  if water then change_water plant 
  else if spray then change_spray plant else plant 

(** [grow_ai t plant_id] grows the plant if growthfactor is reached, 
    updates water and health status *)
let grow_ai (t:t) (ai_field: (string*plant) list)(plant_id) : plant= 
  let nowater = (find_plant_in_field ai_field plant_id) in 
  let plant = change_nowater (change_nospray nowater) in 
  let modnum_g = ((t.time-plant.plant_time) mod (plant.growthfactor)) in 
  let water = (plant.nowater > plant.oknowater) in
  let spray = (plant.nospray > plant.oknospray) in 
  if (modnum_g = 0 && (t.time-plant.plant_time) <> 0) && water && spray
  then change_spray_water_and_growth plant else 
  if (modnum_g = 0 && (t.time-plant.plant_time) <> 0) && water 
  then change_water_and_growth plant else
  if water && spray then change_spray_and_water plant else
  if (modnum_g = 0 && (t.time-plant.plant_time) <> 0) && spray 
  then change_spray_and_growth plant else
  if modnum_g = 0 && (t.time-plant.plant_time)<> 0 then change_growth plant else  
  if water then change_water plant else if spray then change_spray plant else
    plant  

(** [grow_state_helper t field] grows every plant in the field 
    if it's not a nullplant *)
let rec grow_state_helper t field : (string*plant) list= 
  match field with 
  |[] -> []
  |(k,v)::w -> 
    if v <> nullplant then (k,grow t v.id)::grow_state_helper t w
    else (k,v)::grow_state_helper t w  

(** [grow_state_helper_ai t field] grows every plant in the field 
    if it's not a nullplant *)
let rec grow_state_helper_ai t field : (string*plant) list = 
  match field with 
  |[] -> []
  |(k,v)::w -> 
    if v <> nullplant then (k,grow_ai t field v.id)::grow_state_helper_ai t w
    else (k,v)::grow_state_helper_ai t w  

(** [inventory_num] is the amount of a certain item in your inventory
    Raises: [NoItem] if [name] does not exist in [i] *)
let rec inventory_num (i:item list) (name:string) :int = 
  match i with 
  |[] -> raise NoItem
  |h::t -> if h.i_name = name then h.amount else inventory_num t name 

(** [get_inventory_names] is the list of names of all the items in [inventory]*)
let get_inventory_names (inventory:item list) : string list = 
  List.map (fun x -> x.i_name) inventory 

(**[plant_plant] returns Illegal if there are no nullplants left in the field, 
   or updates the field with the next available nullplant turned into [plant]*)
let rec plant_plant st plant_name (field: (string * plant) list) = 
  let plant = plant_from_plant_name st plant_name in 
  let plants_from_field = List.map (fun x -> (snd x).name) field in 
  if not (List.mem "" plants_from_field) then raise FullField else 
    match field with 
    | [] -> raise FullField
    | (k, v) :: t -> if 
      v = nullplant 
      && 
      List.exists (fun x -> x.i_name= plant.seed_name && x.amount<>0) 
        (st.resources)
      then (k, issick (change_plant_id plant k st)) :: t 
      else if List.length t >=1 then  
        (k, v) :: (plant_plant st plant_name t)
      else (k,v)::t

(**[plant_head] returns Illegal if there are no nullplants left in the field,
   raises InvalidPlant if the plant of plant_name is not a head,  
   or updates the field with the next available nullplant turned into [plant]*)
let rec plant_head st plant_name (field: (string * plant) list) = 
  let plant = plant_from_plant_name st plant_name in 
  if (plant <> chad 
      && plant <> brad && plant <> paul) 
  then raise InvalidPlant
  else
    match field with 
    | [] -> raise FullField
    | (k, v) :: t -> if 
      v = nullplant 
      && 
      List.exists (fun x -> x.i_name= plant.seed_name && x.amount<>0) 
        (st.resources)
      then (k, issick (change_plant_id plant k st)) :: t 
      else if List.length t >=1 then  
        (k, v) :: (plant_head st plant_name t)
      else (k,v)::t

(** [random_plant_prob plantlist num] returns a 
    random plant name from plantlist*)
let random_plant_prob (plantlist: plant list) (num : int): string= 
  let num =  Random.int num in 
  (List.nth plantlist num).name 

(**[snd_plant] returns the list of plants of plantlist*)
let snd_plant (plantlist: (string * plant) list) : plant list = 
  List.map (fun x -> snd x) plantlist 

(** [water_first_thorsty] waters the first thorsty thing in field *)
let rec water_first_thorsty (field:(string * plant) list) (st:t)  = 
  match field with 
  |[] -> []
  |h::t -> if ((snd h).water <> OK) 
    then (water_plant_ai (h) st) :: t 
    else h::(water_first_thorsty t st)

(**[spray_plant_ai] returns the id,plant with x sprayed once *)
let rec spray_plant_ai  (x:(string*plant)) (st:t):(string*plant)= 
  match x with 
  |(k,v) -> 
    (k, {v with 
         health=spray_plant_helper2 v;
         nospray=0;
        })

(** [spray_first_sick] if the field after the ai 
    sprays the first sick thing in field *)
let rec spray_first_sick (field:(string * plant) list) (st:t)  = 
  match field with 
  |[] -> []
  |h::t -> if ((snd h).health <> OK) 
    then (spray_plant_ai (h) st) :: t 
    else h::(spray_first_sick t st)

(** [harvest_first_ripe] is the field after the ai
    harvests the first ripe thing in the fiel *)
let rec harvest_first_ripe (field: (string * plant) list) (st:t) = 
  match field with 
  |[] -> []
  |h::t -> if ((snd h).growth = Ripe) 
    then (fst h, nullplant):: t 
    else h::(harvest_first_ripe t st) 

(**[random_water field st] is the field after the ai 
   randomly waters the first thirsty thing in field at a random probability *)
let random_water (field:(string * plant) list) (st:t)= 
  if( List.exists (fun x -> (snd x).water <> OK) (field)) && Random.int 10 < 7 
  then water_first_thorsty field st else field

(**[random_spray field st] is the field after the ai 
   randomly sprays the first sick thing in field at a random probability  *)
let random_spray (field:(string * plant) list) (st:t)= 
  if( List.exists (fun x -> (snd x).health <> OK) (field)) && Random.int 10 <4 
  then spray_first_sick field st else field

(** [random_harvest] is the field after the ai 
    randomly harvests the first ripe thing in field at a random probability  *)
let random_harvest (field:(string * plant) list) (st:t)=  
  (* let field = (List.nth st.farm_list 0).lst in  *)
  if( List.exists (fun x -> (snd x).growth = Ripe) (field)) && Random.int 10 <5 
  then harvest_first_ripe field st else field

(**[snd_plant] returns the list of plants of plantlist*)
let snd_plant (plantlist: (string * plant) list) : plant list = 
  List.map (fun x -> snd x) plantlist 

(**[random_plant field st] randomly plants a random plant
   in the first null slot of field *)
let random_plant (field:(string * plant) list) (st:t)= 
  if Random.int 10 <7 then 
    plant_plant st (
      fst(List.nth st.plant_dict (Random.int (9)))
    ) field else field 

(** [random_farmer] is the farm with a 
    random possibility of the neighbor appearing*)
let random_farmer (farm:farm) : farm = 
  if Random.int 10 < 3
  then {farm with farmer = true} else {farm with farmer = false}

let random_steal (field: (string * plant) list) (st:t) = 
  if 
    st.current_room <> your_farm && 
    Random.int 10< 6 
  then harvest_first_ripe field st else field 

(**[machine_water_plant_state] returns a field with everything watered every 
   10 turns*)
let machine_water_plant_state (st : t) field : (string*plant) list= 
  if List.mem "watering machine" (get_inventory_names st.resources) 
  && (st.time mod 10 = 0 && st.time <> 0)
  then water_machine_helper st 
      field else field

(**[machine_spray_plant_state] returns a field with everything sprayed with 
   a probability of 40% *)
let machine_spray_plant_state (st : t) field : (string*plant) list= 
  if List.mem "spraying machine" (get_inventory_names st.resources) 
  && (Random.int 10 < 5)
  then spray_machine_helper st 
      field else field

(** [harvest_plant plant] harvests the specified plant. Removing it 
    from the field and depositing the contents into the player's inventory 
    Raises [NoSuchPlantInField] if there is no plant in [field] with id [p_id]*)
let harvest_plant 
    (field: (string * plant) list) 
    (p_id: string)  
  : item list * string =
  let plnt = isalive(find_plant_in_field field p_id) in 
  if plnt.name = "null" then raise NoPlantInField else match plnt.growth with 
    | Seed -> ({i_name =plnt.name ^ " seed"; 
                amount = 1; 
                description = plnt.description; 
                item_value = plnt.unit_price; 
                hunger_value = 0;edible = true}::[], 
               "Probably leave in the ground longer next time.")
    | Halfripe -> ({i_name = "Halfripe " ^ plnt.name; 
                    amount = 2; 
                    description = plnt.description; 
                    item_value = plnt.unit_price; 
                    hunger_value = 5;edible = true}::[], 
                   "Your plants weren't fully grown yet. Patience is key!\nYour harvest isn't worth very much and you didn't get any seeds back.\nNegative work :(.\n")
    | Ripe -> ({i_name = plnt.name; 
                amount =  4; 
                description = plnt.description; 
                item_value = plnt.unit_price; 
                hunger_value = 20;edible = true}::
               {i_name=plnt.name ^ " seed"; 
                amount= 4; 
                description = plnt.description; 
                item_value = plnt.unit_price; 
                hunger_value = 0;edible = true}::[], 
               "Your hard work has paid off!\nSell the produce and use the seed to begin the cycle anew.\n")
    | Rotten -> ({i_name="Rotten " ^ plnt.name;
                  amount=2; 
                  description = plnt.description; 
                  item_value = plnt.unit_price; 
                  hunger_value = -10;edible = true}::[], 
                 "Unfortunately the plants won't wait around, even if you take slip days.\nThere isn't much use for these.\n")
    | Dead -> ({i_name="Dead " ^ plnt.name; 
                amount= 2; 
                description = plnt.description; 
                item_value = plnt.unit_price; 
                hunger_value = -20;edible = true}::[], 
               "Negligence.\n")
    | Empty -> raise NoSuchPlant

(** [update_single_item res new_item] is the [item list] containing 
    the items in [res] with the addition of [new_item] *)
let rec update_single_item (res: item list) (new_item : item) (amt: int) 
  : item list =
  match res with 
  | [] -> {new_item with amount = amt}:: res
  | h::t -> if h.i_name = new_item.i_name 
    then {h with amount = h.amount + amt}::t 
    else h::update_single_item t new_item amt

(** [item_mem item item_list] is true if [item] is in [item_list] else false *)
let rec item_mem (item : item) (item_list : item list) : bool=
  match item_list with
  | [] -> false
  | h::t -> if h.i_name = item.i_name then true else item_mem item t

(** [item_from_item_name name item_list] finds the item in [item_list] 
    with it's name equal to [name].
    Raises: NoItem if there is no item with name [name]. *)
let rec item_from_item_name (name : string) (item_list : item list) : item = 
  match item_list with
  | [] -> raise NoItem
  | h::t -> if h.i_name = name then h else (item_from_item_name name t)

(** [update_inventory res new_items] is an item list containng the items from
    [res] with the addition of [new_items] *)
let rec update_inventory 
    (res: item list) 
    (new_items : item list) 
  : item list =
  match new_items with
  | [] -> res
  | h::t -> if item_mem h res 
    then update_inventory (update_single_item res h h.amount) t 
    else update_inventory (h::res) t

let rec harvest_put_inventory_of_ai (field:(string * plant) list) (st:t) 
  : item list = 
  match field with 
  |[] -> (st.farm).inventory
  |h::t -> if ((snd h).growth = Ripe) 
    then 
      update_inventory (fst (harvest_plant field (snd h).id  )) 
        (st.farm).inventory
    else (harvest_put_inventory_of_ai t st) 

let random_everything (field:(string * plant) list) (st:t) = 
  let random_waters = random_water field st in 
  let random_plants = random_plant random_waters st in 
  let random_sprays = random_spray (random_plants) st in 
  let random_harvests = random_harvest (random_sprays) st in
  random_harvests

(**[random_plant_farm field st farm] updates farm with a 
   random plant with 50% chance planted in field *)
let random_plant_farm (field:(string * plant) list ) (st:t)(farm:farm):farm = 
  {
    farm with 
    lst= grow_state_helper_ai st 
        (random_everything field st );
    inventory = harvest_put_inventory_of_ai farm.lst st 
  }

(**[plant_plant_state] is a state representing the world after 
    a plant is planted
   Raises [FullField] if the field has no more slots *)
let plant_plant_state2 (st : t): t= 
  {st with 
   field = machine_spray_plant_state st
       (machine_water_plant_state st 
          (grow_state_helper st (random_steal st.field st))) ;
   time = st.time + 1;
   farm= random_farmer (random_plant_farm (st.farm).lst st (st.farm)) ;
   (* map_random_plant_farm st st.farm; *)
   hp = update_hp st;
   hunger = update_hunger st
  }

(**[plant_plant_state] raises FullField if the field has no more slots or
   updates the state after [plant] is planted*)
let plant_plant_state st plant_name : t= 
  let plant = plant_from_plant_name st plant_name in 
  {st with 
   field = plant_plant st plant_name st.field;
   resources = decrease_item_amt plant.seed_name st.resources 1;
  } 

(**[plant_head_state] raises FullField if the field has no more slots or
   updates the state after [plant] is planted*)
let plant_head_state st plant_name : t= 
  let plant = plant_from_plant_name st plant_name in 
  if (plant.name <> "chad" && plant.name <> "brad" && plant.name <> "paul") 
  then raise InvalidPlant
  else
    {st with 
     basement = 
       {st.basement with 
        lst = plant_head st plant_name st.basement.lst;};
     resources = decrease_item_amt plant.seed_name st.resources 1;
    } 

(** [remove_plant plant_id field] is the [[field : (string * plant) list] 
    with the specified [plant] replaced by the null plant to symbolize it 
    being harvested from the field *)
let rec remove_plant (plant_id: string) (field : (string * plant) list ) : 
  (string * plant ) list  = 
  match field with 
  | [] -> []
  | (s1, p1)::t -> if p1.id = plant_id then (p1.id, nullplant)::t 
    else (s1, p1):: (remove_plant plant_id t)

(** [harvest plant_id state] is the state resulting from the plant 
    corresponding to [plant_id] being harvested. 
    Updates [resources] with new inventory items
    Increments [time] by one. *)
let harvest (state: t) (plant_id : string)  : t =
  (* First we get the details of what is harvested *)
  let harvest_info = (harvest_plant state.field plant_id ) in 
  let inventory_additions = fst harvest_info in 
  let new_res = update_inventory (state.resources) inventory_additions in
  (* Next we make a new state representing the new state of the game *)
  {state with field = (remove_plant plant_id state.field); 
              resources = new_res; 
              time = state.time + 1}

(**[remove_plant_farm] is the farm with the field 
   after the plant corresponding to [plant_id] is removed *)
let rec remove_plant_farm plant_id (field: (string*plant) list) (farm) : farm = 
  {farm with lst = remove_plant plant_id field}

(**[harvest_ai] is the state after the ai harvests the plant
   corresponding to [plant_id] *)
let harvest_ai (state: t) (plant_id : string) : t = 
  let harvest_info = (harvest_plant (state.farm).lst plant_id ) in
  let inventory_additions = fst harvest_info in 
  let new_res = update_inventory (state.resources) inventory_additions in
  {state with 
   farm = 
     (remove_plant_farm plant_id 
        ((state.farm).lst) 
        (state.farm)) ;
   resources = new_res; 
   time = state.time + 1}

(** [eat item state] gives a new state with updated hunger and resources based 
    on the [item] consumed and the current [state].
    Raises: NoItem if [item] is not in a player's state.resources *)
let eat (item_list : string list) (state : t) : t = 
  let food_str = str_from_strlist item_list in
  (* Get the item from the item name *)
  let food = item_from_item_name food_str state.resources in  
  (* Update the inventory and hunger *)
  let new_res = decrease_item_amt food_str state.resources 1 in
  {state with hunger = state.hunger + food.hunger_value;
              resources = new_res;}

(** [help_growth_char p] is the character representation of the 
    type [growth] that each [plant] contains *)
let help_growth_char (p : plant) : string =
  match p.growth with 
  | Seed -> "🌱"
  | Halfripe -> "🌿"
  | Ripe -> "🍽️"
  | Rotten -> "😵"
  | Dead -> "💀"
  | Empty -> "_"

(** [help_water_char p] is the character representation of the 
    type [water] that each [plant] contains *)
let help_water_char (p:plant) : string = 
  match p.water with 
  | OK -> "👌"
  | NeedsWater -> "💧"
  | ReallyNeedsWater -> "💦"
  | Dead -> "💀"

(** [help_sick_char p] is the character representation of the 
    type [health] that each [plant] contains *)
let help_sick_char (p:plant) : string = 
  match p.health with 
  | OK -> "🆗"
  | Sick -> "🤢"
  | ReallySick -> "🤮"
  | Dead -> "💀"

(** [make_plot p] is the formatted string 
    representing the plot with plant [p] *)
let make_plot (p : plant) : string = 
  "|" ^ p.image ^ ( help_growth_char p) 
  ^ "|" ^ (help_water_char p) 
  ^ "|" ^ (help_sick_char p) 

(** [make_field field] is the string containing all the formatted
    plots in the field. *)
let make_field (field: (string * plant) list) : string list =
  let field_plants = List.split field |> snd in
  List.map make_plot field_plants

(** [pretty_print field count acc row_len]
    is the formatted string representing the [field] *)
let rec pretty_print
    (field : string list )
    (count : int)
    (acc : string)
    (row_len :int) : string =
  match field with
  | [] -> acc
  | h::t -> if count = row_len then
      pretty_print t 1 (acc ^ h ^ "\n") row_len else
      pretty_print t (count + 1) (acc ^ h) row_len

(** [print_hp_bar hp] gives hp bar as a string image representing [hp], 
    which is an int based representation of the player's hp. *)
let print_hp_bar (hp : int) : string = 
  let rec helper counter acc = 
    if counter = 0 then acc else helper (counter - 1) (acc ^ "❤️ ")
  in helper (hp / 10) ""

(** [print_hunger_bar hunger] gives hunger bar as a string image 
    representing [hunger], which is an int based 
    representation of the player's hunger. *)
let print_hunger_bar (hunger : int) : string = 
  let rec helper counter acc = 
    if counter = 0 then acc else helper (counter - 1) (acc ^ "🍖")
  in helper (hunger / 10) ""

(** [print_dig item] gives a string representation 
    of the [item] a player finds while digging. *)
let print_dig (item : item) : string = 
  "You found " ^ item.i_name ^ "!"

(** [growth_string_helper plnt] is the string matching the current value of 
    the variant type [growth] within plant [plnt] *)
let growth_string_helper (plnt : plant) : string = 
  match plnt.growth with 
  | Empty -> "Nothing growing here"
  | Seed -> "Seed." 
  | Halfripe -> "Halfway there." 
  | Ripe -> "Read for harvest. Don't wait too long though!" 
  | Rotten -> "No longer suitable for eating :("
  | Dead -> "It's dead. Better throw it out. Sad."

(** [water_string_helper plnt] is the string matching the current value of 
    the variant type [water] within plant [plnt] *)
let water_string_helper (plnt: plant) : string =
  match plnt.water with
  | OK -> "OK for now"
  | NeedsWater -> "Your plant is beginning to show signs of dehydration."
  | ReallyNeedsWater -> "Your plant desperately needs water."
  | Dead -> "ded"

(** [health_string_helper plnt] is the string matching the current value of 
    the variant type [health] within plant [plnt] *)
let health_string_helper (plnt: plant) : string =
  match plnt.health with 
  | OK -> "Your plant is in good health"
  | Sick -> "Your plant is beginning to show symptoms of disease"
  | ReallySick -> "Your plant is very sick."
  | Dead -> "ded"

(** [observe_plant p_id field] is the formatted string representing 
    the current statistics of the plant matching [p_id] in field [field] 
    Raises [NoPlantInfield] if there is no plant in [field] with id [p_id]*)
let observe_plant (p_id: string) (field : (string * plant) list) : string =
  let plnt = find_plant_in_field field p_id in 
  "Name: " ^ plnt.name ^ "\n" ^
  "id: " ^ plnt.id ^ "\n" ^
  "Description: " ^ plnt.description ^ "\n" ^
  "Growth stage: " ^ growth_string_helper plnt ^ "\n" ^
  "Water: " ^ water_string_helper plnt ^ "\n" ^
  "Health: " ^ health_string_helper plnt ^ "\n" 

(** [dig_helper t] takes in a state [t] and returns a new state with the gold
    item added to a player's resources. The new state also updates hp and 
    hunger. *)
let dig_helper (t : t) : t =
  let item_list = 
    [{i_name = "gold"; amount = 1; description = ""; 
      item_value = 100; hunger_value = 0;edible = false}] in
  { t with 
    resources= update_inventory (t.resources) item_list;
    hp = update_hp t;
    hunger = update_hunger t;
    wallet = t.wallet
  }

(** [lumber_helper t] takes in a state [t] and returns a new state with lumber
    added to a player's resources. The function also prints out how many
    pieces of wood were added to the player's inventory. The new state also 
    updates hp and hunger. *)
let lumber_helper (t : t) : t =
  let random_wood = (Random.int 5) + 1 in 
  print_endline ("You got " ^ string_of_int random_wood ^ " pieces of wood!");
  let item_list = [{i_name = "wood"; amount = random_wood; description = ""; 
                    item_value = 0; hunger_value = 0;edible = false}] in
  { t with 
    resources= update_inventory (t.resources) item_list;
    hp = update_hp t;
    hunger = update_hunger t
  }

(** [next_rooms] takes in current room and gives room list w/o current room *)
let rec next_rooms (room:room)(all_rooms: room list)(acc: room list):room list = 
  match all_rooms with 
  |[]-> acc
  |h::t -> if h.r_id <> room.r_id 
    then next_rooms room t (h::acc) else next_rooms room t acc

(**[room_id_from_room_list room_list] returns a list of room ids from the list*)
let room_id_from_room_list (room_list: room list): string list = 
  List.map (fun x -> x.r_id) room_list

(**[find_room_from_id] finds the room from the room id  *)
let rec find_room_from_id (id:string) (roomlist: room list) :room = 
  match roomlist with 
  |[] -> raise NoSuchRoom
  |h::t -> if h.r_id = id then h else find_room_from_id id t

(******** Helper Functions for Buying and Selling Commands ********)

(** [check_in_inv res item_name] is true if the player inventory 
    contains [item] else false *)
let rec check_in_inv (res: item list) (item_name: string) (amt: int) : bool = 
  match res with 
  | [] -> false
  | h::t -> if (h.i_name = item_name && h.amount >=amt) 
    then true 
    else check_in_inv t item_name amt

(** [calc_price plant amt] is the amount of money required to buy [amt]
    [item_id]s 
    Raises NotFound if [item_id] is not a valid item
    Raises NoItem if the player or shop does not have [item_id]*)
let rec calc_price (item_id: string) (res: item list) (amt: int) : int =
  if check_in_inv res item_id amt then 
    let new_item = item_from_item_name item_id res in
    new_item.item_value * amt
  else raise NoItem 

(** [add_funds state funds] is a new state in which the player's [wallet] 
    value has been increased with the amount [funds] *)
let add_funds (state:t) (funds:int) : t =
  {state with wallet = state.wallet + funds}

(** [subtract_funds state cost] is a new state in which the player's [wallet]
    value has been decreased with the amount they paid *)
let subtract_funds (state:t) (cost:int) : t =
  {state with wallet = state.wallet - cost}

(** [sell_crop state item amt] is the state resulting from the sale of 
    [amt] [item]s if the sale is valid.*)
let sell_crop (state:t) (item_name: string) (amt: int) : t = 
  let value = calc_price item_name state.resources amt in
  (* let item_sell = item_from_item_name item_name store_inv in *)
  {state with 
   wallet = state.wallet + (value) ;
   resources = decrease_item_amt item_name state.resources amt}

(** [buy_item state item_name amt] is the state resulting from the purchase
    of [amt] [item_name]s if that purchase is legal *)
let buy_item (state:t) (item_name: string) (amt: int) : t =
  if state.wallet <= 0 then raise NoMoney else 
    let value = (((item_from_item_name item_name store_inv).item_value)*amt) in
    let item_purchase = item_from_item_name item_name store_inv in
    if value > state.wallet then raise NotEnough else 
      {state with  
       wallet = state.wallet - value;
       resources = update_single_item state.resources item_purchase amt}

(******* Helper functions for trading items with NPCs ********)

(** [trade_calc player_items acc amt] is the item list 
     containing the minimum amount of items whose values add up to [amt] *)
let rec trade_calc (player_items: item list) (acc: item list) (amt: int) 
  : item list =
  match List.filter 
          (fun x -> x<> chad_head && x <> brad_head && x <> paul_head) 
          player_items with 
  | [] -> if amt = 0 then acc else []
  | h::t -> 
    (* Ignore items with amount 0 *)
    if h.amount = 0  then trade_calc t acc amt else
      (* If the desired amount is evenly divisible by the item value *)
    if amt mod h.item_value = 0 
    then let needed_amount = (amt / h.item_value) in 
      if h.amount >= needed_amount 
      then {h with amount= needed_amount}::acc
      else let new_inv = t in 
        let new_amt = amt - (h.item_value * h.amount) in 
        trade_calc new_inv (h::acc) new_amt
    else 
    if (h.item_value * h.amount) >= amt 
    then {h with amount = ((amt / h.item_value) + 1)}::acc 
    else let inv2 = t in 
      let amt2 = amt - (h.item_value * h.amount) in 
      trade_calc inv2 (h::acc) amt2

(* [negate_item_list_helper items acc] is the item list 
    with the amounts negated *)
let rec negate_item_list_helper (items: item list) (acc: item list): item list = 
  match items with 
  | [] -> acc
  | h::t -> negate_item_list_helper t ({h with amount = h.amount * -1}::acc)

(** [make_trade npc_res player_res farmer_item player_items] is a pair 
     containing the item lists representing the new inventories of both 
     the npc and the player once a trade is completed *)
let make_trade 
    (npc_res: item list) 
    (player_res : item list) 
    (farmer_item : item)  
    (player_items : item list) : (item list) * (item list) =
  let new_npc_res = update_inventory 
      ((decrease_item_amt farmer_item.i_name npc_res farmer_item.amount)) 
      player_items in 
  let removed_player_inv = update_inventory player_res 
      (negate_item_list_helper player_items []) in 
  let new_player_inv = update_inventory removed_player_inv (farmer_item::[]) in 
  (new_npc_res, new_player_inv)

(**[remove_room_from_allrooms] returns all rooms with room of room_id removed *)
let remove_room_from_allrooms (st:t)(room_id: string): room list = 
  List.filter (fun x -> x.r_id <> room_id) st.all_rooms

let rec increment_id (field:(string * plant) list) (st:t) 
  :(string * plant) list =
  match field with 
  |[] -> [] 
  |h::t -> 
    if (snd h) <>nullplant 
    then 
      (string_of_int(List.length st.field
                     + (int_of_string (fst h))),
       {(snd h) with id =  string_of_int(List.length st.field
                                         + (int_of_string (fst h)))
       }):: increment_id t st    
    else
      (string_of_int(List.length st.field
                     + (int_of_string (fst h))), snd h):: increment_id t st

(** [attack_helper st] returns the updated state with changed opponent hp based 
    on the player's current move. *)
let attack_helper (st : t) : t = 
  let opponent_hp = if st.opponent.weakness = st.move.m_name then
      st.opponent.hp - (3*st.move.attack) else
      st.opponent.hp - st.move.attack in
  if not(List.mem nullplant (List.map (fun x -> snd x )st.basement.lst)) && 
     st.current_room.r_id = "your basement" && opponent_hp <=0 then 
    {st with resources = update_inventory ([satanic_power]) st.resources}
  else 
  if st.current_room.r_id = "your neighbor's house" && opponent_hp <= 0 
     && st.farm.farm_name = "Chad's farm" then 
    {st with field = st.field@  increment_id st.farm.lst st;
             resources = update_inventory (chad_head::cherry_seed::st.resources) 
                 st.farm.inventory; 
             farm = neighbor2_farm;
    } else 
  if st.current_room.r_id = "your neighbor's house" && opponent_hp <= 0 
     && st.farm.farm_name = "Brad's farm" then
    {st with field = st.field@increment_id st.farm.lst st;
             resources = update_inventory 
                 (brad_head::banana_seed::st.resources) 
                 st.farm.inventory; 
             farm = neighbor3_farm;
    } else 
  if st.current_room.r_id = "your neighbor's house" && opponent_hp <= 0 
     && st.farm.farm_name = "Paul's farm" then
    {st with field = st.field@increment_id st.farm.lst st;
             resources = update_inventory 
                 (eggplant_seed::paul_head::st.resources) 
                 st.farm.inventory; 
             all_rooms = remove_room_from_allrooms st "your neighbor's house";
             farm = null_farm
    } else 
  if opponent_hp <= 0 then 
    {st with 

     resources = update_inventory st.resources st.opponent.loot}
  else {st with opponent = {st.opponent with hp = opponent_hp}} 

(** [opponent_helper st] returns the state of the player after the opponent 
    acts in the combat. *)
let opponent_helper (st : t) : t =
  let player_hp = st.hp - st.opponent.move.attack in
  if player_hp <= 0 then {st with hp = 0} 
  else if st.opponent = satan then 
    {st with hp = player_hp; 
             opponent = {st.opponent with 
                         move = List.nth 
                             (List.map (fun x -> snd x)move_dictionary) 
                             (Random.int 9)}} else {st with hp = player_hp}

(** [go_state] is the state after you go to a different room*)
let go_state (room:room) (t:t) (nextroomlist : room list) : t = 
  {t with 
   current_room= room;
   next_rooms= nextroomlist;
   hp = update_hp t;
   hunger = update_hunger t
  }