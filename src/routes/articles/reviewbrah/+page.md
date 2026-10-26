<script>
  import { onMount } from 'svelte';
  let sortCol = $state('date');
  let sortAsc = $state(false);
  let timelineEl = $state();
  let yearEl = $state();
  let spreadEl = $state();
  let priceEl = $state();
  let chainsEl = $state();
  let eraEl = $state();
  let souredEl = $state();

  const ratings = [
    {item:"Cheesy Bites Pizza",restaurant:"Pizza Hut",cost:"$14.99",rating:"7.4",date:"2026-10-24",vid:"zp7IdETkIs4"},
    {item:"Steak Double Dipping Burritos",restaurant:"Taco Bell",cost:"$6",rating:"0.2",date:"2026-10-17",vid:"4qe2eqk3dik"},
    {item:"Game Day Pretzel Burger",restaurant:"Burger King",cost:"$11",rating:"8.2",date:"2026-10-09",vid:"PSTVgJ9xTQg"},
    {item:"Smoked Cheddar CurderBurger",restaurant:"Culver's",cost:"$8.50",rating:"8.8",date:"2026-10-03",vid:"iPce0zAGzX8"},
    {item:"Diablo Ranch Crispy Chicken Crunch Wrap Slider",restaurant:"Taco Bell",cost:"$3",rating:"7",date:"2026-09-24",vid:"BSi0xorsMpY"},
    {item:"Spicy Chicken McNuggets (10-piece)",restaurant:"McDonald's",cost:"$7",rating:"8.4",date:"2026-09-18",vid:"9lwB6Pra3cI"},
    {item:"Domino",restaurant:"Domino's",cost:"$8.75",rating:"3",date:"2026-09-03",vid:"UKqYVOFiVaw"},
    {item:"Chicken and Waffles",restaurant:"Chick-fil-A",cost:"$5",rating:"9.7",date:"2026-08-24",vid:"rDHdv1gzLt4"},
    {item:"Buttermilk Crispy Chicken Strips",restaurant:"IHOP",cost:"$13.69",rating:"8.7",date:"2026-08-16",vid:"HeFGcPzvdtg"},
    {item:"Popcorn Chicken",restaurant:"KFC",cost:"$6",rating:"9.5",date:"2026-07-29",vid:"KPJ_1gG89g4"},
    {item:"Epic Pepperoni Stuffed Crust Pizza",restaurant:"Papa John's",cost:"$14.99",rating:"9.2",date:"2026-07-22",vid:"Ct33LJ1pzxY"},
    {item:"Loaded Jalapeño Original Chicken Sandwich",restaurant:"Burger King",cost:"$9.08",rating:"0.3",date:"2026-07-13",vid:"sJKgIb7powk"},
    {item:"Webberoni Pizza",restaurant:"Little Caesars",cost:"$10",rating:"8.8",date:"2026-06-23",vid:"SBYkllYfxf4"},
    {item:"Minions & Monsters Meal",restaurant:"Wendy's",cost:"$17",rating:"7.0",date:"2026-06-17",vid:"rOrjSCFNtEA"},
    {item:"FIFA World Cup Meal",restaurant:"McDonald's",cost:"$14",rating:"6.5",date:"2026-06-10",vid:"Lj30E4fCrT4"},
    {item:"Crispy Parm Pan Pizza",restaurant:"Pizza Hut",cost:"$16",rating:"8.4",date:"2026-06-04",vid:"lUeXHPJwnEU"},
    {item:"Space Ranger Roni Pizza",restaurant:"Papa John's",cost:"$9",rating:"8.6",date:"2026-05-29",vid:"VTaPJKLrc2c"},
    {item:"Boneless Bucket",restaurant:"KFC",cost:"$16",rating:"3.5",date:"2026-05-22",vid:"7mNqOUqRiDg"},
    {item:"Barbecue Bounty Whopper",restaurant:"Burger King",cost:"$10.99",rating:"8.5",date:"2026-05-04",vid:"SbbzlfXeeZo"},
    {item:"Grogu's Garlic Chicken Fries",restaurant:"Burger King",cost:"$5.50",rating:"4",date:"2026-05-04",vid:"SbbzlfXeeZo"},
    {item:"Imperial Cheddar Ranch Tots",restaurant:"Burger King",cost:"$2.50",rating:"7.6",date:"2026-05-04",vid:"SbbzlfXeeZo"},
    {item:"Grogu's Blue Cookie Shake",restaurant:"Burger King",cost:"$6.00",rating:"6.6",date:"2026-05-04",vid:"SbbzlfXeeZo"},
    {item:"Diablo Dusted Crispy Chicken Nuggets",restaurant:"Taco Bell",cost:"$5.00",rating:"0.3",date:"2026-04-25",vid:"5oE4KlcEYTg"},
    {item:"Updated Spicy Chicken Sandwich",restaurant:"Wendy's",cost:"$7.30",rating:"2",date:"2026-04-17",vid:"GBQsioHQGx4"},
    {item:"HUNTR/X Meal",restaurant:"McDonald's",cost:"$11.50",rating:"7.5",date:"2026-04-10",vid:"mKNOosCLMGw"},
    {item:"Crispy Chicken Crunch Wrap Slider",restaurant:"Taco Bell",cost:"$3.70",rating:"0",date:"2026-04-02",vid:"_UYQNFTypDo"},
    {item:"Jalapeno Ranch Club Sandwich",restaurant:"Chick-fil-A",cost:"$11.00",rating:"8",date:"2026-03-26",vid:"y91oMX0vR-U"},
    {item:"New And Improved Whopper",restaurant:"Burger King",cost:"$9.00",rating:"8.7",date:"2026-03-15",vid:"vWLkSdYgDts"},
    {item:"Big Arch",restaurant:"McDonald's",cost:"$11.00",rating:"8.5",date:"2026-03-03",vid:"F3DS7Og5a9w"},
    {item:"Reimagined Pan Pizza",restaurant:"Papa John's",cost:"$18.00",rating:"4",date:"2026-02-23",vid:"ruZue_kKnpg"},
    {item:"Crispy Chicken Nuggets",restaurant:"Taco Bell",cost:"$6.00",rating:"8.5",date:"2026-02-12",vid:"LPRHCgc0Oo8"},
    {item:"Diablo Ranch Sauce",restaurant:"Taco Bell",cost:"-",rating:"8",date:"2026-02-12",vid:"LPRHCgc0Oo8"},
    {item:"Bacon Hot Honey Chicken McCrispy Sandwich",restaurant:"McDonald's",cost:"$8.20",rating:"2",date:"2026-01-30",vid:"uqk4Z_d0q3M"},
    {item:"All-American Smasher Meal",restaurant:"Sonic",cost:"$6.00",rating:"9.1",date:"2026-01-23",vid:"5JGfGqH5Oyg"},
    {item:"Volcano Quesarito",restaurant:"Taco Bell",cost:"$5.50",rating:"7",date:"2026-01-16",vid:"49oIcl65h5A"},
    {item:"SpongeBob's Crabby Whopper",restaurant:"Burger King",cost:"$8.50",rating:"0.2",date:"2025-12-15",vid:"HO9NzMSmYG8"},
    {item:"Mr. Krabs' Cheesy Bacon Tots",restaurant:"Burger King",cost:"$3",rating:"8.0",date:"2025-12-15",vid:"HO9NzMSmYG8"},
    {item:"Steak & Poblano Rolled Quesadilla",restaurant:"Taco Bell",cost:"$5.69",rating:"8.6",date:"2025-12-10",vid:"0AeKwiGCaU4"},
    {item:"Grinch Meal",restaurant:"McDonald's",cost:"$15",rating:"8.0",date:"2025-12-03",vid:"W2C7gsETmuE"},
    {item:"Spicy Chicken Ranch Bacon Pizza",restaurant:"Domino's",cost:"$20",rating:"2",date:"2025-11-26",vid:"F2zGpZla-cg"},
    {item:"McRib 2025",restaurant:"McDonald's",cost:"$7",rating:"9.2",date:"2025-11-18",vid:"WNtrj0bjxhU"},
    {item:"Baja Blast Pie",restaurant:"Taco Bell",cost:"$20",rating:"8.8",date:"2025-11-08",vid:"smdJy9Go9i8"},
    {item:"Steak Nuggets",restaurant:"Arby's",cost:"$5.29",rating:"4.8",date:"2025-11-03",vid:"ciRQ4x7GRps"},
    {item:"Whopper (received instead of Jack O' Lantern Whopper)",restaurant:"Burger King",cost:"$10",rating:"2.1",date:"2025-10-27",vid:"Itli3uhTBRs"},
    {item:"Flamin' Hot Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$6-$8",rating:"9.2",date:"2025-10-19",vid:"7XsUVfjkVSc"},
    {item:"Honey BBQ Sauce on Chicken Tenders",restaurant:"KFC",cost:"$11",rating:"3",date:"2025-10-11",vid:"66R654eVkAg"},
    {item:"Chicken Tendys",restaurant:"Wendy's",cost:"$5",rating:"8.5",date:"2025-10-07",vid:"JB2r5xylp6s"},
    {item:"Sizzling Sriracha Dippers",restaurant:"Popeyes",cost:"-",rating:"6",date:"2025-09-29",vid:"5uJ0ygi-4Pk"},
    {item:"Smoking Rojo Sandwich",restaurant:"Popeyes",cost:"-",rating:"2",date:"2025-09-29",vid:"5uJ0ygi-4Pk"},
    {item:"Ghost Pepper Wings (without sauce)",restaurant:"Popeyes",cost:"-",rating:"4",date:"2025-09-29",vid:"5uJ0ygi-4Pk"},
    {item:"Ghost Pepper Wings (with Last Dab Ranch)",restaurant:"Popeyes",cost:"-",rating:"6.5",date:"2025-09-29",vid:"5uJ0ygi-4Pk"},
    {item:"The Last Dab Apollo Hot Sauce",restaurant:"Popeyes",cost:"$1",rating:"9",date:"2025-09-29",vid:"5uJ0ygi-4Pk"},
    {item:"Hot Ones Menu (overall)",restaurant:"Popeyes",cost:"~$22",rating:"6",date:"2025-09-29",vid:"5uJ0ygi-4Pk"},
    {item:"Papa Dippa Pizza",restaurant:"Papa John's",cost:"$13.99",rating:"7.9",date:"2025-09-22",vid:"G-9esJjl3Wo"},
    {item:"Cheesesteak Crazy Puffs",restaurant:"Little Caesars",cost:"$4.81",rating:"8.8",date:"2025-09-16",vid:"zoDXgAkImDw"},
    {item:"Special Edition Gold Sauce",restaurant:"McDonald's",cost:"$2.89",rating:"6",date:"2025-09-12",vid:"fd4Pfdte48k"},
    {item:"Pretzel Cheddar Club Sandwich (Original)",restaurant:"Chick-fil-A",cost:"-",rating:"9.9",date:"2025-09-03",vid:"F6arsDf2vZk"},
    {item:"McDonaldland Meal (10-piece nuggets)",restaurant:"McDonald's",cost:"$17.30",rating:"6.5",date:"2025-08-19",vid:"0EJR10row68"},
    {item:"Garlic 5-Cheese Crust Pizza (Large Pepperoni)",restaurant:"Papa John's",cost:"$12.00",rating:"9",date:"2025-08-13",vid:"kAZCLM1zs0g"},
    {item:"Wednesday Meal of Misfortune",restaurant:"Wendy's",cost:"$15.00",rating:"6.5",date:"2025-08-08",vid:"uHF2VEmltW0"},
    {item:"Hot Lemon Wings (10-piece bone-in)",restaurant:"Wingstop",cost:"$14.00",rating:"8.5",date:"2025-08-04",vid:"B8cGvr5uBKo"},
    {item:"Sweet Chipotle Barbecue Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$3.19",rating:"1.2",date:"2025-07-28",vid:"4sVCxkGDIgc"},
    {item:"Chicken Dippers with Signature Sauce",restaurant:"Popeyes",cost:"$5.00",rating:"8.25",date:"2025-07-23",vid:"bmDvpbiO_J8"},
    {item:"Barbecue Brisket Whopper",restaurant:"Burger King",cost:"$10.00",rating:"6.7",date:"2025-07-18",vid:"2baCDsF-CqY"},
    {item:"Spicy Snack Wrap",restaurant:"McDonald's",cost:"$3.79",rating:"6.5",date:"2025-07-13",vid:"IPm-HeBe6V8"},
    {item:"Ranch Snack Wrap",restaurant:"McDonald's",cost:"$3.79",rating:"8.6",date:"2025-07-13",vid:"IPm-HeBe6V8"},
    {item:"Avocado Ranch Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$3.20",rating:"0.5",date:"2025-07-08",vid:"aWsXuiTRcd8"},
    {item:"Fantastic Four in One Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"8",date:"2025-06-30",vid:"0PfYkgucg04"},
    {item:"Takis Fuego Meal",restaurant:"Wendy's",cost:"$11.97",rating:"8.9",date:"2025-06-23",vid:"-k4Y82W9res"},
    {item:"Hershey's S'mores McFlurry",restaurant:"McDonald's",cost:"$5.00",rating:"6",date:"2025-06-16",vid:"t_P1uKfWRgI"},
    {item:"Cheddar Crust Pizza (Large Pepperoni)",restaurant:"Papa John's",cost:"$13.00",rating:"8.4",date:"2025-06-10",vid:"8b424AVphgg"},
    {item:"Chicken Wrap (Classic)",restaurant:"Popeyes",cost:"$5.00",rating:"2.5",date:"2025-06-05",vid:"cQ0-LRrm9os"},
    {item:"Dragon Flame-Grilled Whopper",restaurant:"Burger King",cost:"$8.50",rating:"6",date:"2025-05-29",vid:"X2pxi8bUzgk"},
    {item:"Fiery Dragon Mozzarella Fries",restaurant:"Burger King",cost:"$3.29",rating:"7",date:"2025-05-29",vid:"X2pxi8bUzgk"},
    {item:"Soarin' Strawberry Lemonade",restaurant:"Burger King",cost:"$3.50",rating:"7.2",date:"2025-05-29",vid:"X2pxi8bUzgk"},
    {item:"Viking's Chocolate Sundae",restaurant:"Burger King",cost:"$2.00",rating:"8",date:"2025-05-29",vid:"X2pxi8bUzgk"},
    {item:"Mike's Hot Honey Diablo Sauce",restaurant:"Taco Bell",cost:"$0.25",rating:"1",date:"2025-05-25",vid:"U_U0sWgtlIQ"},
    {item:"KFC Chicken & Waffles (3-piece tender meal)",restaurant:"KFC",cost:"$10.60",rating:"2.5",date:"2025-05-19",vid:"KGQJRuxgp6Q"},
    {item:"McCrispy Strips (3-piece)",restaurant:"McDonald's",cost:"$5",rating:"8.5",date:"2025-05-04",vid:"95MPtROAH3Q"},
    {item:"Crispy Chicken Nuggets (10-piece combo)",restaurant:"Taco Bell",cost:"$9",rating:"7",date:"2025-04-28",vid:"qm21P3lkdiw"},
    {item:"Cajun Crunch Spicy Chicken Sandwich",restaurant:"Wendy's",cost:"$7.50",rating:"2",date:"2025-04-22",vid:"dG7duCPX6Js"},
    {item:"Pickle Glaze Chicken Sandwich",restaurant:"Popeyes",cost:"$6",rating:"8.7",date:"2025-04-14",vid:"0Kf3r1Fsb1I"},
    {item:"Pickle Lemonade",restaurant:"Popeyes",cost:"$4.35",rating:"6.5",date:"2025-04-14",vid:"0Kf3r1Fsb1I"},
    {item:"Minecraft Movie Meal (10-piece McNuggets)",restaurant:"McDonald's",cost:"$15",rating:"7",date:"2025-04-05",vid:"oYkR74FvQFI"},
    {item:"Cheesy Bites Pizza (Ranch Lover's Flight)",restaurant:"Pizza Hut",cost:"$14",rating:"7",date:"2025-04-01",vid:"QbnTyMfSkuc"},
    {item:"Smokehouse Barbecue Bacon Sandwich",restaurant:"Chick-fil-A",cost:"$7.85",rating:"9.4",date:"2025-03-25",vid:"-Z8nUFV5ghk"},
    {item:"Steakhouse Bacon Whopper",restaurant:"Burger King",cost:"$9",rating:"7.2",date:"2025-03-17",vid:"l7jgsnfQyig"},
    {item:"Steak & Queso Crunchwrap Sliders",restaurant:"Taco Bell",cost:"$5",rating:"5",date:"2025-03-10",vid:"QNMzlfe-xn0"},
    {item:"Steak & Queso Crunchwrap Sliders - Green Chile Verde Sauce",restaurant:"Taco Bell",cost:"-",rating:"1",date:"2025-03-10",vid:"QNMzlfe-xn0"},
    {item:"Parmesan Stuffed Crust Pizza (Pepperoni)",restaurant:"Domino's",cost:"$9.99",rating:"8.6",date:"2025-03-05",vid:"fUNeAqnACHU"},
    {item:"Birthday Cake Churros",restaurant:"Taco Bell",cost:"$1.99",rating:"9.1",date:"2025-02-25",vid:"cJwG9lfJqss"},
    {item:"Mike's Hot Honey Chicken Tenders",restaurant:"KFC",cost:"$7",rating:"4",date:"2025-02-18",vid:"ms5k-1ZRzEw"},
    {item:"Bacon & Cheese Crazy Puffs",restaurant:"Little Caesars",cost:"$3.99",rating:"9",date:"2025-02-11",vid:"HAXQTX8YWtk"},
    {item:"Barbecue Bacon Quarter Pounder (Angel Reese Special - as received, no bacon)",restaurant:"McDonald's",cost:"$12.79",rating:"7",date:"2025-02-05",vid:"lrWrUk8wCNw"},
    {item:"Barbecue Bacon Quarter Pounder (Angel Reese Special - as intended, with bacon)",restaurant:"McDonald's",cost:"$12.79",rating:"8",date:"2025-02-05",vid:"lrWrUk8wCNw"},
    {item:"Hot Buffalo Loaded Chicken",restaurant:"Domino's",cost:"$8",rating:"1",date:"2025-01-30",vid:"8z8qPUwiq_4"},
    {item:"Cheesy Dipping Burritos (Chicken)",restaurant:"Taco Bell",cost:"$6",rating:"8.4",date:"2025-01-24",vid:"nsesgsBDJ0Q"},
    {item:"Chick-fil-A New Fries",restaurant:"Chick-fil-A",cost:"-",rating:"1",date:"2025-01-16",vid:"CUPYF0uwy7Y"},
    {item:"Nashville Hot Chicken Tenders",restaurant:"KFC",cost:"$10",rating:"7.6",date:"2025-01-11",vid:"HILRzp-009c"},
    {item:"Taco Bell Luxe Cravings Box (2025 Edition)",restaurant:"Taco Bell",cost:"$7",rating:"8.9",date:"2025-01-05",vid:"8w2YrsJwZd4"},
    {item:"Caramel Apple Empanada",restaurant:"Taco Bell",cost:"$2.99",rating:"5.5",date:"2024-12-09",vid:"w_fCkwqW0DM"},
    {item:"Maple Bourbon Barbecue Whopper",restaurant:"Burger King",cost:"$8.00",rating:"7.4",date:"2024-11-26",vid:"V4PO9nsW3aU"},
    {item:"Pickle Fries",restaurant:"Burger King",cost:"$5.00",rating:"1.0",date:"2024-11-26",vid:"V4PO9nsW3aU"},
    {item:"Big Clucking Chicken Sandwich",restaurant:"Applebee's",cost:"$10.00",rating:"9.4",date:"2024-11-20",vid:"uJ3EmZfe6_0"},
    {item:"Midnight Cherry Freeze",restaurant:"Taco Bell",cost:"$3.80",rating:"4.6",date:"2024-11-16",vid:"GArBOVsgYV8"},
    {item:"Shakaroni Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"9.2",date:"2024-11-09",vid:"siZh9fnoUYU"},
    {item:"Tostada",restaurant:"Taco Bell",cost:"$2.19",rating:"6.0",date:"2024-11-02",vid:"q79Hz1hV1nE"},
    {item:"Green Sauce Burrito",restaurant:"Taco Bell",cost:"$2.49",rating:"4.9",date:"2024-11-02",vid:"q79Hz1hV1nE"},
    {item:"Meximelt",restaurant:"Taco Bell",cost:"$3.00",rating:"8.5",date:"2024-11-02",vid:"q79Hz1hV1nE"},
    {item:"Gordita Supreme",restaurant:"Taco Bell",cost:"$2.99",rating:"8.8",date:"2024-11-02",vid:"q79Hz1hV1nE"},
    {item:"KFC Original Recipe Tenders",restaurant:"KFC",cost:"$5.00",rating:"7",date:"2024-10-28",vid:"t945R5UH1-Y"},
    {item:"KFC Comeback Sauce",restaurant:"KFC",cost:"-",rating:"3",date:"2024-10-28",vid:"t945R5UH1-Y"},
    {item:"Wednesday's Whopper",restaurant:"Burger King",cost:"$7.00",rating:"8",date:"2024-10-20",vid:"evrINc_GNVc"},
    {item:"Things Rings",restaurant:"Burger King",cost:"$3.49",rating:"6.8",date:"2024-10-20",vid:"evrINc_GNVc"},
    {item:"Morticia Cookie Chocolate Shake",restaurant:"Burger King",cost:"$5.00 - $6.00",rating:"7.2",date:"2024-10-20",vid:"evrINc_GNVc"},
    {item:"Chicken Big Mac",restaurant:"McDonald's",cost:"$6.00",rating:"4.2",date:"2024-10-15",vid:"bgUYGjQ14Ks"},
    {item:"Krabby Patty collab Burger",restaurant:"Wendy's",cost:"$9.00",rating:"8.5",date:"2024-10-08",vid:"4ayXqWqS7zs"},
    {item:"Pineapple under the sea Frosty",restaurant:"Wendy's",cost:"$9.00",rating:"8.6",date:"2024-10-08",vid:"4ayXqWqS7zs"},
    {item:"Witches Brew Slush Float",restaurant:"Sonic",cost:"$4.00",rating:"9.2",date:"2024-10-05",vid:"XEvg_kBYcl8"},
    {item:"Giant Cheez-It Tostada",restaurant:"Taco Bell",cost:"$3.65",rating:"8",date:"2024-09-23",vid:"RMrZv6vMqPI"},
    {item:"Giant Cheez-It Crunch Wrap",restaurant:"Taco Bell",cost:"$3.65",rating:"8",date:"2024-09-23",vid:"RMrZv6vMqPI"},
    {item:"Patty Melt",restaurant:"Five Guys",cost:"$10.00",rating:"7",date:"2024-09-18",vid:"bkGoDSoGqeE"},
    {item:"Bacon Burger",restaurant:"Five Guys",cost:"$10.00",rating:"8",date:"2024-09-18",vid:"bkGoDSoGqeE"},
    {item:"Cajun Fries",restaurant:"Five Guys",cost:"$5.00",rating:"8",date:"2024-09-18",vid:"bkGoDSoGqeE"},
    {item:"Mountain Dew Baja Blast Gelato",restaurant:"Taco Bell",cost:"$4.00",rating:"6.7",date:"2024-09-05",vid:"D4EGjw_4R-g"},
    {item:"Honey Pepper Pimento Chicken Sandwich",restaurant:"Chick-fil-A",cost:"$7.55",rating:"9.4",date:"2024-08-30",vid:"0UgFWbWLFWM"},
    {item:"Bourbon Barbecue Chicken Sandwich",restaurant:"Arby's",cost:"$7.50 - $9.00",rating:"0",date:"2024-08-19",vid:"5bQAO76HvHo"},
    {item:"Curly Fries",restaurant:"Arby's",cost:"$2.00 - $3.00",rating:"0",date:"2024-08-19",vid:"5bQAO76HvHo"},
    {item:"Jamoka Shake",restaurant:"Arby's",cost:"$2.00 - $4.00",rating:"5",date:"2024-08-19",vid:"5bQAO76HvHo"},
    {item:"KFC Saucy Nuggets",restaurant:"KFC",cost:"$17.25",rating:"5.0",date:"2024-08-13",vid:"XE90LyCTkO4"},
    {item:"KFC Chipotle Ranch",restaurant:"KFC",cost:"$5.75",rating:"3.0",date:"2024-08-13",vid:"XE90LyCTkO4"},
    {item:"KFC Mango Habanero",restaurant:"KFC",cost:"$5.75",rating:"6.7",date:"2024-08-13",vid:"XE90LyCTkO4"},
    {item:"KFC Honey Garlic",restaurant:"KFC",cost:"$5.75",rating:"5.0",date:"2024-08-13",vid:"XE90LyCTkO4"},
    {item:"Culver's JJ Watt Meal",restaurant:"Culver's",cost:"$10.00",rating:"8.5",date:"2024-08-09",vid:"3lpp1IColGk"},
    {item:"Cheese Curds",restaurant:"Culver's",cost:"$10.00",rating:"8.5",date:"2024-08-09",vid:"3lpp1IColGk"},
    {item:"Culver's Deluxe Burger",restaurant:"Culver's",cost:"$10.00",rating:"8.5",date:"2024-08-09",vid:"3lpp1IColGk"},
    {item:"Root Beer",restaurant:"Culver's",cost:"$10.00",rating:"8.5",date:"2024-08-09",vid:"3lpp1IColGk"},
    {item:"Sonic Smasher",restaurant:"Sonic",cost:"$10.00",rating:"8",date:"2024-08-03",vid:"75E4M-uJuBI"},
    {item:"Fiery Strawberry Sprite",restaurant:"Burger King",cost:"$3.23",rating:"8",date:"2024-07-29",vid:"SRoouSISnfU"},
    {item:"Fiery Mozzarella Fries",restaurant:"Burger King",cost:"$5.15",rating:"7",date:"2024-07-29",vid:"SRoouSISnfU"},
    {item:"Fiery Bacon Whopper",restaurant:"Burger King",cost:"$8.40",rating:"8.4",date:"2024-07-29",vid:"SRoouSISnfU"},
    {item:"Fiery Chicken Fries",restaurant:"Burger King",cost:"$4.79",rating:"4",date:"2024-07-29",vid:"SRoouSISnfU"},
    {item:"Fiery Bacon Royal Krispy Chicken Sandwich",restaurant:"Burger King",cost:"$8.40",rating:"2",date:"2024-07-29",vid:"SRoouSISnfU"},
    {item:"Cheesy Street Chalupa",restaurant:"Taco Bell",cost:"$5.50",rating:"4",date:"2024-07-23",vid:"iVs64RXKF-E"},
    {item:"Taco Bell $7 Lux Cravings Box",restaurant:"Taco Bell",cost:"$9.00",rating:"8.6",date:"2024-07-17",vid:"Ik5lzhUelNs"},
    {item:"Smoky BLT Quarter Pounder",restaurant:"McDonald's",cost:"$8.00",rating:"5.5",date:"2024-07-12",vid:"kEdpLBv_XYM"},
    {item:"KitKat Banana Split McFlurry",restaurant:"McDonald's",cost:"$5.00",rating:"8.2",date:"2024-07-12",vid:"kEdpLBv_XYM"},
    {item:"Boneless Wings (Classic)",restaurant:"Popeyes",cost:"$8.00",rating:"6.0",date:"2024-07-04",vid:"EKPKtAUtEsY"},
    {item:"Boneless Wings (Signature Hot)",restaurant:"Popeyes",cost:"$8.00",rating:"4.0",date:"2024-07-04",vid:"EKPKtAUtEsY"},
    {item:"Boneless Wings (Honey Barbecue)",restaurant:"Popeyes",cost:"$8.00",rating:"8.1",date:"2024-07-04",vid:"EKPKtAUtEsY"},
    {item:"$5 Meal Deal",restaurant:"McDonald's",cost:"$5.00",rating:"8.8",date:"2024-06-28",vid:"Z2-tjf7aY5E"},
    {item:"Big Cheesy Bacon Burger",restaurant:"Arby's",cost:"$10.00",rating:"8.5",date:"2024-06-24",vid:"ARlNIDVHGVM"},
    {item:"Chicago Tavern Style Pizza",restaurant:"Pizza Hut",cost:"$12.00",rating:"8",date:"2024-06-19",vid:"GLplwJ19qhU"},
    {item:"Maple pepper bacon chicken sandwich",restaurant:"Chick-fil-A",cost:"$11.00",rating:"9",date:"2024-06-14",vid:"weXWh37E1Eg"},
    {item:"Saucy Nuggets - Honey Barbecue",restaurant:"Wendy's",cost:"$4.00",rating:"8.3",date:"2024-06-10",vid:"5aHcYZ3lBb8"},
    {item:"Saucy Nuggets - Spicy Ghost Pepper",restaurant:"Wendy's",cost:"$4.00",rating:"3.0",date:"2024-06-10",vid:"5aHcYZ3lBb8"},
    {item:"Big Chee-it Crunch Wrap Supreme",restaurant:"Taco Bell",cost:"$6.00",rating:"6.7",date:"2024-06-05",vid:"00R_u5zeV84"},
    {item:"Pizza Hut Cheeseburger Melt",restaurant:"Pizza Hut",cost:"$8.00",rating:"2",date:"2024-05-27",vid:"_JXbHSUdMc0"},
    {item:"Grandma McFlurry",restaurant:"McDonald's",cost:"$5.00",rating:"9",date:"2024-05-22",vid:"XnggMCywaQk"},
    {item:"Philly Melt",restaurant:"Burger King",cost:"$6.50",rating:"4",date:"2024-05-21",vid:"lXDGe36f9KM"},
    {item:"Barbecue Bacon Chicken Sandwich",restaurant:"Denny's",cost:"$20.00",rating:"3",date:"2024-05-16",vid:"xHXDdnBJAfA"},
    {item:"Golden Barbecue Chicken Sandwich",restaurant:"Popeyes",cost:"$8.00",rating:"7",date:"2024-05-10",vid:"o7SQVSCx51o"},
    {item:"Chicken Tenders Meal",restaurant:"Popeyes",cost:"$20.00",rating:"",date:"2024-05-10",vid:"o7SQVSCx51o"},
    {item:"Barbecue Chicken Wrap",restaurant:"Arby's",cost:"$3.00",rating:"8",date:"2024-05-06",vid:"rwAxqOKpI-w"},
    {item:"Bacon Cajun Ranch MC Krispy Sandwich",restaurant:"McDonald's",cost:"$6.00",rating:"4",date:"2024-05-01",vid:"i2K7FftzwPQ"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$6.00",rating:"7",date:"2024-04-27",vid:"TWnEA2z3vXs"},
    {item:"Bacon Cajun Ranch Deluxe MC Krispy Chicken Sandwich",restaurant:"McDonald's",cost:"$7.30",rating:"8.5",date:"2024-04-22",vid:"iMQtMZxpfjc"},
    {item:"New York Style Pizza",restaurant:"Domino's",cost:"$18.00",rating:"6",date:"2024-04-17",vid:"OGTMH5Kg40A"},
    {item:"Cantina crispy chicken taco",restaurant:"Taco Bell",cost:"$3.65",rating:"9.1",date:"2024-04-12",vid:"6b7C79Vxk6Q"},
    {item:"Spicy Chicken McNuggets",restaurant:"McDonald's",cost:"$5.30",rating:"8.9",date:"2024-04-06",vid:"xLlOEJtB0W0"},
    {item:"KFC Saucy Nuggets (Korean Barbecue)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02",vid:"aJMbOFUh9fA"},
    {item:"KFC Saucy Nuggets (Honey Sriracha)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02",vid:"aJMbOFUh9fA"},
    {item:"KFC Saucy Nuggets (Sticky Chicky)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02",vid:"aJMbOFUh9fA"},
    {item:"KFC Saucy Nuggets (Nashville Hot)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02",vid:"aJMbOFUh9fA"},
    {item:"KFC Saucy Nuggets (Georgia Gold)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02",vid:"aJMbOFUh9fA"},
    {item:"Crispy Cupy Roni Pizza",restaurant:"Papa John's",cost:"$14.00",rating:"8",date:"2024-03-27",vid:"_xbzOdWfsmw"},
    {item:"Honey Lemon Pepper Wings",restaurant:"Popeyes",cost:"$8.00",rating:"2",date:"2024-03-20",vid:"lf7AhY5W3L4"},
    {item:"Crazy Puffs",restaurant:"Little Caesars",cost:"$4.81",rating:"7.4",date:"2024-03-15",vid:"r1w1OjlwX2E"},
    {item:"Fiery Chicken Nuggets",restaurant:"Burger King",cost:"$2.99",rating:"6",date:"2024-03-10",vid:"7W4UwILdV-w"},
    {item:"Fiery Buffalo Royal Crispy Wrap",restaurant:"Burger King",cost:"$3.00",rating:"3.5",date:"2024-03-10",vid:"7W4UwILdV-w"},
    {item:"wicd Donald's sauce",restaurant:"McDonald's",cost:"$0.50",rating:"7",date:"2024-03-05",vid:"KI87nJZ6tck"},
    {item:"Cheesa",restaurant:"KFC",cost:"$12.00",rating:"8",date:"2024-02-26",vid:"rUrd8XQDRXA"},
    {item:"Chicken Sandwich",restaurant:"Wendy's",cost:"$8.00",rating:"7",date:"2024-02-26",vid:"rUrd8XQDRXA"},
    {item:"Big Mac",restaurant:"McDonald's",cost:"$5.00",rating:"9",date:"2024-02-26",vid:"rUrd8XQDRXA"},
    {item:"Pizza",restaurant:"Domino's",cost:"$15.00",rating:"6",date:"2024-02-26",vid:"rUrd8XQDRXA"},
    {item:"Burrito",restaurant:"Chipotle",cost:"$10.00",rating:"8",date:"2024-02-26",vid:"rUrd8XQDRXA"},
    {item:"Cheesy Chicken Crispata",restaurant:"Taco Bell",cost:"$3.50",rating:"6",date:"2024-02-16",vid:"ul9_JWsEC0A"},
    {item:"Candied Bacon Whopper",restaurant:"Burger King",cost:"$8.40",rating:"8.9",date:"2024-02-09",vid:"bQnwkKizIAQ"},
    {item:"Hot Honey Pizza",restaurant:"Pizza Hut",cost:"$16.00",rating:"7.2",date:"2024-02-04",vid:"0b9ToVXtNdY"},
    {item:"Double Big Mac",restaurant:"McDonald's",cost:"$7.50",rating:"7",date:"2024-01-30",vid:"6MY-HC7Q2Wo"},
    {item:"Breakfast Burrito",restaurant:"Wendy's",cost:"$4.00",rating:"6",date:"2024-01-26",vid:"YevghmGX1mo"},
    {item:"Shake Shack Korean Style Fried Chicken Sandwich",restaurant:"Shake Shack",cost:"$11.00",rating:"6",date:"2024-01-23",vid:"xL9foWwXcC4"},
    {item:"Peanut Butter Bacon Cheeseburger",restaurant:"Sonic Drive-In",cost:"$6.00",rating:"5.8",date:"2024-01-18",vid:"rU6e645ol5g"},
    {item:"Three Cheese Chicken Flatbread Melt",restaurant:"Taco Bell",cost:"$2.30",rating:"7",date:"2024-01-13",vid:"reKgy0ZfGyI"},
    {item:"Slices and Sticks Pizza",restaurant:"Little Caesars",cost:"$8.00",rating:"9",date:"2024-01-09",vid:"T46wjXAV-TE"},
    {item:"KFC Honey Barbecue Wrap",restaurant:"KFC",cost:"$3.00",rating:"6.1",date:"2024-01-04",vid:"1lTl2QesrX4"},
    {item:"KFC Spicy Mac & Cheese Wrap",restaurant:"KFC",cost:"$3.00",rating:"4.9",date:"2024-01-04",vid:"1lTl2QesrX4"},
    {item:"Papa John's Cheesy Calzone Stuffed Crust Pizza",restaurant:"Papa John's",cost:"$15.00",rating:"8.35",date:"2023-12-22",vid:"dHLt2oXmsCU"},
    {item:"Bacon Melt",restaurant:"Burger King",cost:"$6.50",rating:"7.5",date:"2023-12-17",vid:"R2qMJjTazIU"},
    {item:"Cheesy Tots",restaurant:"Burger King",cost:"$1.50",rating:"7.2",date:"2023-12-17",vid:"R2qMJjTazIU"},
    {item:"Empty Food",restaurant:"McDonald's",cost:"$14.00",rating:"8.5",date:"2023-12-11",vid:"Bg4DME6Uwqo"},
    {item:"Double Decker Taco",restaurant:"Taco Bell",cost:"$3.70",rating:"5.8",date:"2023-12-08",vid:"x1fHGjCFI-U"},
    {item:"Signature Hot Wings",restaurant:"Popeyes",cost:"$8.00",rating:"6",date:"2023-12-04",vid:"0rUV1uofNxk"},
    {item:"Honey Barbecue Wings",restaurant:"Popeyes",cost:"$8.00",rating:"8",date:"2023-12-04",vid:"0rUV1uofNxk"},
    {item:"Roasted Garlic Parmesan Wings",restaurant:"Popeyes",cost:"$8.00",rating:"5",date:"2023-12-04",vid:"0rUV1uofNxk"},
    {item:"Pretzel Baconator",restaurant:"Wendy's",cost:"$8.70",rating:"8.3",date:"2023-11-30",vid:"cQ4_4XodH00"},
    {item:"Crazy Crust Pizza",restaurant:"Little Caesars",cost:"$11.50",rating:"4",date:"2023-11-25",vid:"60w-4W64_hk"},
    {item:"MC Rib",restaurant:"McDonald's",cost:"$6.50",rating:"7.0",date:"2023-11-19",vid:"jSXuxJzEz34"},
    {item:"Good Burger 2 Meal",restaurant:"Arby's",cost:"$13.50",rating:"7.2",date:"2023-11-14",vid:"LTmv-cVvkuk"},
    {item:"Breakfast Taco Sausage",restaurant:"Taco Bell",cost:"$2.00",rating:"7.9",date:"2023-11-09",vid:"xAOZ9JIRzDo"},
    {item:"Burger with bacon",restaurant:"Culver's",cost:"-",rating:"2.0",date:"2023-11-04",vid:"J-uZpt8WV9Y"},
    {item:"Fried Mac and Cheese Bites",restaurant:"Arby's",cost:"$4.50 - $5.00",rating:"4",date:"2023-11-02",vid:"fKB3z1gtq8Y"},
    {item:"Roasted Garlic Cheese Sticks",restaurant:"Pizza Hut",cost:"$14.00",rating:"7.7",date:"2023-10-27",vid:"cNvRC29Txdw"},
    {item:"Spicy Truff Chicken Sandwich",restaurant:"Popeyes",cost:"$8.00",rating:"4",date:"2023-10-24",vid:"eHa50oQXMBk"},
    {item:"KFC Jamal Murray Meal",restaurant:"KFC",cost:"$11.00",rating:"6.4",date:"2023-10-21",vid:"oLyUrlz3rp0"},
    {item:"Steak and Bacon Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$7.00",rating:"8.2",date:"2023-10-16",vid:"TDspU0Jm4Iw"},
    {item:"Ghost Pepper Whopper",restaurant:"Burger King",cost:"$8.40",rating:"8.1",date:"2023-10-13",vid:"u438D3-gLvc"},
    {item:"Ghost Pepper Chicken Fries",restaurant:"Burger King",cost:"$5.00",rating:"3.0",date:"2023-10-13",vid:"u438D3-gLvc"},
    {item:"Pepperoni Stuffed Cheesy Bread",restaurant:"Domino's",cost:"$7.00",rating:"7",date:"2023-10-06",vid:"NdMZSLm7hsc"},
    {item:"Honey Mustard BK Royal Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$8.00",rating:"2",date:"2023-09-30",vid:"1luw_ZcgwC4"},
    {item:"Chicken Enchilada Burrito",restaurant:"Taco Bell",cost:"$2.00",rating:"3",date:"2023-09-24",vid:"ttw4BjwquAQ"},
    {item:"Big Game Burger",restaurant:"Arby's",cost:"$9.00",rating:"7.1",date:"2023-09-18",vid:"fhffguxwocY"},
    {item:"Hot and Spicy Wings",restaurant:"KFC",cost:"$6.00",rating:"7.4",date:"2023-09-14",vid:"bohX9lGZ5Dg"},
    {item:"Four Quarter Calzone",restaurant:"Little Caesars",cost:"$9.00",rating:"7",date:"2023-09-09",vid:"a0zxACj7Sig"},
    {item:"Sweet and Spicy Wings",restaurant:"Popeyes",cost:"$6.00",rating:"8.8",date:"2023-09-06",vid:"souqVeAv-y4"},
    {item:"Honey Pepper Pimento Chicken Sandwich",restaurant:"Chick-fil-A",cost:"$9.00",rating:"9.3",date:"2023-09-01",vid:"pp7l9GvPhZw"},
    {item:"Caramel Crumble Milkshake",restaurant:"Chick-fil-A",cost:"$2.00",rating:"6.7",date:"2023-09-01",vid:"pp7l9GvPhZw"},
    {item:"Loaded Nacho Cheeseburger",restaurant:"Wendy's",cost:"$8.00",rating:"6.7",date:"2023-08-26",vid:"M_StJ8hc-VQ"},
    {item:"BK Royal Crispy Chicken Wrap",restaurant:"Burger King",cost:"$3.00",rating:"5.8",date:"2023-08-21",vid:"2vzQYQzs-s4"},
    {item:"Big Mac Meal",restaurant:"McDonald's",cost:"$14.00",rating:"6",date:"2023-08-14",vid:"SVOTD9CL_i8"},
    {item:"Italian Original Chicken Sandwich",restaurant:"Burger King",cost:"$6.00",rating:"2",date:"2023-08-12",vid:"mLFe5YuhOZ0"},
    {item:"Grilled Cheese Dipping Taco",restaurant:"Taco Bell",cost:"$3.50",rating:"6.7",date:"2023-08-07",vid:"yPS2KReKlRM"},
    {item:"Deluxe Box",restaurant:"Taco Bell",cost:"$10.00",rating:"6.7",date:"2023-08-07",vid:"yPS2KReKlRM"},
    {item:"Blazin Knockout Wings",restaurant:"Buffalo Wild Wings",cost:"$11.00",rating:"8.5",date:"2023-08-01",vid:"bA1nYct2Ggg"},
    {item:"Garlic Epic Stuffed Crust Pizza",restaurant:"Papa John's",cost:"$14.00",rating:"8",date:"2023-07-25",vid:"SCJgRC2GlXo"},
    {item:"Pepsi Pineapple",restaurant:"Little Caesars",cost:"$2.00",rating:"9",date:"2023-07-21",vid:"zQ2_LZ8NPlo"},
    {item:"Cheesy Jalapeno Bacon Quarter Pounder",restaurant:"McDonald's",cost:"$8.00",rating:"8.4",date:"2023-07-15",vid:"z9a2VOyKqM8"},
    {item:"Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$3.00",rating:"4",date:"2023-07-11",vid:"nWXHfAc_zYY"},
    {item:"Ultimate Barbecue Chicken Sandwich",restaurant:"KFC",cost:"$7.00",rating:"7.3",date:"2023-07-05",vid:"H0SglyK_SYo"},
    {item:"Volcano Taco",restaurant:"Taco Bell",cost:"$2.49",rating:"8",date:"2023-06-28",vid:"N3Qy9Fycvws"},
    {item:"Volcano Burrito",restaurant:"Taco Bell",cost:"$4.00",rating:"7.2",date:"2023-06-28",vid:"N3Qy9Fycvws"},
    {item:"Fiery Chicken Nuggets",restaurant:"Burger King",cost:"$2.99",rating:"8.5",date:"2023-06-24",vid:"B_GIUptDG3U"},
    {item:"Boneless Wings",restaurant:"Papa John's",cost:"$8.50 (10 pcs)",rating:"5.5",date:"2023-06-19",vid:"SKrR1Hm8xAY"},
    {item:"Grimace Birthday Meal",restaurant:"McDonald's",cost:"$13.50",rating:"8",date:"2023-06-12",vid:"W9ugZFntqSM"},
    {item:"Popeyes Bacon and Cheese Chicken Sandwich",restaurant:"Popeyes",cost:"$7.00",rating:"4",date:"2023-06-09",vid:"7Xl8SICdE5c"},
    {item:"Sweet Chili Lime Wings",restaurant:"Buffalo Wild Wings",cost:"$25.00",rating:"5",date:"2023-06-05",vid:"fYWtck8MjuY"},
    {item:"General Tso's Chicken Wings",restaurant:"Buffalo Wild Wings",cost:"$25.00",rating:"8.4",date:"2023-06-05",vid:"fYWtck8MjuY"},
    {item:"Steak Chile Verde Fries Burrito",restaurant:"Taco Bell",cost:"$5.00",rating:"6",date:"2023-05-31",vid:"CWlvGmjPR3g"},
    {item:"Bacon Ranch Wagyu Steakhouse Burger",restaurant:"Arby's",cost:"$8.00",rating:"6.7",date:"2023-05-26",vid:"sRwzi20qjIo"},
    {item:"Spider-Verse Whopper",restaurant:"Burger King",cost:"$6.50",rating:"8.6",date:"2023-05-21",vid:"vV-LIOSAWzY"},
    {item:"Spider-Verse Sundae",restaurant:"Burger King",cost:"$3.00",rating:"8.6",date:"2023-05-21",vid:"vV-LIOSAWzY"},
    {item:"Bourbon Barbecue Country Style Rib Sandwich",restaurant:"Arby's",cost:"$8.00",rating:"2",date:"2023-05-16",vid:"X9oSdf_7XsM"},
    {item:"Ghost Pepper Ranch Chicken Sandwich",restaurant:"Wendy's",cost:"$8.00",rating:"6",date:"2023-05-12",vid:"1SMLQiwt9n4"},
    {item:"Doritos Cool Ranch Chicken Papadia",restaurant:"Papa John's",cost:"$7.99",rating:"7.5",date:"2023-05-08",vid:"RJoxoXbup5s"},
    {item:"Cheese Steak Melt",restaurant:"Pizza Hut",cost:"$8.53",rating:"3.5",date:"2023-05-03",vid:"l9iS_Tblhlw"},
    {item:"Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$4.79",rating:"9",date:"2023-04-26",vid:"dYKrDNv8Ck4"},
    {item:"Spicy Chicken Nuggets",restaurant:"McDonald's",cost:"$7.00",rating:"8.6",date:"2023-04-22",vid:"9jBZTrw8CDg"},
    {item:"Nacho Fries 2023 Edition",restaurant:"Taco Bell",cost:"$3.50",rating:"8.9",date:"2023-04-17",vid:"pXn3SHcUPL8"},
    {item:"Whopper Melt",restaurant:"Burger King",cost:"$7.00",rating:"3",date:"2023-04-10",vid:"QbJevoHQ2Pc"},
    {item:"Spicy Melt",restaurant:"Burger King",cost:"$6.00",rating:"3",date:"2023-04-10",vid:"QbJevoHQ2Pc"},
    {item:"Regular Burger",restaurant:"Burger King",cost:"$5.00",rating:"7",date:"2023-04-10",vid:"QbJevoHQ2Pc"},
    {item:"Chicken Sandwich",restaurant:"Burger King",cost:"$5.00",rating:"6",date:"2023-04-10",vid:"QbJevoHQ2Pc"},
    {item:"Whopper",restaurant:"Burger King",cost:"$8.00",rating:"8",date:"2023-04-10",vid:"QbJevoHQ2Pc"},
    {item:"KFC Chicken Nuggets",restaurant:"KFC",cost:"$5.00",rating:"8.8",date:"2023-04-05",vid:"PxU8T-U9lZM"},
    {item:"Little Caesars Pretzel Crust Pizza",restaurant:"Little Caesars",cost:"$7.00",rating:"8",date:"2023-03-29",vid:"LcwekaOZGLA"},
    {item:"Honey Barbecue Wings",restaurant:"Buffalo Wild Wings",cost:"$12.00",rating:"4.5",date:"2023-03-27",vid:"Yno7Yf_0eIQ"},
    {item:"Medium Wings",restaurant:"Buffalo Wild Wings",cost:"$12.00",rating:"3.0",date:"2023-03-27",vid:"Yno7Yf_0eIQ"},
    {item:"Bacon Club Chalupa",restaurant:"Taco Bell",cost:"$5.00",rating:"8.15",date:"2023-03-22",vid:"grj1zBQddVQ"},
    {item:"McDonald's Bacon Ranch McCrispy Sandwich",restaurant:"McDonald's",cost:"$7.50",rating:"4",date:"2023-03-17",vid:"rjFArHZbqAk"},
    {item:"Spicy Chicken Fries",restaurant:"Burger King",cost:"$8.00",rating:"8",date:"2023-03-13",vid:"MMOTK6n7K4c"},
    {item:"Double Down Sandwich",restaurant:"KFC",cost:"$11.50",rating:"7.6",date:"2023-03-07",vid:"doGB7PZDee0"},
    {item:"Kentucky Fried Wrap",restaurant:"KFC",cost:"$3.50",rating:"7.5",date:"2023-03-01",vid:"UC52KRdyOXs"},
    {item:"Cheddar Bacon Loaded Tots",restaurant:"Domino's",cost:"$7.00",rating:"3.5",date:"2023-02-23",vid:"Y8_HleQvXOQ"},
    {item:"$18 Meal (Cheeseburger w/ BBQ, Quarter Pounder, Fries, Apple Pie, Coke, Hi-C)",restaurant:"McDonald's",cost:"$18.00",rating:"6.5",date:"2023-02-16",vid:"XueZrV0NtDM"},
    {item:"Big New Yorker Pizza",restaurant:"Pizza Hut",cost:"$13.99",rating:"8.7",date:"2023-02-11",vid:"iqqNyAqyn1U"},
    {item:"Crispy Melt Taco",restaurant:"Taco Bell",cost:"$2.49",rating:"5.8",date:"2023-02-06",vid:"qL-eVHinSlQ"},
    {item:"Papa John's Crispy Parm Pizza",restaurant:"Papa John's",cost:"$12.99",rating:"7",date:"2023-01-31",vid:"7qXR4xmX-qg"},
    {item:"Crispy Chicken Wings",restaurant:"Taco Bell",cost:"$9.00",rating:"8.9",date:"2023-01-24",vid:"cP5MiaVhDwg"},
    {item:"Mexican Original Chicken Sandwich",restaurant:"Burger King",cost:"$6.00",rating:"5.5",date:"2023-01-13",vid:"hX-MdpDqVbo"},
    {item:"Ghost Pepper Wings",restaurant:"Popeyes",cost:"$12.00",rating:"6.5",date:"2023-01-07",vid:"GOka67z8x5E"},
    {item:"Salsa Verde Grilled Chicken Burrito",restaurant:"Taco Bell",cost:"$2.00",rating:"7.5",date:"2023-01-02",vid:"mQuEkPoZq6E"},
    {item:"Oreo cookie Papa bites",restaurant:"Papa John's",cost:"$5.00",rating:"4.8",date:"2022-12-27",vid:"GVPP8DpTgi4"},
    {item:"Seven Layer Nacho Fries Bowl",restaurant:"Taco Bell",cost:"$3.49",rating:"6",date:"2022-12-20",vid:"CxR_Roifk00"},
    {item:"Breakfast Crunchwrap",restaurant:"Taco Bell",cost:"$4.00",rating:"6.5",date:"2022-12-20",vid:"CxR_Roifk00"},
    {item:"Carolina Gold BBQ Sandwich",restaurant:"Wingstop",cost:"$6.40",rating:"7",date:"2022-12-12",vid:"IYWf2-dz_lY"},
    {item:"Italian Mozzarella Chicken Sandwich",restaurant:"Wendy's",cost:"$8.50",rating:"1.5",date:"2022-12-02",vid:"h0v-raHhllQ"},
    {item:"Smoky BLT Quarter Pounder with Cheese",restaurant:"McDonald's",cost:"$8.00",rating:"9",date:"2022-11-26",vid:"yBFHuRRXseY"},
    {item:"Blackened Chicken Sandwich",restaurant:"Popeyes",cost:"$6.00",rating:"3",date:"2022-11-19",vid:"55v9hXp2YXE"},
    {item:"Pizza Hut Melt",restaurant:"Pizza Hut",cost:"$8.40",rating:"9",date:"2022-11-12",vid:"Yb2fwYvLG10"},
    {item:"McRib",restaurant:"McDonald's",cost:"$5.70",rating:"5.6",date:"2022-11-05",vid:"jT3k97RxOkw"},
    {item:"Arby's Diablo Sandwich",restaurant:"Arby's",cost:"$6.79",rating:"8.5",date:"2022-10-28",vid:"2lKnLe3gsD4"},
    {item:"Ghost Pepper Whopper",restaurant:"Burger King",cost:"$9.00",rating:"8.4",date:"2022-10-18",vid:"usNsm_sUtdI"},
    {item:"Cactus Plant Flea Market Meal",restaurant:"McDonald's",cost:"$11.50",rating:"7",date:"2022-10-04",vid:"Sfg7oA9OQF8"},
    {item:"Hot Ones Burger",restaurant:"Shake Shack",cost:"$10.00",rating:"8",date:"2022-09-28",vid:"fwJAYDeCQek"},
    {item:"Detroit Style Pizza",restaurant:"Pizza Hut",cost:"$14.00",rating:"7",date:"2022-09-19",vid:"q_V_aeetQJc"},
    {item:"Royal Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$5.50",rating:"4.9",date:"2022-09-14",vid:"NXolLSRxP8o"},
    {item:"Hot Honey Not Bird Person Combo",restaurant:"Wendy's",cost:"$11.50",rating:"6",date:"2022-09-08",vid:"JC_3B58KLe8"},
    {item:"Italian Meat Trio Bowl",restaurant:"Papa John's",cost:"$8.00",rating:"3",date:"2022-08-29",vid:"ktzhD93oBR4"},
    {item:"Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$7.00",rating:"7.0",date:"2022-08-22",vid:"ARnmyVgAots"},
    {item:"Home Style French Toast Sticks",restaurant:"Wendy's",cost:"$2.79",rating:"2",date:"2022-08-17",vid:"ta_ycq-xn5M"},
    {item:"Crispy Chicken Sandwich Meal Deal",restaurant:"McDonald's",cost:"$8.00",rating:"5",date:"2022-08-11",vid:"ysihyj8inYk"},
    {item:"Old World Fanceroni Pizza",restaurant:"Little Caesars",cost:"$10.00",rating:"7.2",date:"2022-08-05",vid:"gBmhySwOuWE"},
    {item:"Hush Puppy Breaded Fish Strips",restaurant:"Arby's",cost:"$4.30 (3 piece), $6.29 (6 piece)",rating:"6.0",date:"2022-08-01",vid:"B5paeyyGYiE"},
    {item:"Buffalo Wild Wings Saucy Chicken Sandwich",restaurant:"Buffalo Wild Wings",cost:"$10.50",rating:"5.9",date:"2022-07-26",vid:"S-nZrn1UxOE"},
    {item:"Chicken Sandwich Meal",restaurant:"Popeyes",cost:"$6.00",rating:"7.8",date:"2022-07-21",vid:"B2Bb1fUsyEg"},
    {item:"Cantina Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$3.00",rating:"1",date:"2022-07-15",vid:"TV2RHsEru44"},
    {item:"Southwest Bacon Whopper",restaurant:"Burger King",cost:"$7.00",rating:"6",date:"2022-07-11",vid:"G9iO_Fijksc"},
    {item:"Impossible King",restaurant:"Burger King",cost:"$7.00",rating:"8.5",date:"2022-07-05",vid:"M1RVaUww1Uo"},
    {item:"Whopper",restaurant:"Burger King",cost:"$7.00",rating:"N/A",date:"2022-07-05",vid:"M1RVaUww1Uo"},
    {item:"Classic Cheesy Double Beef Burrito",restaurant:"Taco Bell",cost:"$2.00 - $2.50",rating:"7.5",date:"2022-06-30",vid:"WjOaXH-MkB8"},
    {item:"Honey Barbecue Bird Dog",restaurant:"Buffalo Wild Wings",cost:"$10.00",rating:"5",date:"2022-06-25",vid:"6eHpiEncW_M"},
    {item:"Wisconsin Big Cheese Pub Burger",restaurant:"Culver's",cost:"$7.00",rating:"3",date:"2022-06-20",vid:"CVtub7jHkTk"},
    {item:"Toasted Cheddar Chalupa",restaurant:"Taco Bell",cost:"$4.19",rating:"8.5",date:"2022-06-16",vid:"oxVFeoGjvsg"},
    {item:"Edge Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"9",date:"2022-06-10",vid:"03Y89Sw8yng"},
    {item:"Thin & Crispy Crust",restaurant:"Pizza Hut",cost:"$13.00",rating:"9",date:"2022-06-10",vid:"03Y89Sw8yng"},
    {item:"Jack Harlow Meal",restaurant:"KFC",cost:"$10.79",rating:"8",date:"2022-06-06",vid:"96w2XgqrNNE"},
    {item:"Spicy Chicken Sandwich",restaurant:"KFC",cost:"Included",rating:"8",date:"2022-06-06",vid:"96w2XgqrNNE"},
    {item:"Mac and Cheese",restaurant:"KFC",cost:"Included",rating:"6",date:"2022-06-06",vid:"96w2XgqrNNE"},
    {item:"Secret Recipe Fries",restaurant:"KFC",cost:"Included",rating:"8",date:"2022-06-06",vid:"96w2XgqrNNE"},
    {item:"Lemonade",restaurant:"KFC",cost:"Included",rating:"7",date:"2022-06-06",vid:"96w2XgqrNNE"},
    {item:"Deluxe Wagyu Steakhouse Burger",restaurant:"Arby's",cost:"$6.49",rating:"8",date:"2022-05-30",vid:"sKi6ljSzuoA"},
    {item:"Mexican Pizza",restaurant:"Taco Bell",cost:"$5.00",rating:"3",date:"2022-05-23",vid:"GwqsW5ZMJWc"},
    {item:"Bourbon Bacon Cheddar Burger",restaurant:"Shake Shack",cost:"$10.00",rating:"3",date:"2022-05-12",vid:"tpI3yAd3sVo"},
    {item:"Popeye's Buffalo Ranch Chicken Sandwich",restaurant:"Popeyes",cost:"$5.00",rating:"7.6",date:"2022-05-06",vid:"L5arDQP5uPo"},
    {item:"Epic Stuffed Crust Pizza",restaurant:"Papa John's",cost:"$20.00",rating:"9",date:"2022-05-01",vid:"2M67Q6BTO2o"},
    {item:"Detroit Style Deep Dish Pizza",restaurant:"Little Caesars",cost:"$12.00",rating:"8",date:"2022-04-25",vid:"LB5arCstWcs"},
    {item:"Steak White Hot Ranch Fries Burrito",restaurant:"Taco Bell",cost:"$3.49",rating:"9",date:"2022-04-18",vid:"0QnmvHKtmlo"},
    {item:"Popeyes Surf and Turf Combo",restaurant:"Popeyes",cost:"$8.00",rating:"8.2",date:"2022-04-11",vid:"ZiipwOH5RMI"},
    {item:"Spicy Chicken Nuggets",restaurant:"McDonald's",cost:"$7.00",rating:"8",date:"2022-04-05",vid:"cmaC0UmeS3Q"},
    {item:"McDonald's Szechuan Sauce",restaurant:"McDonald's",cost:"$2.00",rating:"8.5",date:"2022-03-31",vid:"QMv7_p01DtA"},
    {item:"Dippable Chicken Nuggets",restaurant:"McDonald's",cost:"$3.00",rating:"8.5",date:"2022-03-31",vid:"QMv7_p01DtA"},
    {item:"French Fries",restaurant:"McDonald's",cost:"$2.00",rating:"8.5",date:"2022-03-31",vid:"QMv7_p01DtA"},
    {item:"Szechuan Sauce",restaurant:"McDonald's",cost:"Complimentary",rating:"8.5",date:"2022-03-31",vid:"QMv7_p01DtA"},
    {item:"Spicy Chicken Sandwich",restaurant:"KFC",cost:"$5.60",rating:"7",date:"2022-03-27",vid:"6wX_tCpT1iA"},
    {item:"Secret Recipe Fries",restaurant:"KFC",cost:"$3.00",rating:"7",date:"2022-03-27",vid:"6wX_tCpT1iA"},
    {item:"Famous Biscuits",restaurant:"KFC",cost:"$2.00",rating:"7",date:"2022-03-27",vid:"6wX_tCpT1iA"},
    {item:"Steak Nacho Fries Burrito",restaurant:"Taco Bell",cost:"$5.00",rating:"7",date:"2022-03-21",vid:"2PjJdZzhqYM"},
    {item:"Cherry Sunrise Freeze",restaurant:"Taco Bell",cost:"$3.30",rating:"8",date:"2022-03-21",vid:"2PjJdZzhqYM"},
    {item:"Spicy Flounder Fish Sandwich",restaurant:"Popeyes",cost:"$5.49",rating:"2",date:"2022-03-09",vid:"YUeH1RWPLxQ"},
    {item:"Big King",restaurant:"Burger King",cost:"$6.00",rating:"5",date:"2022-03-03",vid:"HqMWcMei1bg"},
    {item:"Hash Brown McMuffin",restaurant:"McDonald's",cost:"$9.00",rating:"7",date:"2022-02-20",vid:"_Tzc-YZ5n_s"},
    {item:"Taco Bell Cantina Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$4.00",rating:"6.5",date:"2022-02-15",vid:"nDJ--1QDqx0"},
    {item:"Hot Honey Chicken Sandwich",restaurant:"Wendy's",cost:"$10.00",rating:"8.6",date:"2022-02-10",vid:"eSKaF_KbitU"},
    {item:"Spicy Lovers Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"8.5",date:"2022-02-05",vid:"2YxCw0C5o9o"},
    {item:"Land Air and Sea",restaurant:"McDonald's",cost:"$8.00",rating:"3",date:"2022-01-31",vid:"tQXzWJu3HRI"},
    {item:"Batman Calzone",restaurant:"Little Caesars",cost:"$8.00",rating:"5.8",date:"2022-01-26",vid:"aqAyt85knuU"},
    {item:"Diablo Dare Sandwich",restaurant:"Arby's",cost:"$6.00",rating:"7.4",date:"2022-01-18",vid:"fe_u3vgHMaI"},
    {item:"Beyond Fried Chicken",restaurant:"KFC",cost:"$7.00",rating:"0.5",date:"2022-01-12",vid:"Lw8Sw_s2bnc"},
    {item:"Little Caesars Pizza",restaurant:"Little Caesars",cost:"$5.55",rating:"6.7",date:"2022-01-05",vid:"2e-I0vp9GGE"},
    {item:"Marketing and Deception",restaurant:"Little Caesars",cost:"$5.55",rating:"2.0",date:"2022-01-05",vid:"2e-I0vp9GGE"},
    {item:"New York Style Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"7.7",date:"2021-12-31",vid:"_a53E6KKCgo"},
    {item:"Chipotle Cheddar Chalupa",restaurant:"Taco Bell",cost:"$3.89",rating:"5",date:"2021-12-27",vid:"zpm_bfIzRrU"},
    {item:"Spicy Tender Sandwich",restaurant:"PDQ",cost:"$7.25",rating:"5.7",date:"2021-12-22",vid:"mMR6U80OoeY"},
    {item:"Mariah Menu Cheeseburger",restaurant:"McDonald's",cost:"-",rating:"6",date:"2021-12-18",vid:"aeqNvnf-4Fw"},
    {item:"Small Fries",restaurant:"Wendy's",cost:"$1.69",rating:"7.7",date:"2021-12-10",vid:"Lv7UU2Sg3l0"},
    {item:"Medium Fries",restaurant:"McDonald's",cost:"$3.19",rating:"7.9",date:"2021-12-10",vid:"Lv7UU2Sg3l0"},
    {item:"Large Fries",restaurant:"Burger King",cost:"$2.39",rating:"4",date:"2021-12-10",vid:"Lv7UU2Sg3l0"},
    {item:"Triple Treat Box",restaurant:"Pizza Hut",cost:"$25.50",rating:"7.5",date:"2021-12-06",vid:"yF5c4oIyy3A"},
    {item:"Orange Szechuan Wings",restaurant:"Wingstop",cost:"$15.00",rating:"8",date:"2021-12-02",vid:"WtGev8EsLEU"},
    {item:"Cheetos Boneless Wings",restaurant:"Applebee's",cost:"$11.99",rating:"6.5",date:"2021-11-27",vid:"GUN_ey9MLK8"},
    {item:"Cheetos Flamin' Hot Boneless Wings",restaurant:"Applebee's",cost:"$11.99",rating:"6.5",date:"2021-11-27",vid:"GUN_ey9MLK8"},
    {item:"Italian Original Chicken Sandwich",restaurant:"Burger King",cost:"$7.00",rating:"2",date:"2021-11-23",vid:"4z0_Q5TT2o0"},
    {item:"Double Steak Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$6.50",rating:"7.75",date:"2021-11-14",vid:"uDLd-jZ10l8"},
    {item:"McRib",restaurant:"McDonald's",cost:"$3.00 - $5.00",rating:"5",date:"2021-11-05",vid:"AUORk_EWbDY"},
    {item:"Classic Buffalo Boneless Wings",restaurant:"Arby's",cost:"$5.00",rating:"8.5",date:"2021-11-01",vid:"Lo7GC_HzKmw"},
    {item:"Hot Honey Boneless Wings",restaurant:"Arby's",cost:"$5.00",rating:"8",date:"2021-11-01",vid:"Lo7GC_HzKmw"},
    {item:"Triple Bacon Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"8.2",date:"2021-10-27",vid:"gLY-7zLhtNA"},
    {item:"Hottie Chicken Sandwich",restaurant:"Popeyes",cost:"$3.50",rating:"8",date:"2021-10-19",vid:"mNcq3tja3jc"},
    {item:"Ghost Pepper Chicken Nuggets",restaurant:"Burger King",cost:"$1.49 (8 pcs)",rating:"5.4",date:"2021-10-13",vid:"CNgCxwYbMSU"},
    {item:"Ghost Pepper Nuggets",restaurant:"Burger King",cost:"$1.00",rating:"5.4",date:"2021-10-13",vid:"CNgCxwYbMSU"},
    {item:"Cantina Crispy Melt Taco",restaurant:"Taco Bell",cost:"$2.19",rating:"7.7",date:"2021-10-08",vid:"Ok5kcPdefXo"},
    {item:"Doritos Spicy Sweet Chili Wings",restaurant:"Buffalo Wild Wings",cost:"$10.00",rating:"5",date:"2021-10-02",vid:"Y5kZoTcowP0"},
    {item:"Rodeo Burger",restaurant:"Burger King",cost:"$1.00",rating:"8",date:"2021-09-28",vid:"iCjvTf7acZ0"},
    {item:"Signature Sandwich",restaurant:"Zaxby's",cost:"$7.39",rating:"8.5",date:"2021-09-21",vid:"mo3eeVyQHj0"},
    {item:"Detroit Style Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"9",date:"2021-09-15",vid:"KNalfaZfiw4"},
    {item:"Big Bacon Cheddar Cheeseburger",restaurant:"Wendy's",cost:"$7.00",rating:"7.8",date:"2021-09-09",vid:"4Q9PA8W2HME"},
    {item:"Crispy Chicken Sandwich Taco",restaurant:"Taco Bell",cost:"$2.49",rating:"5.5",date:"2021-09-04",vid:"70NhkwAB7a0"},
    {item:"Crispy Chicken Sandwich Taco (Spicy)",restaurant:"Taco Bell",cost:"$2.49",rating:"5.5",date:"2021-09-04",vid:"70NhkwAB7a0"},
    {item:"Chakaroni Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"8",date:"2021-09-01",vid:"RPvISx2pFbE"},
    {item:"Shaq-a-Roni Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"8",date:"2021-09-01",vid:"RPvISx2pFbE"},
    {item:"Loaded Taco Fries Burrito",restaurant:"Taco Bell",cost:"$3.00",rating:"6",date:"2021-08-26",vid:"N6dC8TN4rrk"},
    {item:"Crazy Calzone Pepperoni",restaurant:"Little Caesars",cost:"$8.50",rating:"7.4",date:"2021-08-19",vid:"2QIq7_WZqds"},
    {item:"Crazy Calzony Pepperoni",restaurant:"Little Caesars",cost:"$8.50",rating:"7.4",date:"2021-08-19",vid:"2QIq7_WZqds"},
    {item:"Big Dinner Box",restaurant:"Pizza Hut",cost:"$23.00",rating:"8.3",date:"2021-08-14",vid:"HM2PCUFo9ac"},
    {item:"Saweetie Meal",restaurant:"McDonald's",cost:"$12.00",rating:"8",date:"2021-08-09",vid:"jRS6l5h0By0"},
    {item:"Garlic Bacon King",restaurant:"Burger King",cost:"$8.00",rating:"7.3",date:"2021-08-04",vid:"jhQ4LMkQH5g"},
    {item:"Chicken Nuggets",restaurant:"Popeyes",cost:"$10.00",rating:"6",date:"2021-07-29",vid:"DAtcB2Ty4eM"},
    {item:"Unknown Chicken Sandwich",restaurant:"Buffalo Wild Wings",cost:"$5.99",rating:"2",date:"2021-07-20",vid:"N_JBmIL6CG4"},
    {item:"Ghost Pepper Ranch Sauce",restaurant:"Wendy's",cost:"-",rating:"6.7",date:"2021-07-16",vid:"G9kqy3dy55g"},
    {item:"Single Bacon King",restaurant:"Burger King",cost:"$5.49",rating:"5.8",date:"2021-07-11",vid:"iyIqHFzKPYM"},
    {item:"Bacon Burger",restaurant:"Five Guys",cost:"$11.00",rating:"9",date:"2021-07-07",vid:"_PItwQefKDo"},
    {item:"Cajun Fries",restaurant:"Five Guys",cost:"$5.00",rating:"8",date:"2021-07-07",vid:"_PItwQefKDo"},
    {item:"Vanilla Shake",restaurant:"Five Guys",cost:"$6.00",rating:"7.5",date:"2021-07-07",vid:"_PItwQefKDo"},
    {item:"Premium Chicken Nuggets",restaurant:"Arby's",cost:"$5.19",rating:"6.5",date:"2021-07-02",vid:"HK4Ux4tlhpw"},
    {item:"Grande Crunchwrap",restaurant:"Taco Bell",cost:"$3.49",rating:"7",date:"2021-06-26",vid:"ZgsnCUs4S2A"},
    {item:"Ch'King Sandwich",restaurant:"Burger King",cost:"$5.82",rating:"5",date:"2021-06-21",vid:"DJav4OKFkd0"},
    {item:"Pepperoni and Cheese Stuffed Crust Pizza",restaurant:"Little Caesars",cost:"$10.00",rating:"7",date:"2021-06-16",vid:"9XbcWj38QAA"},
    {item:"Naked Chicken Chalupa",restaurant:"Taco Bell",cost:"$3.49",rating:"7",date:"2021-06-09",vid:"uc3YBBouQqo"},
    {item:"The Edge Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"8.5",date:"2021-06-03",vid:"ftqkdxlDB3Y"},
    {item:"BTS Meal",restaurant:"McDonald's",cost:"$8.50",rating:"8.5",date:"2021-05-26",vid:"S_6puhoup_I"},
    {item:"Parmesan Crusted Papadia",restaurant:"Papa John's",cost:"$7.00",rating:"6.0",date:"2021-05-20",vid:"vZUoQi2c9bU"},
    {item:"Spicy Deluxe Ch'King Sandwich",restaurant:"Burger King",cost:"$5.82",rating:"2",date:"2021-05-14",vid:"7zZyg0pUhQY"},
    {item:"Bourbon Bacon Cheeseburger",restaurant:"Wendy's",cost:"$6.00",rating:"8.0",date:"2021-05-08",vid:"XfqX5zw3n1E"},
    {item:"Deluxe Crispy Chicken Sandwich",restaurant:"McDonald's",cost:"$5.00",rating:"7.3",date:"2021-04-23",vid:"tUg4Vjj1RXo"},
    {item:"Beefy Potato-Rito",restaurant:"Taco Bell",cost:"$1.00",rating:"8.8",date:"2021-04-18",vid:"Acw9TIWmyCo"},
    {item:"Shack Burger (Double)",restaurant:"Shake Shack",cost:"$9.00",rating:"9",date:"2021-04-10",vid:"y3Uws6mvmEg"},
    {item:"French Fries",restaurant:"Shake Shack",cost:"$3.00",rating:"6.5",date:"2021-04-10",vid:"y3Uws6mvmEg"},
    {item:"Vanilla Shake",restaurant:"Shake Shack",cost:"$6.00",rating:"7",date:"2021-04-10",vid:"y3Uws6mvmEg"},
    {item:"Spicy Greek Gyro",restaurant:"Arby's",cost:"$3.50",rating:"6.8",date:"2021-04-06",vid:"TYkRaj9VwZU"},
    {item:"Crinkle Fries",restaurant:"Arby's",cost:"$1.00",rating:"7.5",date:"2021-04-06",vid:"TYkRaj9VwZU"},
    {item:"Extra Most Bestest Thin Crust Pizza",restaurant:"Little Caesars",cost:"$6.49",rating:"8.2",date:"2021-04-01",vid:"N_IaFGXZvGg"},
    {item:"BBQ Crispy Chicken Taco",restaurant:"Del Taco",cost:"$1.00",rating:"9",date:"2021-03-29",vid:"y2p4eAZCmag"},
    {item:"Bacon Double Stack",restaurant:"Wendy's",cost:"$3.99",rating:"6.8",date:"2021-03-25",vid:"aJp92azRbPo"},
    {item:"Classic Chicken Sandwich",restaurant:"KFC",cost:"$4.99",rating:"6.4",date:"2021-03-19",vid:"QsKaMrBnfsA"},
    {item:"Quesalupa",restaurant:"Taco Bell",cost:"$3.00",rating:"7",date:"2021-03-14",vid:"qVp9QgTo1Dw"},
    {item:"Sourdough King",restaurant:"Burger King",cost:"$8.00",rating:"6.5",date:"2021-03-09",vid:"sZWwpRchX_E"},
    {item:"Jalapeno Popper Chicken Sandwich",restaurant:"Wendy's",cost:"$7.00",rating:"7.7",date:"2021-03-03",vid:"lzab6q3olYA"},
    {item:"Crispy Chicken Sandwich",restaurant:"McDonald's",cost:"$6.00",rating:"7.5",date:"2021-02-24",vid:"fPq77zdFTiE"},
    {item:"Spicy Crispy Chicken Sandwich",restaurant:"McDonald's",cost:"$6.00",rating:"8",date:"2021-02-24",vid:"fPq77zdFTiE"},
    {item:"Shamrock Shake",restaurant:"McDonald's",cost:"$3.99",rating:"6.5",date:"2021-02-15",vid:"JfUlFqX5Xp4"},
    {item:"Cajun Flounder Sandwich",restaurant:"Popeyes",cost:"$8.00",rating:"7.4",date:"2021-02-10",vid:"VxkJ-5u0qWs"},
    {item:"Spicy Chicken McNuggets",restaurant:"McDonald's",cost:"$6.00",rating:"9.3",date:"2021-02-01",vid:"jJMaLBPp9f0"},
    {item:"Detroit Style Pizza",restaurant:"Pizza Hut",cost:"$10.99",rating:"9",date:"2021-01-27",vid:"xSUT1_Jyt1s"},
    {item:"Rip'n Chicken Big Box",restaurant:"Popeyes",cost:"$6.00",rating:"8.4",date:"2021-01-12",vid:"_5c5VMgzsF0"},
    {item:"Bacon Club Chalupa",restaurant:"Taco Bell",cost:"$3.49",rating:"3",date:"2021-01-08",vid:"1IBNvaM2bik"},
    {item:"Epic Stuffed Crust Pizza",restaurant:"Papa John's",cost:"$12.00",rating:"8.7",date:"2021-01-03",vid:"MALyegWebeQ"},
    {item:"Triple Treat Box",restaurant:"Pizza Hut",cost:"$20.99",rating:"8.5",date:"2020-12-14",vid:"YdhnKvY4lvA"},
    {item:"McRib",restaurant:"McDonald's",cost:"$3.70",rating:"7.5",date:"2020-12-04",vid:"bQ4Sa54h-ak"},
    {item:"Pizza Wings",restaurant:"Buffalo Wild Wings",cost:"$10.00",rating:"5.7",date:"2020-11-29",vid:"xYqRYRQM1M8"},
    {item:"Cheeser! Cheeser! Pizza",restaurant:"Little Caesars",cost:"$7.00",rating:"8.0",date:"2020-11-24",vid:"gSlLFBHv2WQ"},
    {item:"Deep Fried Turkey Club Sandwich",restaurant:"Arby's",cost:"$9.00",rating:"5.5",date:"2020-11-21",vid:"Chz7Vb0uITA"},
    {item:"Beyond Italian Sausage Pizza",restaurant:"Pizza Hut",cost:"$14.99",rating:"9",date:"2020-11-16",vid:"sh5Hs8_RO2A"},
    {item:"Toasted Cheddar Chalupa",restaurant:"Taco Bell",cost:"$2.99",rating:"7",date:"2020-11-10",vid:"KL-lSUnyyKo"},
    {item:"Twisty Wicked Shrimp",restaurant:"Popeyes",cost:"$5.00",rating:"8.25",date:"2020-11-06",vid:"o7jIUgxfI68"},
    {item:"Halloween Doughnuts",restaurant:"Krispy Kreme",cost:"$7.00",rating:"6.7",date:"2020-10-31",vid:"LQ1raZwpl0Q"},
    {item:"Double Cheeseburger Papadia",restaurant:"Papa John's",cost:"$8.00",rating:"4",date:"2020-10-27",vid:"uB0oToktoHY"},
    {item:"Classic Chicken Sandwich",restaurant:"Wendy's",cost:"$5.40",rating:"7",date:"2020-10-23",vid:"ET1xM0Y-gEQ"},
    {item:"Spicy Ghost Pepper Donut",restaurant:"Dunkin'",cost:"$1.00",rating:"8.5",date:"2020-10-18",vid:"IPBHvtIvnV0"},
    {item:"Slices-N-Stix",restaurant:"Little Caesars",cost:"$6.00",rating:"8.2",date:"2020-10-11",vid:"j_aSwzbEwa4"},
    {item:"J Balvin Meal",restaurant:"McDonald's",cost:"$6.00",rating:"7.5",date:"2020-10-05",vid:"pPdaqbrCaA0"},
    {item:"Pretzel Bacon Pub Cheeseburger",restaurant:"Wendy's",cost:"$5.39",rating:"9",date:"2020-10-02",vid:"Z_vp-iE_Dx0"},
    {item:"Grande Stacker",restaurant:"Taco Bell",cost:"$2.49",rating:"4.1",date:"2020-09-29",vid:"nVsCPbH5l_Q"},
    {item:"Ghost Pepper Wings",restaurant:"Popeyes",cost:"$13.00",rating:"6.8",date:"2020-09-25",vid:"q5VWD84flLw"},
    {item:"Spicy Chicken Nuggets",restaurant:"McDonald's",cost:"$3.19",rating:"8.8",date:"2020-09-20",vid:"-kdhDwK6lxA"},
    {item:"Spicy Chicken Nuggets",restaurant:"Wendy's",cost:"$1.00",rating:"8.6",date:"2020-09-20",vid:"-kdhDwK6lxA"},
    {item:"Spicy Chicken Nuggets",restaurant:"Burger King",cost:"$1.00",rating:"8.1",date:"2020-09-20",vid:"-kdhDwK6lxA"},
    {item:"Travis Scott Meal",restaurant:"McDonald's",cost:"$6.00",rating:"8.6",date:"2020-09-08",vid:"R4LyvUYb2mo"},
    {item:"Grilled Buffalo Chicken Papadia",restaurant:"Papa John's",cost:"$6.00",rating:"7",date:"2020-09-03",vid:"zUk6CrGqptg"},
    {item:"Beef Burrito",restaurant:"Taco Bell",cost:"$1.00",rating:"8",date:"2020-08-29",vid:"LM9N75BkMBA"},
    {item:"Chicken Taco Pizza",restaurant:"Domino's",cost:"$11.99",rating:"9",date:"2020-08-25",vid:"PivLEB5ehO8"},
    {item:"Honey Sesame Chicken",restaurant:"Panda Express",cost:"$7.80",rating:"8.6",date:"2020-08-20",vid:"xwFgAe9cy-Q"},
    {item:"Spicy Crispy Chicken Sandwich",restaurant:"Wendy's",cost:"$1.29",rating:"8.5",date:"2020-08-15",vid:"CX9UhBednp8"},
    {item:"Hot Honey Bone-In Chicken",restaurant:"Popeyes",cost:"$5.00",rating:"7",date:"2020-08-09",vid:"9YxZNBM_gIQ"},
    {item:"Crispy Chicken Taco",restaurant:"Del Taco",cost:"$1.00",rating:"6",date:"2020-08-03",vid:"rAcnifCprA4"},
    {item:"Beer Battered Fish Sandwich",restaurant:"Arby's",cost:"$5.69",rating:"7",date:"2020-07-30",vid:"OFQGQyrl7oQ"},
    {item:"Steakhouse King",restaurant:"Burger King",cost:"$6.00",rating:"8.1",date:"2020-07-25",vid:"MkOzU8IMJaw"},
    {item:"Hot Buffalo Wings (10 piece)",restaurant:"Domino's",cost:"$7.99",rating:"8.4",date:"2020-07-20",vid:"qJK74p-zbSw"},
    {item:"Secret Recipe Fries",restaurant:"KFC",cost:"$2.49",rating:"6",date:"2020-07-15",vid:"9CSFz91BSLw"},
    {item:"Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$2.99",rating:"8.5",date:"2020-07-06",vid:"6G7bR_6n7JU"},
    {item:"Shaq-a-Roni Pizza",restaurant:"Papa John's",cost:"$12.00",rating:"8",date:"2020-07-02",vid:"Hq8ktRocRV0"},
    {item:"Sweet Potato Waffle Fries",restaurant:"Arby's",cost:"$2.29",rating:"5.5",date:"2020-06-17",vid:"TTVUR0KVJgA"},
    {item:"Pineapple Whip Freeze",restaurant:"Taco Bell",cost:"$2.89",rating:"5.1",date:"2020-06-13",vid:"v3KpOHbEMVM"},
    {item:"Chocolate Chip Cake",restaurant:"KFC",cost:"-",rating:"6.4",date:"2020-06-13",vid:"v3KpOHbEMVM"},
    {item:"Stuffed Crazy Bread",restaurant:"Little Caesars",cost:"$3.49",rating:"8.9",date:"2020-06-07",vid:"b7G7ONUMOcA"},
    {item:"Buffalo Ranch Tenders",restaurant:"Popeyes",cost:"$5.00",rating:"4.7",date:"2020-06-02",vid:"0FpjXpN99YU"},
    {item:"Cheddar Chicken Ranch Sandwich",restaurant:"Arby's",cost:"$3.99",rating:"5.9",date:"2020-05-27",vid:"x0SkYki3ikQ"},
    {item:"Spicy Nuggets (10 piece)",restaurant:"Burger King",cost:"$1.49",rating:"8.1",date:"2020-05-20",vid:"3srQCTjeW8Y"},
    {item:"Crispy Specialty Chicken",restaurant:"Domino's",cost:"$5.00",rating:"8",date:"2020-05-03",vid:"3DbzRgQypWE"},
    {item:"Bacon Jalapeno Stuffed Cheesy Bread",restaurant:"Domino's",cost:"$5.00",rating:"8.7",date:"2020-05-03",vid:"3DbzRgQypWE"},
    {item:"Handmade Pan Pizza (Pepperoni)",restaurant:"Domino's",cost:"$7.00",rating:"8.5",date:"2020-05-03",vid:"3DbzRgQypWE"},
    {item:"Flamin' Hot Doritos Locos Taco",restaurant:"Taco Bell",cost:"$2.00",rating:"9",date:"2020-04-22",vid:"5DpVycon7AI"},
    {item:"Pepperoni Cheeser! Cheeser! Pizza",restaurant:"Little Caesars",cost:"$7.00",rating:"7.4",date:"2020-04-14",vid:"Im52MYoO8Jc"},
    {item:"Double Big Mac",restaurant:"McDonald's",cost:"$8.60",rating:"9",date:"2020-04-03",vid:"VgethQHrhDk"},
    {item:"Big Dipper Pizza",restaurant:"Pizza Hut",cost:"$12.99",rating:"7.7",date:"2020-03-15",vid:"XdKSFE2wl4E"},
    {item:"Breakfast Baconator",restaurant:"Wendy's",cost:"$4.00",rating:"6",date:"2020-03-10",vid:"cWWhHf1g0Ww"},
    {item:"Maple Bacon Chicken Croissant",restaurant:"Wendy's",cost:"$4.00",rating:"4.9",date:"2020-03-10",vid:"cWWhHf1g0Ww"},
    {item:"Jalapeño Popper Rolls",restaurant:"Papa John's",cost:"$5.99",rating:"5.8",date:"2020-03-06",vid:"2msbOCqgmz8"},
    {item:"Chicken and Donuts Sandwich",restaurant:"KFC",cost:"$5.99",rating:"6.8",date:"2020-02-27",vid:"0ZxdBPMW-8w"},
    {item:"Buffalo Chicken Nacho Fries",restaurant:"Taco Bell",cost:"$3.00",rating:"8.26",date:"2020-02-24",vid:"7OV01BFR4O0"},
    {item:"Buttermilk Biscuit Shrimp Combo",restaurant:"Popeyes",cost:"$6.00",rating:"9",date:"2020-02-19",vid:"OBtf0LmFUSk"},
    {item:"Mozzarella Poppers Pizza",restaurant:"Pizza Hut",cost:"$15.00",rating:"4.1",date:"2020-02-14",vid:"_RTJ2E7I7X4"},
    {item:"Philly Cheesesteak Papadia",restaurant:"Papa John's",cost:"$8.00",rating:"6.62",date:"2020-02-09",vid:"Q4HpoGYdk0g"},
    {item:"Cheddar Bacon King",restaurant:"Burger King",cost:"$6.49",rating:"7",date:"2020-01-21",vid:"v5LJnabak-w"},
    {item:"Reaper Ranch Double Stacked Taco",restaurant:"Taco Bell",cost:"$1.00",rating:"8.3",date:"2020-01-10",vid:"4XFh1s42yvA"},
    {item:"Extra Cheesy Alfredo Garlic Parmesan Crust Pizza",restaurant:"Papa John's",cost:"$10.00",rating:"5.8",date:"2020-01-04",vid:"3Abnmizvi_4"},
    {item:"Double Smoked Bacon, Cheddar and Egg Sandwich",restaurant:"Starbucks",cost:"$5.00",rating:"8.8",date:"2019-12-19",vid:"WDqv5cwNTPg"},
    {item:"Rolled Chicken Tacos",restaurant:"Taco Bell",cost:"-",rating:"7.3",date:"2019-12-14",vid:"FFAVCXIew5U"},
    {item:"MeatZZa Pizza",restaurant:"Domino's",cost:"$7.00",rating:"7",date:"2019-12-06",vid:"bcj27PCOB7E"},
    {item:"Bacon BBQ Burger",restaurant:"McDonald's",cost:"$5.89",rating:"8.6",date:"2019-12-01",vid:"oUEKnQy_Ds4"},
    {item:"Snickerdoodle McFlurry (Snack Size)",restaurant:"McDonald's",cost:"$1.89",rating:"6.8",date:"2019-12-01",vid:"oUEKnQy_Ds4"},
    {item:"Nashville Hot Chicken and Waffle Sandwich",restaurant:"KFC",cost:"$6.44",rating:"1",date:"2019-11-26",vid:"8nHcRaTfZEI"},
    {item:"Stuffed Garlic Knots Pizza",restaurant:"Pizza Hut",cost:"$14.99",rating:"5.7",date:"2019-11-22",vid:"7rwBhIbwLuA"},
    {item:"Garlic Parmesan Crust Pizza",restaurant:"Papa John's",cost:"$10.00",rating:"6.0",date:"2019-11-13",vid:"8gx2lPaSctU"},
    {item:"Spicy Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$4.99",rating:"4.7",date:"2019-11-04",vid:"3FxxU7iqmA4"},
    {item:"Spicy Chicken Sandwich",restaurant:"Popeyes",cost:"-",rating:"9",date:"2019-11-04",vid:"3FxxU7iqmA4"},
    {item:"Spicy Chicken Sandwich",restaurant:"Chick-fil-A",cost:"-",rating:"8.2",date:"2019-11-04",vid:"3FxxU7iqmA4"},
    {item:"Spicy Chicken Sandwich",restaurant:"Wendy's",cost:"-",rating:"5.6",date:"2019-11-04",vid:"3FxxU7iqmA4"},
    {item:"Spicy Chicken Sandwich",restaurant:"Culver's",cost:"-",rating:"3",date:"2019-11-04",vid:"3FxxU7iqmA4"},
    {item:"Smoky Sriracha Wings",restaurant:"Pizza Hut",cost:"$7.00",rating:"8.1",date:"2019-11-02",vid:"7P0udMqWKdM"},
    {item:"Double Chalupa",restaurant:"Taco Bell",cost:"$3.49",rating:"3",date:"2019-10-29",vid:"XIfO7FfQUAM"},
    {item:"Fried Oreos",restaurant:"Sonic",cost:"$3.00",rating:"5",date:"2019-10-25",vid:"biU7VdZRd4Y"},
    {item:"Voodoo Chicken Tenders",restaurant:"Popeyes",cost:"$5.00",rating:"8.5",date:"2019-10-22",vid:"V63yQpOXi_Q"},
    {item:"Jack-O'-Lantern Pizza",restaurant:"Papa John's",cost:"$11.00",rating:"4",date:"2019-10-16",vid:"i7zBIyOHcFc"},
    {item:"Buffalo Kentucky Fried Wings",restaurant:"KFC",cost:"$5.00",rating:"7.1",date:"2019-10-12",vid:"SGmoAj7i2o0"},
    {item:"Nashville Hot Kentucky Fried Wings",restaurant:"KFC",cost:"$5.00",rating:"4.9",date:"2019-10-12",vid:"SGmoAj7i2o0"},
    {item:"Honey BBQ Kentucky Fried Wings",restaurant:"KFC",cost:"$5.00",rating:"7.1",date:"2019-10-12",vid:"SGmoAj7i2o0"},
    {item:"McRib",restaurant:"McDonald's",cost:"$3.49",rating:"8.6",date:"2019-10-09",vid:"VR-Z1aQbyMU"},
    {item:"Honey Sesame Chicken Bowl",restaurant:"Panda Express",cost:"$6.67",rating:"8.4",date:"2019-10-06",vid:"RaIw_KGfQD0"},
    {item:"Triple Steakburger with Bacon Meal",restaurant:"Steak 'n Shake",cost:"-",rating:"8.3",date:"2019-10-03",vid:"Lbj7UiWJQSY"},
    {item:"Monster Energy Zero Ultra",restaurant:"7-Eleven",cost:"$3.50",rating:"8",date:"2019-09-29",vid:"0u6mmHW4jdQ"},
    {item:"Pretzel Bacon King",restaurant:"Burger King",cost:"$6.49",rating:"3",date:"2019-09-24",vid:"Ve-bjAfATzk"},
    {item:"Stuffed Cheez-It Pizza (Cheese)",restaurant:"Pizza Hut",cost:"$6.49",rating:"6",date:"2019-09-19",vid:"pkyv1doPaHA"},
    {item:"Stuffed Cheez-It Pizza (Pepperoni)",restaurant:"Pizza Hut",cost:"$6.49",rating:"5.2",date:"2019-09-19",vid:"pkyv1doPaHA"},
    {item:"Spicy BBQ Chicken Sandwich",restaurant:"McDonald's",cost:"$4.26",rating:"7.5",date:"2019-09-17",vid:"7xr5Y0KVyAM"},
    {item:"Toasted Cheddar Chalupa",restaurant:"Taco Bell",cost:"$2.49",rating:"4.9",date:"2019-09-13",vid:"dniAaI79K24"},
    {item:"Mac and Cheese",restaurant:"Chick-fil-A",cost:"$3.50",rating:"7.4",date:"2019-09-06",vid:"MTAxDC5hijw"},
    {item:"Spicy BBQ Glazed Tenders (6pc)",restaurant:"McDonald's",cost:"$7.00",rating:"7.0",date:"2019-09-02",vid:"OfX4cf7BbeA"},
    {item:"Quattro Pizza",restaurant:"Little Caesars",cost:"$7.00",rating:"6.2",date:"2019-08-29",vid:"vFv6g8Zs2tY"},
    {item:"Popeyes Chicken Sandwich",restaurant:"Popeyes",cost:"$4.69",rating:"6.7",date:"2019-08-21",vid:"9-exROcuLp8"},
    {item:"Chick-fil-A Chicken Sandwich",restaurant:"Chick-fil-A",cost:"$3.55",rating:"7.3",date:"2019-08-21",vid:"9-exROcuLp8"},
    {item:"Triple Double Crunchwrap",restaurant:"Taco Bell",cost:"$3.49",rating:"7",date:"2019-08-17",vid:"EJplfz5O3mY"},
    {item:"Spicy Chicken Nuggets",restaurant:"Wendy's",cost:"$3.94",rating:"8.6",date:"2019-08-13",vid:"WAnkubJbijk"},
    {item:"Impossible Whopper",restaurant:"Burger King",cost:"$5.59",rating:"8.2",date:"2019-08-08",vid:"O0bVTxRIWAM"},
    {item:"Deluxe Burger",restaurant:"Culver's",cost:"$5.19",rating:"7",date:"2019-07-29",vid:"V1bc6ORRBFw"},
    {item:"Wisconsin Cheese Curds",restaurant:"Culver's",cost:"$3.89",rating:"7",date:"2019-07-29",vid:"V1bc6ORRBFw"},
    {item:"Cookies and Cream Frozen Custard",restaurant:"Culver's",cost:"$2.49",rating:"6.5",date:"2019-07-29",vid:"V1bc6ORRBFw"},
    {item:"Bacon Jalapeno Cheeseburger",restaurant:"Wendy's",cost:"$5.99",rating:"6.1",date:"2019-07-22",vid:"CFZq41kyLcs"},
    {item:"Sichuan Hot Chicken (Original)",restaurant:"Panda Express",cost:"$4.00",rating:"5.4",date:"2019-07-19",vid:"Mf6xNZkIcEY"},
    {item:"Sichuan Hot Chicken (Extra Spicy)",restaurant:"Panda Express",cost:"$4.00",rating:"5.6",date:"2019-07-19",vid:"Mf6xNZkIcEY"},
    {item:"Steak Reaper Ranch Fries Supreme",restaurant:"Taco Bell",cost:"$3.79",rating:"5",date:"2019-07-15",vid:"OeLPiktYXYY"},
    {item:"Taco",restaurant:"Burger King",cost:"$1.00",rating:"6.85",date:"2019-07-10",vid:"JrZzzQxIUvU"},
    {item:"Cheetos Sandwich Meal",restaurant:"KFC",cost:"$6.79",rating:"8.1",date:"2019-07-02",vid:"c2zakEQrsSA"},
    {item:"Sweet Lightning Mountain Dew",restaurant:"KFC",cost:"-",rating:"4.5",date:"2019-07-02",vid:"c2zakEQrsSA"},
    {item:"Stuffed Crust Extra Most Bestest Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"8.0",date:"2019-06-29",vid:"EaUlfk3AdUg"},
    {item:"Rodeo King",restaurant:"Burger King",cost:"$8.00",rating:"8.1",date:"2019-06-18",vid:"i4cICeXig2w"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$1.30",rating:"7",date:"2019-06-13",vid:"PkSkAz7eDwI"},
    {item:"Grand McExtreme Bacon Burger",restaurant:"McDonald's",cost:"$7.24",rating:"3",date:"2019-06-06",vid:"HehqX_Ju5do"},
    {item:"New Pan Pizza",restaurant:"Pizza Hut",cost:"$7.99",rating:"7.0",date:"2019-06-02",vid:"Il8X6McoDGQ"},
    {item:"Red Bull Slush (Original)",restaurant:"Sonic",cost:"$3.00",rating:"5",date:"2019-05-24",vid:"cKTdmaimJLE"},
    {item:"Cherry Limeade Red Bull Slush",restaurant:"Sonic",cost:"$3.00",rating:"4",date:"2019-05-24",vid:"cKTdmaimJLE"},
    {item:"Grande Nachos Box",restaurant:"Taco Bell",cost:"$5.00",rating:"5.5",date:"2019-05-19",vid:"h6jHS6hh9Ww"},
    {item:"Pan Pizza",restaurant:"Domino's",cost:"$8.00",rating:"6.5",date:"2019-05-14",vid:"6SEEXdSIWek"},
    {item:"Ultimate Pepperoni Pizza",restaurant:"Papa John's",cost:"$12.00",rating:"9.7",date:"2019-04-27",vid:"0yRs6r88yTg"},
    {item:"Angry Whopper",restaurant:"Burger King",cost:"$6.20",rating:"9.4",date:"2019-04-15",vid:"-ABljxG69SE"},
    {item:"BBLT Sandwich",restaurant:"Sonic",cost:"-",rating:"7.1",date:"2019-04-05",vid:"er915Vo2R9U"},
    {item:"Bacon Wrapped Deep Deep Dish Pizza",restaurant:"Little Caesars",cost:"$12.00",rating:"8.55",date:"2019-04-01",vid:"f4aJyQBA63E"},
    {item:"Bacon Cheesy Tots",restaurant:"Burger King",cost:"$2.20",rating:"2",date:"2019-03-25",vid:"It4LK3nH_do"},
    {item:"Pepperoni P'Zone",restaurant:"Pizza Hut",cost:"$5.99",rating:"8.0",date:"2019-03-21",vid:"wLLpHI7tTnw"},
    {item:"Donut Sticks",restaurant:"McDonald's",cost:"$3.39",rating:"7.7",date:"2019-03-12",vid:"qLxTVnl6AvY"},
    {item:"Extra Most Bestest Pizza",restaurant:"Little Caesars",cost:"$6.00",rating:"8.8",date:"2019-03-06",vid:"yXLP1mGRmpA"},
    {item:"Steak Rattlesnake Fries Burrito",restaurant:"Taco Bell",cost:"$2.99",rating:"9.1",date:"2019-03-03",vid:"-o39jCLZ6s8"},
    {item:"Southern Butterfly Shrimp",restaurant:"Popeyes",cost:"$5.00",rating:"8.3",date:"2019-02-22",vid:"5rvW4nsmcTE"},
    {item:"Ultimate Cheesy Crust Pizza",restaurant:"Pizza Hut",cost:"$12.99",rating:"8.0",date:"2019-02-17",vid:"8RamCgvJKKE"},
    {item:"Barbecue Cheeseburger",restaurant:"Wendy's",cost:"$5.50",rating:"9.0",date:"2019-02-12",vid:"g7N53B9C49w"},
    {item:"Pretzel Crust Pizza",restaurant:"Little Caesars",cost:"$6.00",rating:"6.0",date:"2019-01-30",vid:"maBCZWEfFQg"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$1.49",rating:"9.5",date:"2019-01-26",vid:"dNT6HmVGe4I"},
    {item:"Big King XL",restaurant:"Burger King",cost:"$6.50",rating:"8.6",date:"2019-01-19",vid:"mgEDteU_-hs"},
    {item:"Bacon Melt Sonic Signature Slinger",restaurant:"Sonic",cost:"$2.49",rating:"6.5",date:"2019-01-16",vid:"lStuUFmvu1M"},
    {item:"Nashville Hot Extra Crispy Chicken",restaurant:"KFC",cost:"$6.00",rating:"8.0",date:"2019-01-13",vid:"6TdOFoxUbXs"},
    {item:"Naked Chicken Chalupa",restaurant:"Taco Bell",cost:"$5.49",rating:"9.0",date:"2019-01-02",vid:"v39spoofisY"},
    {item:"Cheese Sticks",restaurant:"Papa John's",cost:"-",rating:"9.3",date:"2018-12-28",vid:"jEMrCAv3w7w"},
    {item:"Peppermint Mocha Frappuccino",restaurant:"Starbucks",cost:"$5.00",rating:"8.6",date:"2018-12-24",vid:"gEpclpCHHX0"},
    {item:"Santa's Belly Donut",restaurant:"Krispy Kreme",cost:"-",rating:"7.2",date:"2018-12-24",vid:"gEpclpCHHX0"},
    {item:"Ugly Sweater Penguin Donut",restaurant:"Krispy Kreme",cost:"-",rating:"6.5",date:"2018-12-24",vid:"gEpclpCHHX0"},
    {item:"Holiday Plaid Donut",restaurant:"Krispy Kreme",cost:"-",rating:"7.5",date:"2018-12-24",vid:"gEpclpCHHX0"},
    {item:"Mushroom & Swiss Burger",restaurant:"McDonald's",cost:"$5.39",rating:"8.0",date:"2018-12-16",vid:"P37Mfa_mCv8"},
    {item:"Cini Minis",restaurant:"Burger King",cost:"$1.49",rating:"8.3",date:"2018-12-08",vid:"i7ccFLYwF78"},
    {item:"Bacon Maple Chicken Sandwich",restaurant:"Wendy's",cost:"$5.99",rating:"8.5",date:"2018-12-04",vid:"ttlhYGo5YmY"},
    {item:"Rolled Chicken Tacos",restaurant:"Taco Bell",cost:"-",rating:"8.0",date:"2018-11-28",vid:"qfWPlb464SE"},
    {item:"Mint Chocolate Shake",restaurant:"Arby's",cost:"$2.49",rating:"7.0",date:"2018-11-25",vid:"QXXp9gfiNF8"},
    {item:"Buffalo Chicken Sandwich",restaurant:"Arby's",cost:"$5.00",rating:"8.4",date:"2018-11-25",vid:"QXXp9gfiNF8"},
    {item:"Holiday Turkey & Stuffing Panini",restaurant:"Starbucks",cost:"$6.25",rating:"8.6",date:"2018-11-21",vid:"smETHFpojzs"},
    {item:"Chicken and Waffle Sandwich",restaurant:"KFC",cost:"$5.99",rating:"7",date:"2018-11-18",vid:"Z5F82uMIAso"},
    {item:"Double Cheeseburger Pizza",restaurant:"Papa John's",cost:"$11.77",rating:"7.1",date:"2018-11-14",vid:"NUv_Sk-ToLw"},
    {item:"McRib",restaurant:"McDonald's",cost:"$3.00",rating:"7.92",date:"2018-11-09",vid:"KmXBdmjD5is"},
    {item:"Thin Crust Pepperoni Pizza",restaurant:"Little Caesars",cost:"$6.42",rating:"8.0",date:"2018-11-05",vid:"9-Spbn1PeUY"},
    {item:"Superfood Side (Kale Salad)",restaurant:"Chick-fil-A",cost:"$4.19",rating:"9.0",date:"2018-10-30",vid:"h9YxDiMsTQE"},
    {item:"Nightmare King",restaurant:"Burger King",cost:"$6.39",rating:"6.7",date:"2018-10-26",vid:"2Bm_cxiCsm0"},
    {item:"Caramel Apple Freeze",restaurant:"Taco Bell",cost:"$2.40",rating:"7.4",date:"2018-10-20",vid:"y1VVCAe0oFE"},
    {item:"Frozen Fanta Scary Black Cherry Slush",restaurant:"Burger King",cost:"$1.00",rating:"8.8",date:"2018-10-16",vid:"oYHSjdvUQpw"},
    {item:"S'Awesome Bacon Classic Double",restaurant:"Wendy's",cost:"$6.49",rating:"5.9",date:"2018-10-10",vid:"frEal7sYFVc"},
    {item:"Beefy Crunch Burrito Duo",restaurant:"Taco Bell",cost:"$2.00",rating:"8.0",date:"2018-10-04",vid:"6NWnUXaGdT0"},
    {item:"Bacon Smokehouse Buttermilk Crispy Chicken Sandwich",restaurant:"McDonald's",cost:"$5.00",rating:"7.2",date:"2018-10-01",vid:"9l0CxtcLsxY"},
    {item:"Hot Honey Chicken Tenders",restaurant:"KFC",cost:"$5.49",rating:"7.0",date:"2018-09-27",vid:"bt-jMjwnnvE"},
    {item:"Crispy Chicken Tenders",restaurant:"Burger King",cost:"$4.49",rating:"7.5",date:"2018-09-22",vid:"hGqFC8NuPv4"},
    {item:"Triple Double Crunchwrap",restaurant:"Taco Bell",cost:"$5.97",rating:"6.5",date:"2018-09-15",vid:"Qh0awZm1uC4"},
    {item:"Dave's Single",restaurant:"Wendy's",cost:"$5.00",rating:"8.6",date:"2018-09-12",vid:"S4UTfZdTx3w"},
    {item:"Italian Hero Pizza",restaurant:"Papa John's",cost:"$10.00",rating:"7.0",date:"2018-09-08",vid:"sMXM-8Qxo6g"},
    {item:"Froot Loops Mini Donuts",restaurant:"Hardee's",cost:"$2.34",rating:"8.5",date:"2018-09-01",vid:"aAHHA38NW1U"},
    {item:"Double Cheesy Gordita Crunch",restaurant:"Taco Bell",cost:"$3.49",rating:"5.5",date:"2018-08-27",vid:"UYb7ePQSsPk"},
    {item:"Sweet N Spicy Honey BBQ Glazed Tenders",restaurant:"McDonald's",cost:"$4.49",rating:"8.4",date:"2018-08-23",vid:"yIKwkBxov2I"},
    {item:"Jalapeno King Sandwich",restaurant:"Burger King",cost:"$5.69",rating:"6.7",date:"2018-08-20",vid:"e9IgyMYqTUA"},
    {item:"Honey Sesame Chicken Breast",restaurant:"Panda Express",cost:"$8.00",rating:"9.8",date:"2018-08-16",vid:"nPpuANNNeDc"},
    {item:"$9 Five Meat Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"7.7",date:"2018-08-11",vid:"TOz2gTwh6bk"},
    {item:"Chicken Tenders",restaurant:"Wendy's",cost:"$3.78",rating:"8.2",date:"2018-08-02",vid:"2OFmRxaUoTU"},
    {item:"Watermelon Freeze",restaurant:"Taco Bell",cost:"$2.39",rating:"7.0",date:"2018-07-27",vid:"nNJ2sfGiNAc"},
    {item:"Cheesy Bites Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"9.17",date:"2018-07-21",vid:"5Vu0IUVBA-A"},
    {item:"Crispy Chicken Tenders",restaurant:"Sonic",cost:"$5.79",rating:"5.0",date:"2018-07-18",vid:"pNgIOl6sT3g"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$1.49",rating:"9.5",date:"2018-07-14",vid:"IjeKbFeBv4Q"},
    {item:"Buffalo Ranch Crispy Chicken Sandwich",restaurant:"Wendy's",cost:"$1.00",rating:"6.8",date:"2018-07-11",vid:"eoubWoXzkPE"},
    {item:"Bacon Smokehouse Burger",restaurant:"McDonald's",cost:"$5.39",rating:"7",date:"2018-07-05",vid:"yvckvt6WpKQ"},
    {item:"American Brewhouse King",restaurant:"Burger King",cost:"$6.00",rating:"5",date:"2018-07-02",vid:"Z8gpKkSxtW4"},
    {item:"Pickle Fried Chicken Sandwich",restaurant:"KFC",cost:"$4.80",rating:"6.0",date:"2018-06-26",vid:"U_OF7R-Ao0s"},
    {item:"Classic with Bacon Burger",restaurant:"IHOb",cost:"$9.00",rating:"8.5",date:"2018-06-16",vid:"wkaFMqQzy9A"},
    {item:"Pickle Juice Slush",restaurant:"Sonic",cost:"$1.69",rating:"8.3",date:"2018-06-14",vid:"3y9atqR6YS4"},
    {item:"Pretzel Chicken Fries",restaurant:"Burger King",cost:"-",rating:"7",date:"2018-06-09",vid:"GIRbGOEUp0Q"},
    {item:"Chicken McGriddle",restaurant:"McDonald's",cost:"-",rating:"8.0",date:"2018-06-04",vid:"9hUc2OPTanc"},
    {item:"Rippin' Chicken",restaurant:"Popeyes",cost:"$5.00",rating:"7.5",date:"2018-06-01",vid:"bCzfkUppkaw"},
    {item:"Blueberry Glazed Doughnuts",restaurant:"Krispy Kreme",cost:"$5.00",rating:"6.2",date:"2018-05-23",vid:"G7uOVI_uIwY"},
    {item:"Quarter Pounder with Cheese (Fresh Beef)",restaurant:"McDonald's",cost:"$4.00",rating:"8.7",date:"2018-05-19",vid:"Fu3xLIFl9Ck"},
    {item:"Wild Naked Chicken Chalupa",restaurant:"Taco Bell",cost:"$2.99",rating:"8.0",date:"2018-05-14",vid:"ZXdeulvm9hY"},
    {item:"Stuffed Crust Pan Pizza",restaurant:"Pizza Hut",cost:"$15.00",rating:"8.0",date:"2018-05-01",vid:"oUZMSnFE6Gg"},
    {item:"Spicy Chicken Nuggets",restaurant:"Burger King",cost:"$1.69",rating:"8.2",date:"2018-04-22",vid:"pE93PMfhlE4"},
    {item:"Signature Garlic White Cheddar Burger",restaurant:"McDonald's",cost:"$4.59",rating:"2",date:"2018-04-13",vid:"2QK6Usg2KT0"},
    {item:"Triple Melt Burrito",restaurant:"Taco Bell",cost:"$1.00",rating:"7.3",date:"2018-04-07",vid:"qoWylCXNGIU"},
    {item:"Crystal Ball Frappuccino",restaurant:"Starbucks",cost:"$5.45",rating:"9.0",date:"2018-03-25",vid:"IoykfwY_QPs"},
    {item:"Extra Most Bestest Stuffed Crust Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"8.5",date:"2018-03-15",vid:"DFtTPEwCWSM"},
    {item:"Spicy Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$4.00",rating:"8.8",date:"2018-03-06",vid:"1NUesSsTKwY"},
    {item:"Szechuan Sauce",restaurant:"McDonald's",cost:"-",rating:"9.4",date:"2018-02-26",vid:"00RpZZThSAs"},
    {item:"Cheesy Tots",restaurant:"Burger King",cost:"$2.00",rating:"1",date:"2018-02-22",vid:"_9_a9eHMu78"},
    {item:"Cherry Mocha",restaurant:"Starbucks",cost:"$4.95",rating:"8.5",date:"2018-02-14",vid:"b0AJe8oNu0s"},
    {item:"Build Your Own Veggie Pizza",restaurant:"McDonald's",cost:"$9.00",rating:"9.3",date:"2018-02-06",vid:"LpejO1kHoks"},
    {item:"Smoky Mountain BBQ Chicken Tenders",restaurant:"KFC",cost:"$5.00",rating:"6.8",date:"2018-01-29",vid:"hmjjemb6U_s"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$1.00",rating:"9.5",date:"2018-01-25",vid:"IBHx9uwCy3w"},
    {item:"Double Quarter Pound King",restaurant:"Burger King",cost:"$5.00",rating:"8.9",date:"2018-01-22",vid:"p4EF84UtDDE"},
    {item:"Strawberry Peach Fruit Fizz",restaurant:"Sonic",cost:"-",rating:"7.0",date:"2018-01-17",vid:"lV2ViiLt1Tk"},
    {item:"Mango Lime Fruit Fizz",restaurant:"Sonic",cost:"-",rating:"4.3",date:"2018-01-17",vid:"lV2ViiLt1Tk"},
    {item:"Raspberry Lemon Fruit Fizz",restaurant:"Sonic",cost:"-",rating:"8.5",date:"2018-01-17",vid:"lV2ViiLt1Tk"},
    {item:"Ghost Pepper Wings",restaurant:"Popeyes",cost:"$4.99",rating:"7.2",date:"2018-01-11",vid:"W3YU8AfIiKw"},
    {item:"Bacon McDouble",restaurant:"McDonald's",cost:"$2.00",rating:"6.5",date:"2018-01-06",vid:"YiSsAjNtsFc"},
    {item:"Classic Chicken Sandwich",restaurant:"McDonald's",cost:"$3.00",rating:"8.3",date:"2018-01-06",vid:"YiSsAjNtsFc"},
    {item:"Stacker",restaurant:"Taco Bell",cost:"$1.00",rating:"8.8",date:"2018-01-02",vid:"3AMZqjykLus"},
    {item:"Flamin' Hot Mac n' Cheetos",restaurant:"Burger King",cost:"$2.99",rating:"8.6",date:"2017-12-03",vid:"Jn1dPnyWuwA"},
    {item:"New York Style Pepperoni Pizza",restaurant:"Sbarro",cost:"$4.09",rating:"7.3",date:"2017-11-28",vid:"RnWza5DCYw8"},
    {item:"Ultimate Cheesy Crust Pizza",restaurant:"Pizza Hut",cost:"$12.00",rating:"9.3",date:"2017-11-27",vid:"QvxGI1A3vCE"},
    {item:"Rolled Chicken Tacos (4pc)",restaurant:"Taco Bell",cost:"$4.00",rating:"7.3",date:"2017-11-20",vid:"_Xs7R4uZ32E"},
    {item:"Cheddar and Apple Butter Turkey Slider",restaurant:"White Castle",cost:"$1.00",rating:"9.0",date:"2017-11-15",vid:"IGG9pghRxlc"},
    {item:"Buffalo Chicken Pizza",restaurant:"Domino's",cost:"$13.00",rating:"7.7",date:"2017-11-11",vid:"sQUz3Z7NHGI"},
    {item:"Chicken Tenders (3pc)",restaurant:"Wendy's",cost:"$3.00",rating:"8.6",date:"2017-10-30",vid:"Sa-KwM2MNtk"},
    {item:"Zombie Frappuccino",restaurant:"Starbucks",cost:"$5.00",rating:"8.5",date:"2017-10-26",vid:"vrrJGXqnPgQ"},
    {item:"Spicy Chicken Nuggets (10pc)",restaurant:"Burger King",cost:"$1.49",rating:"9.0",date:"2017-10-17",vid:"deagjmSOFtk"},
    {item:"Crispy Chicken Quesadilla",restaurant:"Taco Bell",cost:"-",rating:"8.7",date:"2017-10-09",vid:"bhb-m3H5LrQ"},
    {item:"Buttermilk Crispy Tenders (4pc)",restaurant:"McDonald's",cost:"$4.00",rating:"9.2",date:"2017-10-07",vid:"UN4Kbib0s8c"},
    {item:"1/4 LB Popcorn Chicken",restaurant:"Popeyes",cost:"$4.00",rating:"9.0",date:"2017-09-26",vid:"WY9xOHquZrg"},
    {item:"Chicken Biscuit",restaurant:"Hardee's",cost:"$1.30",rating:"9.7",date:"2017-09-24",vid:"RsTa6Moh_NM"},
    {item:"Backyard BBQ Chicken Pizza",restaurant:"Pizza Hut",cost:"$12.00",rating:"8.95",date:"2017-09-03",vid:"2ehc9yzSwz0"},
    {item:"Rodeo King Burger",restaurant:"Burger King",cost:"$6.00",rating:"8.5",date:"2017-08-27",vid:"DnfhD0NG_Cs"},
    {item:"Cheesy Tots",restaurant:"Burger King",cost:"$2.13",rating:"7.6",date:"2017-08-20",vid:"xTmnw1EYweo"},
    {item:"Hot Honey Crunch Tenders",restaurant:"Popeyes",cost:"$5.00",rating:"8.8",date:"2017-08-17",vid:"dzYgjGzwv4U"},
    {item:"Hot Wings",restaurant:"Domino's",cost:"$6.00",rating:"9.2",date:"2017-08-14",vid:"g99go80HyIk"},
    {item:"Garlic Parmesan Dunked Chicken Sandwich",restaurant:"Sonic",cost:"$6.49",rating:"5.0",date:"2017-08-09",vid:"jTjabK6dHKM"},
    {item:"Beefy Potato-Rito",restaurant:"Taco Bell",cost:"$1.00",rating:"8.6",date:"2017-07-31",vid:"Tcqy5L4zVhs"},
    {item:"Signature Sriracha Quarter Pound Burger",restaurant:"McDonald's",cost:"$5.13",rating:"4.2",date:"2017-07-27",vid:"DMcGVjM457w"},
    {item:"Buffalo Chicken Tenders",restaurant:"Culver's",cost:"$10.64",rating:"9.38",date:"2017-07-25",vid:"2SOMMNoCESA"},
    {item:"Papa's Chicken Poppers",restaurant:"Papa John's",cost:"$6.00",rating:"8.1",date:"2017-07-20",vid:"sXrMGf99oK0"},
    {item:"Original Pretzel Dog",restaurant:"Sonic",cost:"$2.45",rating:"8.0",date:"2017-07-16",vid:"eorF0Q8yOIM"},
    {item:"Bacon Queso Cheeseburger",restaurant:"Wendy's",cost:"$5.87",rating:"8.4",date:"2017-07-14",vid:"mM6SUphTT88"},
    {item:"Triple Thick Brown Sugar Bacon BLT",restaurant:"Arby's",cost:"$5.80",rating:"5.0",date:"2017-07-10",vid:"nC-fzkNejpQ"},
    {item:"Parmesan Bread Twists",restaurant:"Domino's",cost:"$5.99",rating:"7.0",date:"2017-07-06",vid:"5h-UN3xmyOI"},
    {item:"Cheddar Biscuit Butterfly Shrimp",restaurant:"Popeyes",cost:"$5.00",rating:"4.8",date:"2017-07-05",vid:"5d5NJgO38AE"},
    {item:"BBQ Bacon Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$5.63",rating:"0.5",date:"2017-07-02",vid:"Y6w97W90vHg"},
    {item:"Lucky Charms Shake",restaurant:"Burger King",cost:"$3.31",rating:"6.0",date:"2017-06-28",vid:"Suhk6i5Eg8Q"},
    {item:"Bacon Cheddarburger Pizza",restaurant:"Papa John's",cost:"$10.00",rating:"7.0",date:"2017-06-25",vid:"Rz_6XNzxslY"},
    {item:"Double Chalupa",restaurant:"Taco Bell",cost:"$3.79",rating:"8.5",date:"2017-06-22",vid:"fQygfZVY4Uw"},
    {item:"Mushroom & Swiss King Burger",restaurant:"Burger King",cost:"$6.59",rating:"3.0",date:"2017-06-21",vid:"kKH0EHNK_C4"},
    {item:"Bacon Deluxe Burger",restaurant:"Culver's",cost:"$5.35",rating:"9.4",date:"2017-06-18",vid:"Ut6Cwf3wDIA"},
    {item:"Sweet & Crunchy Chicken Tenders",restaurant:"Popeyes",cost:"$5.35",rating:"5.1",date:"2017-06-15",vid:"yCMGyJgkiCU"},
    {item:"Sweet & Crunchy Chicken Tenders with Smokin' Pepper Jam Sauce",restaurant:"Popeyes",cost:"$5.35",rating:"7.5",date:"2017-06-15",vid:"yCMGyJgkiCU"},
    {item:"Breakfast Quesadilla",restaurant:"Taco Bell",cost:"$2.34",rating:"9.7",date:"2017-06-08",vid:"R4vOGYjzhLA"},
    {item:"Breakfast Salsa",restaurant:"Taco Bell",cost:"-",rating:"9.75",date:"2017-06-08",vid:"R4vOGYjzhLA"},
    {item:"Cheesy Bites Pizza",restaurant:"Pizza Hut",cost:"$12.00",rating:"8.9",date:"2017-06-04",vid:"WA51nsSzDas"},
    {item:"ExtraMostBestest Pizza",restaurant:"Little Caesars",cost:"$6.00",rating:"9.2",date:"2017-06-01",vid:"5AxnJ-2icT8"},
    {item:"Maple Bacon Dijon Signature Crafted Chicken Sandwich",restaurant:"McDonald's",cost:"$5.13",rating:"1.0",date:"2017-05-31",vid:"tWRxV5dOa1U"},
    {item:"Smokehouse BBQ Bacon Sandwich",restaurant:"Chick-fil-A",cost:"$6.00",rating:"9.7",date:"2017-05-27",vid:"HXHHQzZ8Oo8"},
    {item:"Bacon n' Cheese Triple Xtreme Steakburger",restaurant:"Steak 'n Shake",cost:"$6.00",rating:"9.6",date:"2017-05-21",vid:"NAvJeohcCU8"},
    {item:"Mac n' Cheetos",restaurant:"Burger King",cost:"$2.00",rating:"8.0",date:"2017-05-18",vid:"OSt4uMRs8dc"},
    {item:"Naked Chicken Chips",restaurant:"Taco Bell",cost:"$2.45",rating:"8.0",date:"2017-05-12",vid:"ajqRtKN1EGM"},
    {item:"Deluxe Chicken Sandwich",restaurant:"Chick-fil-A",cost:"$2.85",rating:"7.2",date:"2017-05-06",vid:"wf7m7gOFiMY"},
    {item:"Smokehouse Pork Belly Sandwich",restaurant:"Arby's",cost:"$6.00",rating:"6.5",date:"2017-05-03",vid:"8SMolr3H_nY"},
    {item:"Signature Crafted Sweet BBQ Bacon Burger",restaurant:"McDonald's",cost:"$4.79",rating:"6.5",date:"2017-04-30",vid:"B9xhrjca_fw"},
    {item:"Baby Back Rib Burger",restaurant:"Hardee's",cost:"$5.98",rating:"7.6",date:"2017-04-28",vid:"jDZYP4Xas6o"},
    {item:"Froot Loops Shake",restaurant:"Burger King",cost:"$3.09",rating:"9.77",date:"2017-04-25",vid:"AtxO99wtTG4"},
    {item:"Zinger Sandwich",restaurant:"KFC",cost:"$4.00",rating:"8.1",date:"2017-04-22",vid:"WthERhzaCQk"},
    {item:"Steakhouse King",restaurant:"Burger King",cost:"$5.99",rating:"7.0",date:"2017-04-18",vid:"N6hwDVumK1U"},
    {item:"Fresh Mozzarella Chicken Sandwich",restaurant:"Wendy's",cost:"$5.66",rating:"5.6",date:"2017-04-16",vid:"kGo-jv6SkF0"},
    {item:"Hot-N-Ready Classic Pepperoni Pizza",restaurant:"Little Caesars",cost:"$5.00",rating:"8.7",date:"2017-04-12",vid:"iDT5wyZJw5c"},
    {item:"Loaded Taco Burrito",restaurant:"Taco Bell",cost:"$1.49",rating:"7.6",date:"2017-04-08",vid:"yaJdtYSH2dQ"},
    {item:"Honey BBQ Bacon Lil' Chickie",restaurant:"Sonic",cost:"$1.49",rating:"7.3",date:"2017-04-04",vid:"xd2Ty-reSM4"},
    {item:"Double Pepperoni Pizza",restaurant:"Papa John's",cost:"$9.00",rating:"9.3",date:"2017-04-02",vid:"bf_11eqFAkI"},
    {item:"Original Hot Wings",restaurant:"Wingstop",cost:"$8.99",rating:"8.6",date:"2017-03-29",vid:"b4KqAPyAYH8"},
    {item:"Cheesy Bacon Lil' Doggie",restaurant:"Sonic",cost:"$1.49",rating:"7.0",date:"2017-03-26",vid:"KihpTE0-xv4"},
    {item:"Del Taco Soft Taco",restaurant:"Del Taco",cost:"$1.40",rating:"7.1",date:"2017-03-23",vid:"28trz_8ly0I"},
    {item:"Five Flavor Shrimp",restaurant:"Panda Express",cost:"$5.00",rating:"8.6",date:"2017-03-20",vid:"XxHYvXCrnQk"},
    {item:"St. Patrick's Day Green Original Glazed Doughnut",restaurant:"Krispy Kreme",cost:"$1.09",rating:"9.0",date:"2017-03-17",vid:"ZjYW8A5P-Xc"},
    {item:"Premium Cod Fillet Fish Sandwich",restaurant:"Wendy's",cost:"$3.99",rating:"7.0",date:"2017-03-13",vid:"XDgvpuo-4rE"},
    {item:"Meat Mountain Sandwich",restaurant:"Arby's",cost:"$10.70",rating:"8.5",date:"2017-03-10",vid:"iPzb-d9RFFA"},
    {item:"Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$4.39",rating:"5.5",date:"2017-03-07",vid:"WaGl5Csudf4"},
    {item:"Triple Double Crunchwrap",restaurant:"Taco Bell",cost:"$5.00",rating:"9.0",date:"2017-03-04",vid:"Od-sF2OnTyM"},
    {item:"Smokehouse Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"9.2",date:"2017-03-02",vid:"TF01K5vQiKo"},
    {item:"Pancake on a Stick",restaurant:"Sonic",cost:"$2.13",rating:"7.6",date:"2017-02-28",vid:"68_y89yN4ms"},
    {item:"Hand-Breaded Spicy Chicken Tenders",restaurant:"Hardee's",cost:"$4.38",rating:"8.3",date:"2017-02-24",vid:"VrWrxWEe08c"},
    {item:"Chicken Biscuit",restaurant:"Chick-fil-A",cost:"$2.80",rating:"9.0",date:"2017-02-22",vid:"H0i0RaIWkTs"},
    {item:"Boneless Buffalo Wings",restaurant:"Sonic",cost:"$4.69",rating:"8.8",date:"2017-02-19",vid:"VnDDnJbQJsM"},
    {item:"Heart-Shaped Pizza",restaurant:"Pizza Hut",cost:"$10.00",rating:"7.1",date:"2017-02-13",vid:"x3tk7Y9wWoQ"},
    {item:"Shamrock Shake",restaurant:"McDonald's",cost:"$2.00",rating:"1.7",date:"2017-02-12",vid:"Yvb5AA4SNA8"},
    {item:"Jalapeño Chicken Fries",restaurant:"Burger King",cost:"$2.00",rating:"8.5",date:"2017-02-09",vid:"u7c2BKaW__g"},
    {item:"Bacon Ranch Fries",restaurant:"Wendy's",cost:"$2.00",rating:"8.26",date:"2017-02-06",vid:"SmpXY-uHmxI"},
    {item:"Ultimate Meats Pizza",restaurant:"Papa John's",cost:"$11.77",rating:"8.7",date:"2017-02-03",vid:"ING7_VxVN1c"},
    {item:"Georgia Gold Chicken",restaurant:"KFC",cost:"$5.25",rating:"7.5",date:"2017-01-31",vid:"-P_Pvo1E5Pc"},
    {item:"McChicken Biscuit",restaurant:"McDonald's",cost:"$1.49",rating:"6.1",date:"2017-01-27",vid:"5Q3rREvapoQ"},
    {item:"Naked Chicken Chalupa",restaurant:"Taco Bell",cost:"$3.60",rating:"7.49",date:"2017-01-27",vid:"tnbAtrKrItU"},
    {item:"Jalapeño McChicken Sandwich",restaurant:"McDonald's",cost:"$1.79",rating:"6.6",date:"2017-01-22",vid:"aakxseCNfIY"},
    {item:"BBQ Bacon King",restaurant:"Burger King",cost:"$6.00",rating:"2.6",date:"2017-01-19",vid:"XNcvirByBIE"},
    {item:"McCafé Coffee",restaurant:"McDonald's",cost:"$1.00",rating:"8.6",date:"2017-01-15",vid:"I2tyhMBmVcU"},
    {item:"BK Joe Coffee",restaurant:"Burger King",cost:"$1.00",rating:"7.6",date:"2017-01-15",vid:"I2tyhMBmVcU"},
    {item:"Firecracker Chicken Breast",restaurant:"Panda Express",cost:"$6.00",rating:"7.9",date:"2017-01-12",vid:"jrHrdRbUESc"},
    {item:"Loaded Cinnamon Crazy Bites",restaurant:"Little Caesars",cost:"$5.00",rating:"8.8",date:"2017-01-09",vid:"ovtiPzEnfoM"},
    {item:"Nacho Crunch Double Stacked Taco",restaurant:"Taco Bell",cost:"$1.00",rating:"7.0",date:"2017-01-06",vid:"DVMtah5taYA"},
    {item:"Chicken McGriddle",restaurant:"McDonald's",cost:"$1.49",rating:"6.7",date:"2017-01-04",vid:"xNyxnZLNwvQ"},
    {item:"Spicy Sweet Double Stacked Taco",restaurant:"Taco Bell",cost:"$1.00",rating:"7.5",date:"2017-01-03",vid:"1eN2iu-8Tag"},
  ];

  function parseRating(r) {
    const n = parseFloat(r);
    return isNaN(n) ? -1 : n;
  }

  function parseCost(c) {
    const m = c.match(/\d+\.?\d*/);
    return m ? parseFloat(m[0]) : -1;
  }

  const sorted = $derived.by(() => {
    const arr = [...ratings];
    arr.sort((a, b) => {
      let va, vb;
      if (sortCol === 'rating') {
        va = parseRating(a.rating);
        vb = parseRating(b.rating);
      } else if (sortCol === 'cost') {
        va = parseCost(a.cost);
        vb = parseCost(b.cost);
      } else if (sortCol === 'date') {
        va = a.date;
        vb = b.date;
      } else {
        va = a[sortCol]?.toLowerCase() ?? '';
        vb = b[sortCol]?.toLowerCase() ?? '';
      }
      if (va < vb) return sortAsc ? -1 : 1;
      if (va > vb) return sortAsc ? 1 : -1;
      return 0;
    });
    return arr;
  });

  function toggleSort(col) {
    if (sortCol === col) {
      sortAsc = !sortAsc;
    } else {
      sortCol = col;
      sortAsc = col === 'item' || col === 'restaurant';
    }
  }

  function arrow(col) {
    if (sortCol !== col) return '';
    return sortAsc ? ' ▲' : ' ▼';
  }

  const RENAME = {
    "Sonic Drive-In": "Sonic",
    "Wing Stop": "Wingstop",
    "Dunkin'": "Dunkin' Donuts"
  };
  const plotData = ratings
    .map(r => {
      const rating = parseFloat(r.rating);
      const date = new Date(r.date);
      const restaurant = RENAME[r.restaurant] ?? r.restaurant;
      return {
        ...r, restaurant, rating, date,
        year: date.getFullYear(),
        price: parseCost(r.cost)
      };
    })
    .filter(r => !isNaN(r.rating) && r.rating >= 0 && r.rating <= 10);

  const priceData = plotData.filter(d => d.price > 0 && d.price <= 30);

  const overallMean = plotData.reduce((s, d) => s + d.rating, 0) / plotData.length;

  const sortedByDate = [...plotData].sort((a, b) => a.date - b.date);
  const rollWindow = 15;
  const rolling = sortedByDate.map((d, i) => {
    const slice = sortedByDate.slice(Math.max(0, i - rollWindow + 1), i + 1);
    return { date: d.date, avg: slice.reduce((s, x) => s + x.rating, 0) / slice.length };
  });

  const counts = new Map();
  for (const d of plotData) counts.set(d.restaurant, (counts.get(d.restaurant) ?? 0) + 1);
  const topChains = [...counts.entries()]
    .filter(([, n]) => n >= 15)
    .sort((a, b) => b[1] - a[1])
    .map(([r]) => r);
  const facetData = plotData.filter(d => topChains.includes(d.restaurant));

  const yearStats = [...new Set(plotData.map(d => d.year))].sort().map(y => {
    const vs = plotData.filter(d => d.year === y).map(d => d.rating).sort((a, b) => a - b);
    const n = vs.length;
    const mean = vs.reduce((s, x) => s + x, 0) / n;
    const median = n % 2 ? vs[(n - 1) / 2] : (vs[n / 2 - 1] + vs[n / 2]) / 2;
    const sd = Math.sqrt(vs.reduce((s, x) => s + (x - mean) ** 2, 0) / (n - 1));
    const sdSE = sd / Math.sqrt(2 * (n - 1)); // approx standard error of a sample SD
    return { year: y, n, mean, median, sd, sdLo: Math.max(0, sd - 1.96 * sdSE), sdHi: sd + 1.96 * sdSE };
  });

  // Per-chain × year mean rating (for the yearly-trajectory small multiples)
  const chainYear = [];
  for (const rest of topChains) {
    const rs = plotData.filter(d => d.restaurant === rest);
    for (const y of [...new Set(rs.map(d => d.year))].sort()) {
      const vs = rs.filter(d => d.year === y);
      chainYear.push({
        restaurant: rest, year: y, n: vs.length,
        mean: vs.reduce((s, x) => s + x.rating, 0) / vs.length
      });
    }
  }
  // Early (2017–2021) vs recent (2022–2026) mean per chain — "who soured the most"
  const EARLY = 'Early (2017–2021)';
  const RECENT = 'Recent (2022–2026)';
  const periodStat = a => {
    const v = a.map(d => d.rating);
    const n = v.length;
    if (!n) return { n: 0, mean: null, sd: 0, lo: null, hi: null };
    const mean = v.reduce((s, x) => s + x, 0) / n;
    const sd = n > 1 ? Math.sqrt(v.reduce((s, x) => s + (x - mean) ** 2, 0) / (n - 1)) : 0;
    const ci = n > 1 ? 1.96 * sd / Math.sqrt(n) : 0;
    return { n, mean, sd, lo: mean - ci, hi: mean + ci };
  };
  const chainEarlyLate = topChains.map(rest => {
    const rs = plotData.filter(d => d.restaurant === rest);
    const e = periodStat(rs.filter(d => d.year <= 2021));
    const l = periodStat(rs.filter(d => d.year >= 2022));
    return {
      restaurant: rest,
      earlyMean: e.mean, recentMean: l.mean,
      earlyN: e.n, recentN: l.n,
      earlyLo: e.lo, earlyHi: e.hi, recentLo: l.lo, recentHi: l.hi
    };
  }).filter(d => d.earlyMean != null && d.recentMean != null);
  const souredOrder = [...chainEarlyLate]
    .sort((a, b) => (b.earlyMean - b.recentMean) - (a.earlyMean - a.recentMean))
    .map(d => d.restaurant);
  const declineOrder = souredOrder;
  const chainEarlyLateLong = chainEarlyLate.flatMap(d => [
    { restaurant: d.restaurant, period: EARLY, mean: d.earlyMean, n: d.earlyN, lo: d.earlyLo, hi: d.earlyHi },
    { restaurant: d.restaurant, period: RECENT, mean: d.recentMean, n: d.recentN, lo: d.recentLo, hi: d.recentHi }
  ]);
  const periodColor = { domain: [EARLY, RECENT], range: ['#2c4a3b', '#e4552e'] };

  // Perceptually-ordered single-hue ramp (sage → deep pine), colorblind-safe
  // and monotonic in lightness — replaces the rainbow 'turbo' scheme.
  const yearColor = { type: 'linear', range: ['#a7c1b0', '#22402f'], label: 'Review year', tickFormat: 'd' };

  onMount(() => {
    let ro, resizeT, disposed = false;
    (async () => {
    const Plot = await import('@observablehq/plot');
    if (disposed) return;

    const ptTitle = d =>
      `${d.item}\n${d.restaurant} · ${d.date.toISOString().slice(0, 10)}\nRating: ${d.rating}`;

    let lastW = 0;
    const renderAll = () => {
      const avail = timelineEl?.clientWidth || 820;
      const W = Math.max(280, Math.min(820, avail));
      if (W === lastW) return;
      lastW = W;
      // Label-heavy charts (facets / dumbbell) keep a legibility floor and
      // scroll inside their container on very narrow screens.
      const Wf = Math.max(W, 560);

    // Viz 1 — Ratings over time, dots colored by year
    timelineEl.replaceChildren(Plot.plot({
      width: W, height: 360,
      marginLeft: 44, marginBottom: 36, marginTop: 24, marginRight: 16,
      color: { ...yearColor, legend: true },
      x: { label: null, type: 'time' },
      y: { domain: [0, 10], label: 'Rating ↑', grid: true },
      marks: [
        Plot.dot(plotData, { x: 'date', y: 'rating', fill: 'year', r: 2.6, fillOpacity: 0.55, stroke: 'none' }),
        Plot.line(rolling, { x: 'date', y: 'avg', stroke: '#e4552e', strokeWidth: 2.2 }),
        Plot.ruleY([overallMean], { stroke: '#8fa99b', strokeDasharray: '4 4' }),
        Plot.tip(plotData, Plot.pointer({ x: 'date', y: 'rating', title: ptTitle }))
      ]
    }));

    // Viz 2 — Clean per-year distribution (canonical Plot.boxY only)
    yearEl.replaceChildren(Plot.plot({
      width: W, height: 360,
      marginLeft: 44, marginBottom: 36, marginTop: 16, marginRight: 16,
      color: yearColor,
      x: { label: 'Year', tickFormat: 'd', interval: 1, inset: 24 },
      y: { domain: [0, 10], label: 'Rating ↑', grid: true },
      marks: [
        Plot.boxY(plotData, { x: 'year', y: 'rating', fill: 'year' }),
        Plot.tip(yearStats, Plot.pointerX({
          x: 'year', y: 'mean',
          title: d => `${d.year}  (n=${d.n})\nmean ${d.mean.toFixed(2)} · median ${d.median.toFixed(1)}\nSD ${d.sd.toFixed(2)}`
        }))
      ]
    }));

    // Viz 3 — Spread by year (standard deviation), the polarization thesis in one line
    spreadEl.replaceChildren(Plot.plot({
      width: W, height: 320,
      marginLeft: 44, marginBottom: 36, marginTop: 16, marginRight: 16,
      color: { ...yearColor, legend: true },
      x: { label: 'Year', tickFormat: 'd', interval: 1 },
      y: { domain: [0, 3.5], label: 'Std. dev. of rating ↑', grid: true },
      marks: [
        Plot.barY(yearStats, { x: 'year', y: 'sd', fill: 'year', fillOpacity: 0.85 }),
        Plot.ruleX(yearStats, { x: 'year', y1: 'sdLo', y2: 'sdHi', stroke: '#1c1e1b', strokeWidth: 1.2 }),
        Plot.ruleY([0]),
        Plot.tip(yearStats, Plot.pointerX({
          x: 'year', y: 'sd',
          title: d => `${d.year}  (n=${d.n})\nSD ${d.sd.toFixed(2)}  (95% CI ${d.sdLo.toFixed(2)}–${d.sdHi.toFixed(2)})\nmean ${d.mean.toFixed(2)}`
        }))
      ]
    }));

    // Viz 6 — Price over time (fast-food inflation), dots colored by year
    priceEl.replaceChildren(Plot.plot({
      width: W, height: 360,
      marginLeft: 44, marginBottom: 40, marginTop: 24, marginRight: 16,
      color: { ...yearColor, legend: true },
      x: { label: null, type: 'time' },
      y: { label: 'Price (USD) ↑', grid: true, nice: true },
      marks: [
        Plot.dot(priceData, { x: 'date', y: 'price', fill: 'year', r: 2.6, fillOpacity: 0.55, stroke: 'none' }),
        Plot.linearRegressionY(priceData, { x: 'date', y: 'price', stroke: '#1c1e1b', strokeWidth: 1.5, ci: 0.95 }),
        Plot.tip(priceData, Plot.pointer({
          x: 'date', y: 'price',
          title: d => `${d.item}\n${d.restaurant} · ${d.date.toISOString().slice(0, 10)}\n$${d.price.toFixed(2)}`
        }))
      ]
    }));

    // Viz 4 — Small-multiples scatter by chain, dots colored by year
    chainsEl.replaceChildren(Plot.plot({
      width: Wf, height: topChains.length * 92 + 70,
      marginLeft: 40, marginBottom: 36, marginTop: 16, marginRight: 124,
      color: yearColor,
      fy: { label: null, domain: topChains },
      x: { type: 'time', label: null },
      y: { domain: [0, 10], label: null, ticks: 5, grid: true },
      marks: [
        Plot.frame({ stroke: '#dcdfd5' }),
        Plot.dot(facetData, { fy: 'restaurant', x: 'date', y: 'rating', fill: 'year', r: 2.2, fillOpacity: 0.6, stroke: 'none' }),
        Plot.linearRegressionY(facetData, { fy: 'restaurant', x: 'date', y: 'rating', stroke: '#1c1e1b', strokeWidth: 1.5, ci: 0.95, fillOpacity: 0.12 }),
        Plot.tip(facetData, Plot.pointer({ fy: 'restaurant', x: 'date', y: 'rating', title: ptTitle }))
      ]
    }));

    // Viz 5 — Per-chain yearly mean trajectory (small multiples), biggest decline first
    eraEl.replaceChildren(Plot.plot({
      width: Wf, height: declineOrder.length * 92 + 70,
      marginLeft: 40, marginBottom: 36, marginTop: 16, marginRight: 124,
      color: { ...yearColor, legend: true },
      fy: { label: null, domain: declineOrder },
      x: { label: null, tickFormat: 'd', interval: 1 },
      y: { domain: [0, 10], label: null, ticks: 5, grid: true },
      marks: [
        Plot.frame({ stroke: '#dcdfd5' }),
        Plot.line(chainYear, { fy: 'restaurant', x: 'year', y: 'mean', stroke: '#8fa99b', strokeWidth: 1.5 }),
        Plot.dot(chainYear, { fy: 'restaurant', x: 'year', y: 'mean', fill: 'year', r: 3.6, stroke: 'white', strokeWidth: 0.6 }),
        Plot.tip(chainYear, Plot.pointer({
          fy: 'restaurant', x: 'year', y: 'mean',
          title: d => `${d.restaurant}\n${d.year}: mean ${d.mean.toFixed(2)} (n=${d.n})`
        }))
      ]
    }));

    // Viz 7 — Who soured the most: early vs recent dumbbell
    souredEl.replaceChildren(Plot.plot({
      width: Wf, height: souredOrder.length * 34 + 80,
      marginLeft: 110, marginRight: 24, marginTop: 24, marginBottom: 40,
      color: { ...periodColor, legend: true },
      r: { range: [3, 9] },
      x: { domain: [0, 10], label: 'Mean rating →', grid: true },
      y: { domain: souredOrder, label: null },
      marks: [
        Plot.ruleX([overallMean], { stroke: '#8fa99b', strokeDasharray: '4 4' }),
        Plot.link(chainEarlyLate, { y: 'restaurant', x1: 'earlyMean', x2: 'recentMean', stroke: '#dcdfd5', strokeWidth: 2 }),
        Plot.ruleY(chainEarlyLateLong, { y: 'restaurant', x1: 'lo', x2: 'hi', stroke: 'period', strokeWidth: 1.5, strokeOpacity: 0.45 }),
        Plot.dot(chainEarlyLateLong, { y: 'restaurant', x: 'mean', fill: 'period', r: 'n', stroke: 'white', strokeWidth: 1 }),
        Plot.tip(chainEarlyLateLong, Plot.pointer({
          y: 'restaurant', x: 'mean',
          title: d => `${d.restaurant}\n${d.period}\nmean ${d.mean.toFixed(2)} (n=${d.n})\n95% CI ${d.lo.toFixed(2)}–${d.hi.toFixed(2)}`
        }))
      ]
    }));
    };

    renderAll();
    ro = new ResizeObserver(() => {
      clearTimeout(resizeT);
      resizeT = setTimeout(renderAll, 150);
    });
    ro.observe(timelineEl);
    })();

    return () => { disposed = true; ro?.disconnect(); clearTimeout(resizeT); };
  });
</script>

<style>
  .sortable-table { width: 100%; border-collapse: collapse; font-size: 0.95rem; margin: 1.5rem 0; }
  .sortable-table th, .sortable-table td { padding: 0.5rem 0.75rem; border-bottom: 1px solid var(--rule); text-align: left; }
  .sortable-table th {
    cursor: pointer; user-select: none; white-space: nowrap;
    font-family: var(--font-mono); font-size: 0.68rem; font-weight: 400;
    text-transform: uppercase; letter-spacing: 0.08em; color: var(--ink-faint);
    border-bottom: 1px solid var(--ink);
  }
  .sortable-table th:hover { color: var(--signal); }
  /* Numeric columns (cost, rating, date) in tabular mono */
  .sortable-table td:nth-child(n+3) { font-family: var(--font-mono); font-size: 0.82rem; color: var(--ink-soft); }
  .sortable-table tbody tr:hover { background: var(--sage-tint); }
  .rating-count {
    margin-bottom: 1.5rem; font-family: var(--font-mono); font-size: 0.72rem;
    letter-spacing: 0.06em; text-transform: uppercase; color: var(--ink-faint); font-style: normal;
  }
  .plot-container { margin: 1em 0 0.25em; overflow-x: auto; max-width: 100%; }
  .plot-container :global(svg) { display: block; height: auto; }
  .plot-container :global(figure) { margin: 0; }
  .plot-caption { font-size: 0.9rem; color: var(--ink-faint); margin: 0 0 2rem; font-style: italic; }
</style>

# Capturing and Characterizing the Decline of American Fast-Food

After ReviewBrah asked in a May 2026 video whether fast food is [_"nearing the end"_](https://www.youtube.com/watch?v=-Pb2ythhd9E), I recorded {plotData.length} of his reviews dating back to 2017. The mean rating has fallen only modestly over that span, while the year-over-year standard deviation has roughly doubled, which is the primary driver of the decline.

<p class="rating-count">{plotData.length} ratings analyzed · Published Oct 2025 · Updated Oct 2026</p>

## Ratings Over Time

<div class="plot-container" bind:this={timelineEl}></div>

<p class="plot-caption">Each review is a dot, shaded by year from pale sage (older) to deep pine (recent). The vermilion line is the 15-review rolling average and the dashed line marks the all-time mean ({overallMean.toFixed(2)}). Hover any point for the item, chain, date, and score.</p>

## Distribution by Year

<div class="plot-container" bind:this={yearEl}></div>

<p class="plot-caption">A box plot per year. The box spans the interquartile range, the center line is the median, the whiskers extend to 1.5 times the IQR, and dots are outliers. Hover a year for n, mean, median, and SD.</p>

## Spread by Year

<div class="plot-container" bind:this={spreadEl}></div>

<p class="plot-caption">Standard deviation of each year's ratings. Black whiskers are 95% confidence intervals on the standard-deviation estimate. Hover a year for the exact SD, confidence interval, mean, and n.</p>

## By Chain

<div class="plot-container" bind:this={chainsEl}></div>

<p class="plot-caption">One panel per chain with at least 15 reviews ({topChains.length} chains, ordered by review count). Dots are individual reviews colored by year. Each black line is a least-squares trend with a shaded 95% confidence band. Hover any point for details.</p>

## Yearly Average by Chain

<div class="plot-container" bind:this={eraEl}></div>

<p class="plot-caption">Each chain's mean rating per year, connected into a trajectory, with dots colored by year. Same {topChains.length} chains, ordered by the early-to-recent change in mean with the largest decrease at top. Hover a dot for the yearly mean and sample size.</p>

## Who Soured the Most

<div class="plot-container" bind:this={souredEl}></div>

<p class="plot-caption">Each chain's mean rating for early reviews (2017 to 2021, pine green) and recent reviews (2022 to 2026, vermilion). Dot area is proportional to the number of reviews, and the faint colored whiskers are 95% confidence intervals on each mean. Rows are ordered by the size of the early-to-recent decrease. The dashed line marks the all-time mean ({overallMean.toFixed(2)}). Hover a dot for mean, n, and CI.</p>

## Price Over Time

<div class="plot-container" bind:this={priceEl}></div>

<p class="plot-caption">Each priced review with a parseable dollar amount at or below $30 ({priceData.length} reviews), plotted by date and colored by year. The black line is a least-squares fit with a 95% confidence band. Hover any point for the item, chain, date, and price.</p>

<table class="sortable-table">
  <thead>
    <tr>
      <th onclick={() => toggleSort('item')}>Reviewed Item{arrow('item')}</th>
      <th onclick={() => toggleSort('restaurant')}>Restaurant{arrow('restaurant')}</th>
      <th onclick={() => toggleSort('cost')}>Cost{arrow('cost')}</th>
      <th onclick={() => toggleSort('rating')}>Rating{arrow('rating')}</th>
      <th onclick={() => toggleSort('date')}>Review Date{arrow('date')}</th>
    </tr>
  </thead>
  <tbody>
    {#each sorted as r}
      <tr>
        <td><a href="https://www.youtube.com/watch?v={r.vid}">{r.item}</a></td>
        <td>{r.restaurant}</td>
        <td>{r.cost}</td>
        <td>{r.rating}</td>
        <td>{r.date}</td>
      </tr>
    {/each}
  </tbody>
</table>

## How I did it

The original approach used YouTube's auto-generated captions via `youtube-transcript`,
but YouTube started aggressively rate-limiting the transcript API endpoint. The updated
approach bypasses this entirely by downloading audio and transcribing locally with
OpenAI's Whisper model.

### Step 1: Listing All Videos in a Channel

Use yt-dlp to get video URLs and upload dates from the channel:

```bash
yt-dlp -s --flat-playlist \
  --print-to-file "%(upload_date)s %(id)s %(title)s" videos.txt \
  "https://www.youtube.com/@TheReportOfTheWeek/videos"
```

This gives you a file with one line per video containing the date, video ID, and title.

### Step 2: Downloading Audio

YouTube's transcript/subtitle endpoints are heavily rate-limited, but the audio
stream endpoint is not. Download audio for each video:

```bash
mkdir -p audio
while IFS=' ' read -r date id rest; do
  yt-dlp --extract-audio --audio-format mp3 \
    -o "audio/${id}.mp3" \
    "https://www.youtube.com/watch?v=${id}"
done < videos.txt
```

For ~57 videos this produces around 850MB of MP3 files.

### Step 3: Transcribing with Whisper

Install [mlx-whisper](https://github.com/ml-explore/mlx-examples/tree/main/whisper)
for fast transcription on Apple Silicon (about 20 seconds per video vs 30+ minutes
with CPU-only Whisper):

```bash
pip install mlx-whisper
```

Then transcribe each audio file:

```python
import mlx_whisper, os, glob

for mp3 in sorted(glob.glob("audio/*.mp3")):
    vid_id = os.path.basename(mp3).replace(".mp3", "")
    result = mlx_whisper.transcribe(
        mp3,
        path_or_hf_repo="mlx-community/whisper-large-v3-turbo",
        condition_on_previous_text=False
    )
    with open(f"transcripts/{vid_id}.txt", "w") as f:
        f.write(result["text"])
```

The `condition_on_previous_text=False` flag is important — without it, Whisper
occasionally gets stuck in hallucination loops where it repeats the same phrase
for minutes.

### Step 4: Extracting Ratings with an LLM

Combine all transcripts into a single file with their dates prepended:

```bash
while IFS=' ' read -r date id rest; do
  echo "=== ${rest} (${date}) ==="
  cat "transcripts/${id}.txt"
  echo
done < videos.txt > combined.txt
```

Then feed the combined transcripts to an LLM. I used Claude's CLI in batches of
about 20 videos at a time to avoid output truncation:

```bash
claude --print -p "Extract all food ratings from these ReviewBrah transcripts.
Output a markdown table with columns: Item, Restaurant, Cost, Rating (out of 10),
Date (YYYY-MM-DD). Only output the table rows, no headers." < batch1.txt
```

### Step 5: Deduplication and Cleanup

The LLM output across batches may have some inconsistencies. Merge the batch
outputs and do a final cleanup pass:

```bash
cat batch*_output.txt | claude --print -p "Deduplicate these table rows,
normalize dates to YYYY-MM-DD, and output a clean markdown table."
```

### Conclusion

By combining:

- yt-dlp to download audio (bypassing YouTube's transcript rate limits)
- mlx-whisper for fast local transcription on Apple Silicon
- An LLM to extract structured ratings from free-form transcripts
- A final deduplication/cleanup pass

...you get a comprehensive, structured dataset from hundreds of YouTube videos
without hitting any API rate limits.
