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

val corn: plantEntry
val apple: plantEntry