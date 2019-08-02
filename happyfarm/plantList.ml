type water = OK | NeedsWater | ReallyNeedsWater                           
type health = OK | Sick | ReallySick
type growth = Seed of int | Halfripe of int | Ripe of int | Rotten | Dead 


type plantEntry = 
  {
    name:string;
    id: string;
    image: string;
    description:string;
    growth:growth;
    water:water;
    health: health;
    growthfactor:int;
    nowater:int;
    oknowater:int;
  } 

(* Plant Encylopedia *)
let corn = 
  {
    name = "corn";
    id = "corn1";
    image = "🌽";
    description= "cornhub";
    growth= Seed 1;
    water= NeedsWater;
    health= OK;
    growthfactor= 3;
    nowater= 0;
    oknowater= 10;
  } 

let apple = 
  {
    name = "apple";
    id = "1";
    image = "🍎";
    description= "a healthy red fruit";
    growth= Seed 1;
    water= NeedsWater;
    health= OK;
    growthfactor= 3;
    nowater= 0;
    oknowater= 10;
  } 


