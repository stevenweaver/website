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
    {item:"Barbecue Bounty Whopper",restaurant:"Burger King",cost:"$10.99",rating:"8.5",date:"2026-05-04"},
    {item:"Grogu's Garlic Chicken Fries",restaurant:"Burger King",cost:"$5.50",rating:"4",date:"2026-05-04"},
    {item:"Imperial Cheddar Ranch Tots",restaurant:"Burger King",cost:"$2.50",rating:"7.6",date:"2026-05-04"},
    {item:"Grogu's Blue Cookie Shake",restaurant:"Burger King",cost:"$6.00",rating:"6.6",date:"2026-05-04"},
    {item:"Diablo Dusted Crispy Chicken Nuggets",restaurant:"Taco Bell",cost:"$5.00",rating:"0.3",date:"2026-04-25"},
    {item:"Updated Spicy Chicken Sandwich",restaurant:"Wendy's",cost:"$7.30",rating:"2",date:"2026-04-17"},
    {item:"HUNTR/X Meal",restaurant:"McDonald's",cost:"$11.50",rating:"7.5",date:"2026-04-10"},
    {item:"Crispy Chicken Crunch Wrap Slider",restaurant:"Taco Bell",cost:"$3.70",rating:"0",date:"2026-04-02"},
    {item:"Jalapeno Ranch Club Sandwich",restaurant:"Chick-fil-A",cost:"$11.00",rating:"8",date:"2026-03-26"},
    {item:"New And Improved Whopper",restaurant:"Burger King",cost:"$9.00",rating:"8.7",date:"2026-03-15"},
    {item:"Big Arch",restaurant:"McDonald's",cost:"$11.00",rating:"8.5",date:"2026-03-03"},
    {item:"Reimagined Pan Pizza",restaurant:"Papa John's",cost:"$18.00",rating:"4",date:"2026-02-23"},
    {item:"Crispy Chicken Nuggets",restaurant:"Taco Bell",cost:"$6.00",rating:"8.5",date:"2026-02-12"},
    {item:"Diablo Ranch Sauce",restaurant:"Taco Bell",cost:"-",rating:"8",date:"2026-02-12"},
    {item:"Bacon Hot Honey Chicken McCrispy Sandwich",restaurant:"McDonald's",cost:"$8.20",rating:"2",date:"2026-01-30"},
    {item:"All-American Smasher Meal",restaurant:"Sonic",cost:"$6.00",rating:"9.1",date:"2026-01-23"},
    {item:"Volcano Quesarito",restaurant:"Taco Bell",cost:"$5.50",rating:"7",date:"2026-01-16"},
    {item:"SpongeBob's Crabby Whopper",restaurant:"Burger King",cost:"$8.50",rating:"0.2",date:"2025-12-15"},
    {item:"Mr. Krabs' Cheesy Bacon Tots",restaurant:"Burger King",cost:"$3",rating:"8.0",date:"2025-12-15"},
    {item:"Steak & Poblano Rolled Quesadilla",restaurant:"Taco Bell",cost:"$5.69",rating:"8.6",date:"2025-12-10"},
    {item:"Grinch Meal",restaurant:"McDonald's",cost:"$15",rating:"8.0",date:"2025-12-03"},
    {item:"Spicy Chicken Ranch Bacon Pizza",restaurant:"Domino's",cost:"$20",rating:"2",date:"2025-11-26"},
    {item:"McRib 2025",restaurant:"McDonald's",cost:"$7",rating:"9.2",date:"2025-11-18"},
    {item:"Baja Blast Pie",restaurant:"Taco Bell",cost:"$20",rating:"8.8",date:"2025-11-08"},
    {item:"Steak Nuggets",restaurant:"Arby's",cost:"$5.29",rating:"4.8",date:"2025-11-03"},
    {item:"Whopper (received instead of Jack O' Lantern Whopper)",restaurant:"Burger King",cost:"$10",rating:"2.1",date:"2025-10-27"},
    {item:"Flamin' Hot Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$6-$8",rating:"9.2",date:"2025-10-19"},
    {item:"Honey BBQ Sauce on Chicken Tenders",restaurant:"KFC",cost:"$11",rating:"3",date:"2025-10-11"},
    {item:"Chicken Tendys",restaurant:"Wendy's",cost:"$5",rating:"8.5",date:"2025-10-07"},
    {item:"Sizzling Sriracha Dippers",restaurant:"Popeyes",cost:"-",rating:"6",date:"2025-09-29"},
    {item:"Smoking Rojo Sandwich",restaurant:"Popeyes",cost:"-",rating:"2",date:"2025-09-29"},
    {item:"Ghost Pepper Wings (without sauce)",restaurant:"Popeyes",cost:"-",rating:"4",date:"2025-09-29"},
    {item:"Ghost Pepper Wings (with Last Dab Ranch)",restaurant:"Popeyes",cost:"-",rating:"6.5",date:"2025-09-29"},
    {item:"The Last Dab Apollo Hot Sauce",restaurant:"Popeyes",cost:"$1",rating:"9",date:"2025-09-29"},
    {item:"Hot Ones Menu (overall)",restaurant:"Popeyes",cost:"~$22",rating:"6",date:"2025-09-29"},
    {item:"Papa Dippa Pizza",restaurant:"Papa John's",cost:"$13.99",rating:"7.9",date:"2025-09-22"},
    {item:"Cheesesteak Crazy Puffs",restaurant:"Little Caesars",cost:"$4.81",rating:"8.8",date:"2025-09-16"},
    {item:"Special Edition Gold Sauce",restaurant:"McDonald's",cost:"$2.89",rating:"6",date:"2025-09-12"},
    {item:"Pretzel Cheddar Club Sandwich (Original)",restaurant:"Chick-fil-A",cost:"-",rating:"9.9",date:"2025-09-03"},
    {item:"McDonaldland Meal (10-piece nuggets)",restaurant:"McDonald's",cost:"$17.30",rating:"6.5",date:"2025-08-19"},
    {item:"Garlic 5-Cheese Crust Pizza (Large Pepperoni)",restaurant:"Papa John's",cost:"$12.00",rating:"9",date:"2025-08-13"},
    {item:"Wednesday Meal of Misfortune",restaurant:"Wendy's",cost:"$15.00",rating:"6.5",date:"2025-08-08"},
    {item:"Hot Lemon Wings (10-piece bone-in)",restaurant:"Wingstop",cost:"$14.00",rating:"8.5",date:"2025-08-04"},
    {item:"Sweet Chipotle Barbecue Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$3.19",rating:"1.2",date:"2025-07-28"},
    {item:"Chicken Dippers with Signature Sauce",restaurant:"Popeyes",cost:"$5.00",rating:"8.25",date:"2025-07-23"},
    {item:"Barbecue Brisket Whopper",restaurant:"Burger King",cost:"$10.00",rating:"6.7",date:"2025-07-18"},
    {item:"Spicy Snack Wrap",restaurant:"McDonald's",cost:"$3.79",rating:"6.5",date:"2025-07-13"},
    {item:"Ranch Snack Wrap",restaurant:"McDonald's",cost:"$3.79",rating:"8.6",date:"2025-07-13"},
    {item:"Avocado Ranch Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$3.20",rating:"0.5",date:"2025-07-08"},
    {item:"Fantastic Four in One Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"8",date:"2025-06-30"},
    {item:"Takis Fuego Meal",restaurant:"Wendy's",cost:"$11.97",rating:"8.9",date:"2025-06-23"},
    {item:"Hershey's S'mores McFlurry",restaurant:"McDonald's",cost:"$5.00",rating:"6",date:"2025-06-16"},
    {item:"Cheddar Crust Pizza (Large Pepperoni)",restaurant:"Papa John's",cost:"$13.00",rating:"8.4",date:"2025-06-10"},
    {item:"Chicken Wrap (Classic)",restaurant:"Popeyes",cost:"$5.00",rating:"2.5",date:"2025-06-05"},
    {item:"Dragon Flame-Grilled Whopper",restaurant:"Burger King",cost:"$8.50",rating:"6",date:"2025-05-29"},
    {item:"Fiery Dragon Mozzarella Fries",restaurant:"Burger King",cost:"$3.29",rating:"7",date:"2025-05-29"},
    {item:"Soarin' Strawberry Lemonade",restaurant:"Burger King",cost:"$3.50",rating:"7.2",date:"2025-05-29"},
    {item:"Viking's Chocolate Sundae",restaurant:"Burger King",cost:"$2.00",rating:"8",date:"2025-05-29"},
    {item:"Mike's Hot Honey Diablo Sauce",restaurant:"Taco Bell",cost:"$0.25",rating:"1",date:"2025-05-25"},
    {item:"KFC Chicken & Waffles (3-piece tender meal)",restaurant:"KFC",cost:"$10.60",rating:"2.5",date:"2025-05-19"},
    {item:"Big QP Burger",restaurant:"Chili's",cost:"$10",rating:"9.1",date:"2025-05-11"},
    {item:"McCrispy Strips (3-piece)",restaurant:"McDonald's",cost:"$5",rating:"8.5",date:"2025-05-04"},
    {item:"Crispy Chicken Nuggets (10-piece combo)",restaurant:"Taco Bell",cost:"$9",rating:"7",date:"2025-04-28"},
    {item:"Cajun Crunch Spicy Chicken Sandwich",restaurant:"Wendy's",cost:"$7.50",rating:"2",date:"2025-04-22"},
    {item:"Pickle Glaze Chicken Sandwich",restaurant:"Popeyes",cost:"$6",rating:"8.7",date:"2025-04-14"},
    {item:"Pickle Lemonade",restaurant:"Popeyes",cost:"$4.35",rating:"6.5",date:"2025-04-14"},
    {item:"Minecraft Movie Meal (10-piece McNuggets)",restaurant:"McDonald's",cost:"$15",rating:"7",date:"2025-04-05"},
    {item:"Cheesy Bites Pizza (Ranch Lover's Flight)",restaurant:"Pizza Hut",cost:"$14",rating:"7",date:"2025-04-01"},
    {item:"Smokehouse Barbecue Bacon Sandwich",restaurant:"Chick-fil-A",cost:"$7.85",rating:"9.4",date:"2025-03-25"},
    {item:"Steakhouse Bacon Whopper",restaurant:"Burger King",cost:"$9",rating:"7.2",date:"2025-03-17"},
    {item:"Steak & Queso Crunchwrap Sliders",restaurant:"Taco Bell",cost:"$5",rating:"5",date:"2025-03-10"},
    {item:"Steak & Queso Crunchwrap Sliders - Green Chile Verde Sauce",restaurant:"Taco Bell",cost:"-",rating:"1",date:"2025-03-10"},
    {item:"Parmesan Stuffed Crust Pizza (Pepperoni)",restaurant:"Domino's",cost:"$9.99",rating:"8.6",date:"2025-03-05"},
    {item:"Birthday Cake Churros",restaurant:"Taco Bell",cost:"$1.99",rating:"9.1",date:"2025-02-25"},
    {item:"Mike's Hot Honey Chicken Tenders",restaurant:"KFC",cost:"$7",rating:"4",date:"2025-02-18"},
    {item:"Bacon & Cheese Crazy Puffs",restaurant:"Little Caesars",cost:"$3.99",rating:"9",date:"2025-02-11"},
    {item:"Barbecue Bacon Quarter Pounder (Angel Reese Special - as received, no bacon)",restaurant:"McDonald's",cost:"$12.79",rating:"7",date:"2025-02-05"},
    {item:"Barbecue Bacon Quarter Pounder (Angel Reese Special - as intended, with bacon)",restaurant:"McDonald's",cost:"$12.79",rating:"8",date:"2025-02-05"},
    {item:"Hot Buffalo Loaded Chicken",restaurant:"Domino's",cost:"$8",rating:"1",date:"2025-01-30"},
    {item:"Cheesy Dipping Burritos (Chicken)",restaurant:"Taco Bell",cost:"$6",rating:"8.4",date:"2025-01-24"},
    {item:"Chick-fil-A New Fries",restaurant:"Chick-fil-A",cost:"-",rating:"1",date:"2025-01-16"},
    {item:"Nashville Hot Chicken Tenders",restaurant:"KFC",cost:"$10",rating:"7.6",date:"2025-01-11"},
    {item:"Taco Bell Luxe Cravings Box (2025 Edition)",restaurant:"Taco Bell",cost:"$7",rating:"8.9",date:"2025-01-05"},
    {item:"Caramel Apple Empanada",restaurant:"Taco Bell",cost:"$2.99",rating:"5.5",date:"2024-12-09"},
    {item:"McDonald's McRib",restaurant:"McDonald's",cost:"$5.50",rating:"9",date:"2024-12-02"},
    {item:"Maple Bourbon Barbecue Whopper",restaurant:"Burger King",cost:"$8.00",rating:"7.4",date:"2024-11-26"},
    {item:"Pickle Fries",restaurant:"Burger King",cost:"$5.00",rating:"1.0",date:"2024-11-26"},
    {item:"Big Clucking Chicken Sandwich",restaurant:"Applebee's",cost:"$10.00",rating:"9.4",date:"2024-11-20"},
    {item:"Midnight Cherry Freeze",restaurant:"Taco Bell",cost:"$3.80",rating:"4.6",date:"2024-11-16"},
    {item:"Shakaroni Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"9.2",date:"2024-11-09"},
    {item:"Tostada",restaurant:"Taco Bell",cost:"$2.19",rating:"6.0",date:"2024-11-02"},
    {item:"Green Sauce Burrito",restaurant:"Taco Bell",cost:"$2.49",rating:"4.9",date:"2024-11-02"},
    {item:"Meximelt",restaurant:"Taco Bell",cost:"$3.00",rating:"8.5",date:"2024-11-02"},
    {item:"Gordita Supreme",restaurant:"Taco Bell",cost:"$2.99",rating:"8.8",date:"2024-11-02"},
    {item:"KFC Original Recipe Tenders",restaurant:"KFC",cost:"$5.00",rating:"7",date:"2024-10-28"},
    {item:"KFC Comeback Sauce",restaurant:"KFC",cost:"-",rating:"3",date:"2024-10-28"},
    {item:"Wednesday's Whopper",restaurant:"Burger King",cost:"$7.00",rating:"8",date:"2024-10-20"},
    {item:"Things Rings",restaurant:"Burger King",cost:"$3.49",rating:"6.8",date:"2024-10-20"},
    {item:"Morticia Cookie Chocolate Shake",restaurant:"Burger King",cost:"$5.00 - $6.00",rating:"7.2",date:"2024-10-20"},
    {item:"Chicken Big Mac",restaurant:"McDonald's",cost:"$6.00",rating:"4.2",date:"2024-10-15"},
    {item:"Krabby Patty collab Burger",restaurant:"Wendy's",cost:"$9.00",rating:"8.5",date:"2024-10-08"},
    {item:"Pineapple under the sea Frosty",restaurant:"Wendy's",cost:"$9.00",rating:"8.6",date:"2024-10-08"},
    {item:"Witches Brew Slush Float",restaurant:"Sonic",cost:"$4.00",rating:"9.2",date:"2024-10-05"},
    {item:"Giant Cheez-It Tostada",restaurant:"Taco Bell",cost:"$3.65",rating:"8",date:"2024-09-23"},
    {item:"Giant Cheez-It Crunch Wrap",restaurant:"Taco Bell",cost:"$3.65",rating:"8",date:"2024-09-23"},
    {item:"Patty Melt",restaurant:"Five Guys",cost:"$10.00",rating:"7",date:"2024-09-18"},
    {item:"Bacon Burger",restaurant:"Five Guys",cost:"$10.00",rating:"8",date:"2024-09-18"},
    {item:"Cajun Fries",restaurant:"Five Guys",cost:"$5.00",rating:"8",date:"2024-09-18"},
    {item:"Sweet Barbecue Blaze Chicken Sandwich",restaurant:"Wing Stop",cost:"$6.79",rating:"8.25",date:"2024-09-12"},
    {item:"Mountain Dew Baja Blast Gelato",restaurant:"Taco Bell",cost:"$4.00",rating:"6.7",date:"2024-09-05"},
    {item:"Honey Pepper Pimento Chicken Sandwich",restaurant:"Chick-fil-A",cost:"$7.55",rating:"9.4",date:"2024-08-30"},
    {item:"Bourbon Barbecue Chicken Sandwich",restaurant:"Arby's",cost:"$7.50 - $9.00",rating:"0",date:"2024-08-19"},
    {item:"Curly Fries",restaurant:"Arby's",cost:"$2.00 - $3.00",rating:"0",date:"2024-08-19"},
    {item:"Jamoka Shake",restaurant:"Arby's",cost:"$2.00 - $4.00",rating:"5",date:"2024-08-19"},
    {item:"KFC Saucy Nuggets",restaurant:"KFC",cost:"$17.25",rating:"5.0",date:"2024-08-13"},
    {item:"KFC Chipotle Ranch",restaurant:"KFC",cost:"$5.75",rating:"3.0",date:"2024-08-13"},
    {item:"KFC Mango Habanero",restaurant:"KFC",cost:"$5.75",rating:"6.7",date:"2024-08-13"},
    {item:"KFC Honey Garlic",restaurant:"KFC",cost:"$5.75",rating:"5.0",date:"2024-08-13"},
    {item:"Culver's JJ Watt Meal",restaurant:"Culver's",cost:"$10.00",rating:"8.5",date:"2024-08-09"},
    {item:"Cheese Curds",restaurant:"Culver's",cost:"$10.00",rating:"8.5",date:"2024-08-09"},
    {item:"Culver's Deluxe Burger",restaurant:"Culver's",cost:"$10.00",rating:"8.5",date:"2024-08-09"},
    {item:"Root Beer",restaurant:"Culver's",cost:"$10.00",rating:"8.5",date:"2024-08-09"},
    {item:"Sonic Smasher",restaurant:"Sonic",cost:"$10.00",rating:"8",date:"2024-08-03"},
    {item:"Fiery Strawberry Sprite",restaurant:"Burger King",cost:"$3.23",rating:"8",date:"2024-07-29"},
    {item:"Fiery Mozzarella Fries",restaurant:"Burger King",cost:"$5.15",rating:"7",date:"2024-07-29"},
    {item:"Fiery Bacon Whopper",restaurant:"Burger King",cost:"$8.40",rating:"8.4",date:"2024-07-29"},
    {item:"Fiery Chicken Fries",restaurant:"Burger King",cost:"$4.79",rating:"4",date:"2024-07-29"},
    {item:"Fiery Bacon Royal Krispy Chicken Sandwich",restaurant:"Burger King",cost:"$8.40",rating:"2",date:"2024-07-29"},
    {item:"Cheesy Street Chalupa",restaurant:"Taco Bell",cost:"$5.50",rating:"4",date:"2024-07-23"},
    {item:"Taco Bell $7 Lux Cravings Box",restaurant:"Taco Bell",cost:"$9.00",rating:"8.6",date:"2024-07-17"},
    {item:"Smoky BLT Quarter Pounder",restaurant:"McDonald's",cost:"$8.00",rating:"5.5",date:"2024-07-12"},
    {item:"KitKat Banana Split McFlurry",restaurant:"McDonald's",cost:"$5.00",rating:"8.2",date:"2024-07-12"},
    {item:"Boneless Wings (Classic)",restaurant:"Popeyes",cost:"$8.00",rating:"6.0",date:"2024-07-04"},
    {item:"Boneless Wings (Signature Hot)",restaurant:"Popeyes",cost:"$8.00",rating:"4.0",date:"2024-07-04"},
    {item:"Boneless Wings (Honey Barbecue)",restaurant:"Popeyes",cost:"$8.00",rating:"8.1",date:"2024-07-04"},
    {item:"$5 Meal Deal",restaurant:"McDonald's",cost:"$5.00",rating:"8.8",date:"2024-06-28"},
    {item:"Big Cheesy Bacon Burger",restaurant:"Arby's",cost:"$10.00",rating:"8.5",date:"2024-06-24"},
    {item:"Chicago Tavern Style Pizza",restaurant:"Pizza Hut",cost:"$12.00",rating:"8",date:"2024-06-19"},
    {item:"Maple pepper bacon chicken sandwich",restaurant:"Chick-fil-A",cost:"$11.00",rating:"9",date:"2024-06-14"},
    {item:"Saucy Nuggets - Honey Barbecue",restaurant:"Wendy's",cost:"$4.00",rating:"8.3",date:"2024-06-10"},
    {item:"Saucy Nuggets - Spicy Ghost Pepper",restaurant:"Wendy's",cost:"$4.00",rating:"3.0",date:"2024-06-10"},
    {item:"Big Chee-it Crunch Wrap Supreme",restaurant:"Taco Bell",cost:"$6.00",rating:"6.7",date:"2024-06-05"},
    {item:"Mr Beast Box",restaurant:"Zach Bees",cost:"$15.00",rating:"7.8",date:"2024-05-31"},
    {item:"Pizza Hut Cheeseburger Melt",restaurant:"Pizza Hut",cost:"$8.00",rating:"2",date:"2024-05-27"},
    {item:"Grandma McFlurry",restaurant:"McDonald's",cost:"$5.00",rating:"9",date:"2024-05-22"},
    {item:"Philly Melt",restaurant:"Burger King",cost:"$6.50",rating:"4",date:"2024-05-21"},
    {item:"Barbecue Bacon Chicken Sandwich",restaurant:"Denny's",cost:"$20.00",rating:"3",date:"2024-05-16"},
    {item:"Golden Barbecue Chicken Sandwich",restaurant:"Popeyes",cost:"$8.00",rating:"7",date:"2024-05-10"},
    {item:"Chicken Tenders Meal",restaurant:"Popeyes",cost:"$20.00",rating:"",date:"2024-05-10"},
    {item:"Barbecue Chicken Wrap",restaurant:"Arby's",cost:"$3.00",rating:"8",date:"2024-05-06"},
    {item:"Bacon Cajun Ranch MC Krispy Sandwich",restaurant:"McDonald's",cost:"$6.00",rating:"4",date:"2024-05-01"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$6.00",rating:"7",date:"2024-04-27"},
    {item:"Bacon Cajun Ranch Deluxe MC Krispy Chicken Sandwich",restaurant:"McDonald's",cost:"$7.30",rating:"8.5",date:"2024-04-22"},
    {item:"New York Style Pizza",restaurant:"Domino's",cost:"$18.00",rating:"6",date:"2024-04-17"},
    {item:"Cantina crispy chicken taco",restaurant:"Taco Bell",cost:"$3.65",rating:"9.1",date:"2024-04-12"},
    {item:"Spicy Chicken McNuggets",restaurant:"McDonald's",cost:"$5.30",rating:"8.0",date:"2024-04-06"},
    {item:"KFC Saucy Nuggets (Korean Barbecue)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02"},
    {item:"KFC Saucy Nuggets (Honey Sriracha)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02"},
    {item:"KFC Saucy Nuggets (Sticky Chicky)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02"},
    {item:"KFC Saucy Nuggets (Nashville Hot)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02"},
    {item:"KFC Saucy Nuggets (Georgia Gold)",restaurant:"KFC",cost:"$5.99",rating:"4.8",date:"2024-04-02"},
    {item:"Crispy Cupy Roni Pizza",restaurant:"Papa John's",cost:"$14.00",rating:"8",date:"2024-03-27"},
    {item:"Honey Lemon Pepper Wings",restaurant:"Popeyes",cost:"$8.00",rating:"2",date:"2024-03-20"},
    {item:"Crazy Puffs",restaurant:"Little Caesars",cost:"$4.81",rating:"7.4",date:"2024-03-15"},
    {item:"Fiery Chicken Nuggets",restaurant:"Burger King",cost:"$2.99",rating:"6",date:"2024-03-10"},
    {item:"Fiery Buffalo Royal Crispy Wrap",restaurant:"Burger King",cost:"$3.00",rating:"3.5",date:"2024-03-10"},
    {item:"wicd Donald's sauce",restaurant:"McDonald's",cost:"$0.50",rating:"7",date:"2024-03-05"},
    {item:"Cheesa",restaurant:"KFC",cost:"$12.00",rating:"8",date:"2024-02-26"},
    {item:"Chicken Sandwich",restaurant:"Wendy's",cost:"$8.00",rating:"7",date:"2024-02-26"},
    {item:"Big Mac",restaurant:"McDonald's",cost:"$5.00",rating:"9",date:"2024-02-26"},
    {item:"Pizza",restaurant:"Domino's",cost:"$15.00",rating:"6",date:"2024-02-26"},
    {item:"Burrito",restaurant:"Chipotle",cost:"$10.00",rating:"8",date:"2024-02-26"},
    {item:"Wing Stop Hot Honey Chicken Sandwich",restaurant:"Wing Stop",cost:"$6.79",rating:"5.9",date:"2024-02-21"},
    {item:"Cheesy Chicken Crispata",restaurant:"Taco Bell",cost:"$3.50",rating:"6",date:"2024-02-16"},
    {item:"Candied Bacon Whopper",restaurant:"Burger King",cost:"$8.40",rating:"8.9",date:"2024-02-09"},
    {item:"Hot Honey Pizza",restaurant:"Pizza Hut",cost:"$16.00",rating:"7.2",date:"2024-02-04"},
    {item:"Double Big Mac",restaurant:"McDonald's",cost:"$7.50",rating:"7",date:"2024-01-30"},
    {item:"Breakfast Burrito",restaurant:"Wendy's",cost:"$4.00",rating:"6",date:"2024-01-26"},
    {item:"Shake Shack Korean Style Fried Chicken Sandwich",restaurant:"Shake Shack",cost:"$11.00",rating:"6",date:"2024-01-23"},
    {item:"Peanut Butter Bacon Cheeseburger",restaurant:"Sonic Drive-In",cost:"$6.00",rating:"5.8",date:"2024-01-18"},
    {item:"Three Cheese Chicken Flatbread Melt",restaurant:"Taco Bell",cost:"$2.30",rating:"7",date:"2024-01-13"},
    {item:"Slices and Sticks Pizza",restaurant:"Little Caesars",cost:"$8.00",rating:"9",date:"2024-01-09"},
    {item:"KFC Honey Barbecue Wrap",restaurant:"KFC",cost:"$3.00",rating:"6.1",date:"2024-01-04"},
    {item:"KFC Spicy Mac & Cheese Wrap",restaurant:"KFC",cost:"$3.00",rating:"4.9",date:"2024-01-04"},
    {item:"KFC Chicken Nuggets",restaurant:"KFC",cost:"$5.00",rating:"8.8",date:"2023-12-31"},
    {item:"Taco Bell Crispy Chicken Wings",restaurant:"Taco Bell",cost:"Not specified",rating:"8.9",date:"2023-12-31"},
    {item:"Taco Bell Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$4.79",rating:"9.0",date:"2023-12-31"},
    {item:"Pineapple Pepsi",restaurant:"Little Caesars",cost:"Not specified",rating:"9.0",date:"2023-12-31"},
    {item:"Chick-fil-A Honey Pepper Pimento Chicken Sandwich",restaurant:"Chick-fil-A",cost:"$9.00",rating:"9.3",date:"2023-12-31"},
    {item:"Loaded Tots",restaurant:"Domino's",cost:"$7.00",rating:"3.5",date:"2023-12-31"},
    {item:"Salsa Verde Grilled Chicken Burrito",restaurant:"Taco Bell",cost:"$2.00",rating:"3",date:"2023-12-31"},
    {item:"Spicy Melt",restaurant:"Burger King",cost:"$6.00",rating:"3",date:"2023-12-31"},
    {item:"Bourbon Barbecue Country Style Rib Sandwich",restaurant:"Arby's",cost:"$8.00",rating:"2",date:"2023-12-31"},
    {item:"Italian Original Chicken Sandwich",restaurant:"Burger King",cost:"$6.00",rating:"2",date:"2023-12-31"},
    {item:"Papa John's Cheesy Calzone Stuffed Crust Pizza",restaurant:"Papa John's",cost:"$15.00",rating:"8.35",date:"2023-12-22"},
    {item:"Bacon Melt",restaurant:"Burger King",cost:"$6.50",rating:"7.5",date:"2023-12-17"},
    {item:"Cheesy Tots",restaurant:"Burger King",cost:"$1.50",rating:"7.2",date:"2023-12-17"},
    {item:"Empty Food",restaurant:"McDonald's",cost:"$14.00",rating:"8.5",date:"2023-12-11"},
    {item:"Double Decker Taco",restaurant:"Taco Bell",cost:"$3.70",rating:"5.8",date:"2023-12-08"},
    {item:"Signature Hot Wings",restaurant:"Popeyes",cost:"$8.00",rating:"6",date:"2023-12-04"},
    {item:"Honey Barbecue Wings",restaurant:"Popeyes",cost:"$8.00",rating:"8",date:"2023-12-04"},
    {item:"Roasted Garlic Parmesan Wings",restaurant:"Popeyes",cost:"$8.00",rating:"5",date:"2023-12-04"},
    {item:"Pretzel Baconator",restaurant:"Wendy's",cost:"$8.70",rating:"8.3",date:"2023-11-30"},
    {item:"Crazy Crust Pizza",restaurant:"Little Caesars",cost:"$11.50",rating:"4",date:"2023-11-25"},
    {item:"MC Rib",restaurant:"McDonald's",cost:"$6.50",rating:"7.0",date:"2023-11-19"},
    {item:"Good Burger 2 Meal",restaurant:"Arby's",cost:"$13.50",rating:"7.2",date:"2023-11-14"},
    {item:"Breakfast Taco Sausage",restaurant:"Taco Bell",cost:"$2.00",rating:"7.9",date:"2023-11-09"},
    {item:"Burger with bacon",restaurant:"Culver's",cost:"-",rating:"2.0",date:"2023-11-04"},
    {item:"Fried Mac and Cheese Bites",restaurant:"Arby's",cost:"$4.50 - $5.00",rating:"4",date:"2023-11-02"},
    {item:"Roasted Garlic Cheese Sticks",restaurant:"Pizza Hut",cost:"$14.00",rating:"7.7",date:"2023-10-27"},
    {item:"Spicy Truff Chicken Sandwich",restaurant:"Popeyes",cost:"$8.00",rating:"4",date:"2023-10-24"},
    {item:"KFC Jamal Murray Meal",restaurant:"KFC",cost:"$11.00",rating:"6.4",date:"2023-10-21"},
    {item:"Steak and Bacon Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$7.00",rating:"8.2",date:"2023-10-16"},
    {item:"Ghost Pepper Whopper",restaurant:"Burger King",cost:"$8.40",rating:"8.1",date:"2023-10-13"},
    {item:"Ghost Pepper Chicken Fries",restaurant:"Burger King",cost:"$5.00",rating:"3.0",date:"2023-10-13"},
    {item:"Pepperoni Stuffed Cheesy Bread",restaurant:"Domino's",cost:"$7.00",rating:"7",date:"2023-10-06"},
    {item:"Honey Mustard BK Royal Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$8.00",rating:"2",date:"2023-09-30"},
    {item:"Chicken Enchilada Burrito",restaurant:"Taco Bell",cost:"$2.00",rating:"3",date:"2023-09-24"},
    {item:"Big Game Burger",restaurant:"Arby's",cost:"$9.00",rating:"7.1",date:"2023-09-18"},
    {item:"Hot and Spicy Wings",restaurant:"KFC",cost:"$6.00",rating:"7.4",date:"2023-09-14"},
    {item:"Four Quarter Calzone",restaurant:"Little Caesars",cost:"$9.00",rating:"7",date:"2023-09-09"},
    {item:"Sweet and Spicy Wings",restaurant:"Popeyes",cost:"$6.00",rating:"8.8",date:"2023-09-06"},
    {item:"Honey Pepper Pimento Chicken Sandwich",restaurant:"Chick-fil-A",cost:"$9.00",rating:"9.3",date:"2023-09-01"},
    {item:"Caramel Crumble Milkshake",restaurant:"Chick-fil-A",cost:"$2.00",rating:"6.7",date:"2023-09-01"},
    {item:"Loaded Nacho Cheeseburger",restaurant:"Wendy's",cost:"$8.00",rating:"6.7",date:"2023-08-26"},
    {item:"BK Royal Crispy Chicken Wrap",restaurant:"Burger King",cost:"$3.00",rating:"5.8",date:"2023-08-21"},
    {item:"Big Mac Meal",restaurant:"McDonald's",cost:"$14.00",rating:"6",date:"2023-08-14"},
    {item:"Italian Original Chicken Sandwich",restaurant:"Burger King",cost:"$6.00",rating:"2",date:"2023-08-12"},
    {item:"Grilled Cheese Dipping Taco",restaurant:"Taco Bell",cost:"$3.50",rating:"6.7",date:"2023-08-07"},
    {item:"Deluxe Box",restaurant:"Taco Bell",cost:"$10.00",rating:"6.7",date:"2023-08-07"},
    {item:"Blazin Knockout Wings",restaurant:"Buffalo Wild Wings",cost:"$11.00",rating:"8.5",date:"2023-08-01"},
    {item:"Garlic Epic Stuffed Crust Pizza",restaurant:"Papa John's",cost:"$14.00",rating:"8",date:"2023-07-25"},
    {item:"Pepsi Pineapple",restaurant:"Little Caesars",cost:"$2.00",rating:"9",date:"2023-07-21"},
    {item:"Cheesy Jalapeno Bacon Quarter Pounder",restaurant:"McDonald's",cost:"$8.00",rating:"8.4",date:"2023-07-15"},
    {item:"Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$3.00",rating:"4",date:"2023-07-11"},
    {item:"Ultimate Barbecue Chicken Sandwich",restaurant:"KFC",cost:"$7.00",rating:"7.3",date:"2023-07-05"},
    {item:"Volcano Taco",restaurant:"Taco Bell",cost:"$2.49",rating:"8",date:"2023-06-28"},
    {item:"Volcano Burrito",restaurant:"Taco Bell",cost:"$4.00",rating:"7.2",date:"2023-06-28"},
    {item:"Fiery Chicken Nuggets",restaurant:"Burger King",cost:"$2.99",rating:"8.5",date:"2023-06-24"},
    {item:"Boneless Wings",restaurant:"Papa John's",cost:"$8.50 (10 pcs)",rating:"5.5",date:"2023-06-19"},
    {item:"Grimace Birthday Meal",restaurant:"McDonald's",cost:"$13.50",rating:"8",date:"2023-06-12"},
    {item:"Popeyes Bacon and Cheese Chicken Sandwich",restaurant:"Popeyes",cost:"$7.00",rating:"4",date:"2023-06-09"},
    {item:"Sweet Chili Lime Wings",restaurant:"Buffalo Wild Wings",cost:"$25.00",rating:"5",date:"2023-06-05"},
    {item:"General Tso's Chicken Wings",restaurant:"Buffalo Wild Wings",cost:"$25.00",rating:"8.4",date:"2023-06-05"},
    {item:"Steak Chile Verde Fries Burrito",restaurant:"Taco Bell",cost:"$5.00",rating:"6",date:"2023-05-31"},
    {item:"Bacon Ranch Wagyu Steakhouse Burger",restaurant:"Arby's",cost:"$8.00",rating:"6.7",date:"2023-05-26"},
    {item:"Spider-Verse Whopper",restaurant:"Burger King",cost:"$6.50",rating:"8.6",date:"2023-05-21"},
    {item:"Spider-Verse Sundae",restaurant:"Burger King",cost:"$3.00",rating:"8.6",date:"2023-05-21"},
    {item:"Bourbon Barbecue Country Style Rib Sandwich",restaurant:"Arby's",cost:"$8.00",rating:"2",date:"2023-05-16"},
    {item:"Ghost Pepper Ranch Chicken Sandwich",restaurant:"Wendy's",cost:"$8.00",rating:"6",date:"2023-05-12"},
    {item:"Doritos Cool Ranch Chicken Papadia",restaurant:"Papa John's",cost:"$7.99",rating:"7.5",date:"2023-05-08"},
    {item:"Cheese Steak Melt",restaurant:"Pizza Hut",cost:"$8.53",rating:"3.5",date:"2023-05-03"},
    {item:"Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$4.79",rating:"9",date:"2023-04-26"},
    {item:"Spicy Chicken Nuggets",restaurant:"McDonald's",cost:"$7.00",rating:"8.6",date:"2023-04-22"},
    {item:"Nacho Fries 2023 Edition",restaurant:"Taco Bell",cost:"$3.50",rating:"8.9",date:"2023-04-17"},
    {item:"Whopper Melt",restaurant:"Burger King",cost:"$7.00",rating:"3",date:"2023-04-10"},
    {item:"Spicy Melt",restaurant:"Burger King",cost:"$6.00",rating:"3",date:"2023-04-10"},
    {item:"Regular Burger",restaurant:"Burger King",cost:"$5.00",rating:"7",date:"2023-04-10"},
    {item:"Chicken Sandwich",restaurant:"Burger King",cost:"$5.00",rating:"6",date:"2023-04-10"},
    {item:"Whopper",restaurant:"Burger King",cost:"$8.00",rating:"8",date:"2023-04-10"},
    {item:"KFC Chicken Nuggets",restaurant:"KFC",cost:"$5.00",rating:"8.8",date:"2023-04-05"},
    {item:"Little Caesars Pretzel Crust Pizza",restaurant:"Little Caesars",cost:"$7.00",rating:"8",date:"2023-03-29"},
    {item:"Honey Barbecue Wings",restaurant:"Buffalo Wild Wings",cost:"$12.00",rating:"4.5",date:"2023-03-27"},
    {item:"Medium Wings",restaurant:"Buffalo Wild Wings",cost:"$12.00",rating:"3.0",date:"2023-03-27"},
    {item:"Bacon Club Chalupa",restaurant:"Taco Bell",cost:"$5.00",rating:"8.15",date:"2023-03-22"},
    {item:"McDonald's Bacon Ranch McCrispy Sandwich",restaurant:"McDonald's",cost:"$7.50",rating:"4",date:"2023-03-17"},
    {item:"Spicy Chicken Fries",restaurant:"Burger King",cost:"$8.00",rating:"8",date:"2023-03-13"},
    {item:"Double Down Sandwich",restaurant:"KFC",cost:"$11.50",rating:"7.6",date:"2023-03-07"},
    {item:"Kentucky Fried Wrap",restaurant:"KFC",cost:"$3.50",rating:"7.5",date:"2023-03-01"},
    {item:"Cheddar Bacon Loaded Tots",restaurant:"Domino's",cost:"$7.00",rating:"3.5",date:"2023-02-23"},
    {item:"$18 Meal (Cheeseburger w/ BBQ, Quarter Pounder, Fries, Apple Pie, Coke, Hi-C)",restaurant:"McDonald's",cost:"$18.00",rating:"6.5",date:"2023-02-16"},
    {item:"Big New Yorker Pizza",restaurant:"Pizza Hut",cost:"$13.99",rating:"8.7",date:"2023-02-11"},
    {item:"Crispy Melt Taco",restaurant:"Taco Bell",cost:"$2.49",rating:"5.8",date:"2023-02-06"},
    {item:"Papa John's Crispy Parm Pizza",restaurant:"Papa John's",cost:"$12.99",rating:"7",date:"2023-01-31"},
    {item:"Crispy Chicken Wings",restaurant:"Taco Bell",cost:"$9.00",rating:"8.9",date:"2023-01-24"},
    {item:"Mexican Original Chicken Sandwich",restaurant:"Burger King",cost:"$6.00",rating:"5.5",date:"2023-01-13"},
    {item:"Ghost Pepper Wings",restaurant:"Popeyes",cost:"$12.00",rating:"6.5",date:"2023-01-07"},
    {item:"Salsa Verde Grilled Chicken Burrito",restaurant:"Taco Bell",cost:"$2.00",rating:"7.5",date:"2023-01-02"},
    {item:"Oreo cookie Papa bites",restaurant:"Papa John's",cost:"$5.00",rating:"4.8",date:"2022-12-27"},
    {item:"Seven Layer Nacho Fries Bowl",restaurant:"Taco Bell",cost:"$3.49",rating:"6",date:"2022-12-20"},
    {item:"Breakfast Crunchwrap",restaurant:"Taco Bell",cost:"$4.00",rating:"6.5",date:"2022-12-20"},
    {item:"Italian Sandwich",restaurant:"Wendy's",cost:"$X.XX",rating:"1",date:"2022-12-12"},
    {item:"Carolina Gold BBQ Sandwich",restaurant:"Wingstop",cost:"$6.40",rating:"7",date:"2022-12-12"},
    {item:"Italian Mozzarella Chicken Sandwich",restaurant:"Wendy's",cost:"$8.50",rating:"1.5",date:"2022-12-02"},
    {item:"Smoky BLT Quarter Pounder with Cheese",restaurant:"McDonald's",cost:"$8.00",rating:"9",date:"2022-11-26"},
    {item:"Blackened Chicken Sandwich",restaurant:"Popeyes",cost:"$6.00",rating:"3",date:"2022-11-19"},
    {item:"Pizza Hut Melt",restaurant:"Pizza Hut",cost:"$8.40",rating:"9",date:"2022-11-12"},
    {item:"McRib",restaurant:"McDonald's",cost:"$5.70",rating:"5.6",date:"2022-11-05"},
    {item:"Arby's Diablo Sandwich",restaurant:"Arby's",cost:"$6.79",rating:"8.5",date:"2022-10-28"},
    {item:"Ghost Pepper Whopper",restaurant:"Burger King",cost:"$9.00",rating:"8.4",date:"2022-10-18"},
    {item:"Wing Stop Chicken Sandwich",restaurant:"Wing Stop",cost:"$7.00",rating:"5.5",date:"2022-10-12"},
    {item:"Cactus Plant Flea Market Meal",restaurant:"McDonald's",cost:"$11.50",rating:"7",date:"2022-10-04"},
    {item:"Hot Ones Burger",restaurant:"Shake Shack",cost:"$10.00",rating:"8",date:"2022-09-28"},
    {item:"Detroit Style Pizza",restaurant:"Pizza Hut",cost:"$14.00",rating:"7",date:"2022-09-15"},
    {item:"Royal Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$5.50",rating:"4.9",date:"2022-09-14"},
    {item:"Hot Honey Not Bird Person Combo",restaurant:"Wendy's",cost:"$11.50",rating:"6",date:"2022-09-08"},
    {item:"Italian Meat Trio Bowl",restaurant:"Papa John's",cost:"$8.00",rating:"3",date:"2022-08-29"},
    {item:"Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$7.00",rating:"7.0",date:"2022-08-22"},
    {item:"Home Style French Toast Sticks",restaurant:"Wendy's",cost:"$2.79",rating:"2",date:"2022-08-17"},
    {item:"Crispy Chicken Sandwich Meal Deal",restaurant:"McDonald's",cost:"$8.00",rating:"5",date:"2022-08-11"},
    {item:"Old World Fanceroni Pizza",restaurant:"Little Caesars",cost:"$10.00",rating:"7.2",date:"2022-08-05"},
    {item:"Hush Puppy Breaded Fish Strips",restaurant:"Arby's",cost:"$4.30 (3 piece), $6.29 (6 piece)",rating:"6.0",date:"2022-08-01"},
    {item:"Buffalo Wild Wings Saucy Chicken Sandwich",restaurant:"Buffalo Wild Wings",cost:"$10.50",rating:"5.9",date:"2022-07-26"},
    {item:"Chicken Sandwich Meal",restaurant:"Popeyes",cost:"$6.00",rating:"7.8",date:"2022-07-21"},
    {item:"Cantina Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$3.00",rating:"1",date:"2022-07-15"},
    {item:"Southwest Bacon Whopper",restaurant:"Burger King",cost:"$7.00",rating:"6",date:"2022-07-11"},
    {item:"Impossible King",restaurant:"Burger King",cost:"$7.00",rating:"8.5",date:"2022-07-05"},
    {item:"Whopper",restaurant:"Burger King",cost:"$7.00",rating:"N/A",date:"2022-07-05"},
    {item:"Classic Cheesy Double Beef Burrito",restaurant:"Taco Bell",cost:"$2.00 - $2.50",rating:"7.5",date:"2022-06-30"},
    {item:"Honey Barbecue Bird Dog",restaurant:"Buffalo Wild Wings",cost:"$10.00",rating:"5",date:"2022-06-25"},
    {item:"Wisconsin Big Cheese Pub Burger",restaurant:"Culver's",cost:"$7.00",rating:"3",date:"2022-06-20"},
    {item:"Toasted Cheddar Chalupa",restaurant:"Taco Bell",cost:"$4.19",rating:"8.5",date:"2022-06-16"},
    {item:"Edge Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"9",date:"2022-06-10"},
    {item:"Thin & Crispy Crust",restaurant:"Pizza Hut",cost:"$13.00",rating:"9",date:"2022-06-10"},
    {item:"Jack Harlow Meal",restaurant:"KFC",cost:"$10.79",rating:"8",date:"2022-06-06"},
    {item:"Spicy Chicken Sandwich",restaurant:"KFC",cost:"Included",rating:"8",date:"2022-06-06"},
    {item:"Mac and Cheese",restaurant:"KFC",cost:"Included",rating:"6",date:"2022-06-06"},
    {item:"Secret Recipe Fries",restaurant:"KFC",cost:"Included",rating:"8",date:"2022-06-06"},
    {item:"Lemonade",restaurant:"KFC",cost:"Included",rating:"7",date:"2022-06-06"},
    {item:"Deluxe Wagyu Steakhouse Burger",restaurant:"Arby's",cost:"$6.49",rating:"8",date:"2022-05-30"},
    {item:"Mexican Pizza",restaurant:"Taco Bell",cost:"$5.00",rating:"3",date:"2022-05-23"},
    {item:"Spicy Take Chicken Sandwich",restaurant:"Panera Bread",cost:"$13.00",rating:"6.8",date:"2022-05-19"},
    {item:"Bourbon Bacon Cheddar Burger",restaurant:"Shake Shack",cost:"$10.00",rating:"3",date:"2022-05-12"},
    {item:"Popeye's Buffalo Ranch Chicken Sandwich",restaurant:"Popeyes",cost:"$5.00",rating:"7.6",date:"2022-05-06"},
    {item:"Epic Stuffed Crust Pizza",restaurant:"Papa John's",cost:"$20.00",rating:"9",date:"2022-05-01"},
    {item:"Detroit Style Deep Dish Pizza",restaurant:"Little Caesars",cost:"$12.00",rating:"8",date:"2022-04-25"},
    {item:"Steak White Hot Ranch Fries Burrito",restaurant:"Taco Bell",cost:"$3.49",rating:"9",date:"2022-04-18"},
    {item:"Popeyes Surf and Turf Combo",restaurant:"Popeyes",cost:"$8.00",rating:"8.2",date:"2022-04-11"},
    {item:"Spicy Chicken Nuggets",restaurant:"McDonald's",cost:"$7.00",rating:"8",date:"2022-04-05"},
    {item:"McDonald's Szechuan Sauce",restaurant:"McDonald's",cost:"$2.00",rating:"8.5",date:"2022-03-31"},
    {item:"Dippable Chicken Nuggets",restaurant:"McDonald's",cost:"$3.00",rating:"8.5",date:"2022-03-31"},
    {item:"French Fries",restaurant:"McDonald's",cost:"$2.00",rating:"8.5",date:"2022-03-31"},
    {item:"Szechuan Sauce",restaurant:"McDonald's",cost:"Complimentary",rating:"8.5",date:"2022-03-31"},
    {item:"Spicy Chicken Sandwich",restaurant:"KFC",cost:"$5.60",rating:"7",date:"2022-03-27"},
    {item:"Secret Recipe Fries",restaurant:"KFC",cost:"$3.00",rating:"7",date:"2022-03-27"},
    {item:"Famous Biscuits",restaurant:"KFC",cost:"$2.00",rating:"7",date:"2022-03-27"},
    {item:"Steak Nacho Fries Burrito",restaurant:"Taco Bell",cost:"$5.00",rating:"7",date:"2022-03-21"},
    {item:"Cherry Sunrise Freeze",restaurant:"Taco Bell",cost:"$3.30",rating:"8",date:"2022-03-21"},
    {item:"Spicy Flounder Fish Sandwich",restaurant:"Popeyes",cost:"$5.49",rating:"2",date:"2022-03-09"},
    {item:"Big King",restaurant:"Burger King",cost:"$6.00",rating:"5",date:"2022-03-03"},
    {item:"Coca-Cola Starlight",restaurant:"Coca-Cola",cost:"$2 - $5",rating:"8.7",date:"2022-02-28"},
    {item:"Coca-Cola Starlight Zero Sugar",restaurant:"Coca-Cola",cost:"$2 - $5",rating:"4",date:"2022-02-28"},
    {item:"Hash Brown McMuffin",restaurant:"McDonald's",cost:"$9.00",rating:"7",date:"2022-02-20"},
    {item:"Taco Bell Cantina Crispy Chicken Taco",restaurant:"Taco Bell",cost:"$4.00",rating:"6.5",date:"2022-02-15"},
    {item:"Hot Honey Chicken Sandwich",restaurant:"Wendy's",cost:"$10.00",rating:"8.6",date:"2022-02-10"},
    {item:"Spicy Lovers Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"8.5",date:"2022-02-05"},
    {item:"Land Air and Sea",restaurant:"McDonald's",cost:"$8.00",rating:"3",date:"2022-01-31"},
    {item:"Batman Calzone",restaurant:"Little Caesars",cost:"$8.00",rating:"5.8",date:"2022-01-26"},
    {item:"Diablo Dare Sandwich",restaurant:"Arby's",cost:"$6.00",rating:"7.4",date:"2022-01-18"},
    {item:"Beyond Fried Chicken",restaurant:"KFC",cost:"$7.00",rating:"0.5",date:"2022-01-12"},
    {item:"Little Caesars Pizza",restaurant:"Little Caesars",cost:"$5.55",rating:"6.7",date:"2022-01-05"},
    {item:"Marketing and Deception",restaurant:"Little Caesars",cost:"$5.55",rating:"2.0",date:"2022-01-05"},
    {item:"New York Style Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"7.7",date:"2021-12-31"},
    {item:"New York Style Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"7.7",date:"2021-12-27"},
    {item:"Chipotle Cheddar Chalupa",restaurant:"Taco Bell",cost:"$3.89",rating:"5",date:"2021-12-27"},
    {item:"Spicy Tender Sandwich",restaurant:"PDQ",cost:"$7.25",rating:"5.7",date:"2021-12-22"},
    {item:"Mariah Menu Cheeseburger",restaurant:"McDonald's",cost:"-",rating:"6",date:"2021-12-18"},
    {item:"Small Fries",restaurant:"Wendy's",cost:"$1.69",rating:"7.7",date:"2021-12-10"},
    {item:"Medium Fries",restaurant:"McDonald's",cost:"$3.19",rating:"7.9",date:"2021-12-10"},
    {item:"Large Fries",restaurant:"Burger King",cost:"$2.39",rating:"4",date:"2021-12-10"},
    {item:"Triple Treat Box",restaurant:"Pizza Hut",cost:"$25.50",rating:"7.5",date:"2021-12-06"},
    {item:"Orange Szechuan Wings",restaurant:"Wingstop",cost:"$15.00",rating:"8",date:"2021-12-02"},
    {item:"Cheetos Boneless Wings",restaurant:"Applebee's",cost:"$11.99",rating:"6.5",date:"2021-11-27"},
    {item:"Cheetos Flamin' Hot Boneless Wings",restaurant:"Applebee's",cost:"$11.99",rating:"6.5",date:"2021-11-27"},
    {item:"Italian Original Chicken Sandwich",restaurant:"Burger King",cost:"$7.00",rating:"2",date:"2021-11-23"},
    {item:"Double Steak Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$6.50",rating:"7.75",date:"2021-11-14"},
    {item:"McRib",restaurant:"McDonald's",cost:"$3.00 - $5.00",rating:"5",date:"2021-11-05"},
    {item:"Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$6.00",rating:"7.75",date:"2021-11-01"},
    {item:"Classic Buffalo Boneless Wings",restaurant:"Arby's",cost:"$5.00",rating:"8.5",date:"2021-11-01"},
    {item:"Hot Honey Boneless Wings",restaurant:"Arby's",cost:"$5.00",rating:"8",date:"2021-11-01"},
    {item:"Triple Bacon Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"8.2",date:"2021-10-27"},
    {item:"Hottie Chicken Sandwich",restaurant:"Popeyes",cost:"$3.50",rating:"8",date:"2021-10-19"},
    {item:"Ghost Pepper Chicken Nuggets",restaurant:"Burger King",cost:"$1.49 (8 pcs)",rating:"5.4",date:"2021-10-13"},
    {item:"Ghost Pepper Nuggets",restaurant:"Burger King",cost:"$1.00",rating:"5.4",date:"2021-10-13"},
    {item:"Cantina Crispy Melt Taco",restaurant:"Taco Bell",cost:"$2.19",rating:"7.7",date:"2021-10-08"},
    {item:"Doritos Spicy Sweet Chili Wings",restaurant:"Buffalo Wild Wings",cost:"$10.00",rating:"5",date:"2021-10-02"},
    {item:"Rodeo Burger",restaurant:"Burger King",cost:"$1.00",rating:"8",date:"2021-09-28"},
    {item:"Signature Sandwich",restaurant:"Zaxby's",cost:"$7.39",rating:"8.5",date:"2021-09-21"},
    {item:"Detroit Style Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"9",date:"2021-09-15"},
    {item:"Big Bacon Cheddar Cheeseburger",restaurant:"Wendy's",cost:"$7.00",rating:"7.8",date:"2021-09-09"},
    {item:"Crispy Chicken Sandwich Taco",restaurant:"Taco Bell",cost:"$2.49",rating:"5.5",date:"2021-09-04"},
    {item:"Crispy Chicken Sandwich Taco (Spicy)",restaurant:"Taco Bell",cost:"$2.49",rating:"5.5",date:"2021-09-04"},
    {item:"Chakaroni Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"8",date:"2021-09-01"},
    {item:"Shaq-a-Roni Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"8",date:"2021-09-01"},
    {item:"Loaded Taco Fries Burrito",restaurant:"Taco Bell",cost:"$3.00",rating:"6",date:"2021-08-26"},
    {item:"Crazy Calzone Pepperoni",restaurant:"Little Caesars",cost:"$8.50",rating:"7.4",date:"2021-08-19"},
    {item:"Crazy Calzony Pepperoni",restaurant:"Little Caesars",cost:"$8.50",rating:"7.4",date:"2021-08-19"},
    {item:"Big Dinner Box",restaurant:"Pizza Hut",cost:"$23.00",rating:"8.3",date:"2021-08-14"},
    {item:"Saweetie Meal",restaurant:"McDonald's",cost:"$12.00",rating:"8",date:"2021-08-09"},
    {item:"Garlic Bacon King",restaurant:"Burger King",cost:"$8.00",rating:"7.3",date:"2021-08-04"},
    {item:"Chicken Nuggets",restaurant:"Popeyes",cost:"$10.00",rating:"6",date:"2021-07-29"},
    {item:"Unknown Chicken Sandwich",restaurant:"Buffalo Wild Wings",cost:"$5.99",rating:"2",date:"2021-07-20"},
    {item:"Ghost Pepper Ranch Sauce",restaurant:"Wendy's",cost:"-",rating:"6.7",date:"2021-07-16"},
    {item:"Single Bacon King",restaurant:"Burger King",cost:"$5.49",rating:"5.8",date:"2021-07-11"},
    {item:"Bacon Burger",restaurant:"Five Guys",cost:"$11.00",rating:"9",date:"2021-07-07"},
    {item:"Cajun Fries",restaurant:"Five Guys",cost:"$5.00",rating:"8",date:"2021-07-07"},
    {item:"Vanilla Shake",restaurant:"Five Guys",cost:"$6.00",rating:"7.5",date:"2021-07-07"},
    {item:"Premium Chicken Nuggets",restaurant:"Arby's",cost:"$5.19",rating:"6.5",date:"2021-07-02"},
    {item:"Grande Crunchwrap",restaurant:"Taco Bell",cost:"$3.49",rating:"7",date:"2021-06-26"},
    {item:"Ch'King Sandwich",restaurant:"Burger King",cost:"$5.82",rating:"5",date:"2021-06-21"},
    {item:"Pepperoni and Cheese Stuffed Crust Pizza",restaurant:"Little Caesars",cost:"$10.00",rating:"7",date:"2021-06-16"},
    {item:"Naked Chicken Chalupa",restaurant:"Taco Bell",cost:"$3.49",rating:"7",date:"2021-06-09"},
    {item:"The Edge Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"8.5",date:"2021-06-03"},
    {item:"BTS Meal",restaurant:"McDonald's",cost:"$8.50",rating:"8.5",date:"2021-05-26"},
    {item:"Parmesan Crusted Papadia",restaurant:"Papa John's",cost:"$7.00",rating:"6.0",date:"2021-05-20"},
    {item:"Spicy Deluxe Ch'King Sandwich",restaurant:"Burger King",cost:"$5.82",rating:"2",date:"2021-05-14"},
    {item:"Bourbon Bacon Cheeseburger",restaurant:"Wendy's",cost:"$6.00",rating:"8.0",date:"2021-05-08"},
    {item:"Dream Burger",restaurant:"MrBeast Burger",cost:"$6.99",rating:"8.0",date:"2021-04-27"},
    {item:"Deluxe Crispy Chicken Sandwich",restaurant:"McDonald's",cost:"$5.00",rating:"7.3",date:"2021-04-23"},
    {item:"Beefy Potato-Rito",restaurant:"Taco Bell",cost:"$1.00",rating:"8.8",date:"2021-04-18"},
    {item:"Shack Burger (Double)",restaurant:"Shake Shack",cost:"$9.00",rating:"9",date:"2021-04-10"},
    {item:"French Fries",restaurant:"Shake Shack",cost:"$3.00",rating:"6.5",date:"2021-04-10"},
    {item:"Vanilla Shake",restaurant:"Shake Shack",cost:"$6.00",rating:"7",date:"2021-04-10"},
    {item:"Spicy Greek Gyro",restaurant:"Arby's",cost:"$3.50",rating:"6.8",date:"2021-04-06"},
    {item:"Crinkle Fries",restaurant:"Arby's",cost:"$1.00",rating:"7.5",date:"2021-04-06"},
    {item:"Extra Most Bestest Thin Crust Pizza",restaurant:"Little Caesars",cost:"$6.49",rating:"8.2",date:"2021-04-01"},
    {item:"BBQ Crispy Chicken Taco",restaurant:"Del Taco",cost:"$1.00",rating:"9",date:"2021-03-29"},
    {item:"Bacon Double Stack",restaurant:"Wendy's",cost:"$3.99",rating:"6.8",date:"2021-03-25"},
    {item:"Classic Chicken Sandwich",restaurant:"KFC",cost:"$4.99",rating:"6.4",date:"2021-03-19"},
    {item:"Quesalupa",restaurant:"Taco Bell",cost:"$3.00",rating:"7",date:"2021-03-14"},
    {item:"Sourdough King",restaurant:"Burger King",cost:"$8.00",rating:"6.5",date:"2021-03-09"},
    {item:"Jalapeno Popper Chicken Sandwich",restaurant:"Wendy's",cost:"$7.00",rating:"7.7",date:"2021-03-03"},
    {item:"Crispy Chicken Sandwich",restaurant:"McDonald's",cost:"$6.00",rating:"7.5",date:"2021-02-24"},
    {item:"Spicy Crispy Chicken Sandwich",restaurant:"McDonald's",cost:"$6.00",rating:"8",date:"2021-02-24"},
    {item:"Shamrock Shake",restaurant:"McDonald's",cost:"$3.99",rating:"6.5",date:"2021-02-15"},
    {item:"Cajun Flounder Sandwich",restaurant:"Popeyes",cost:"$8.00",rating:"7.4",date:"2021-02-10"},
    {item:"Pepperoni Pizza Melt",restaurant:"Red Baron",cost:"$3.00",rating:"8",date:"2021-02-06"},
    {item:"Spicy Chicken McNuggets",restaurant:"McDonald's",cost:"$6.00",rating:"9.3",date:"2021-02-01"},
    {item:"Detroit Style Pizza",restaurant:"Pizza Hut",cost:"$10.99",rating:"9",date:"2021-01-27"},
    {item:"Pepperoni Flatbread Pizza",restaurant:"Panera Bread",cost:"$11.00",rating:"8.6",date:"2021-01-22"},
    {item:"Ultra Watermelon Energy Drink",restaurant:"Monster",cost:"$3.00",rating:"7.0",date:"2021-01-18"},
    {item:"Rip'n Chicken Big Box",restaurant:"Popeyes",cost:"$6.00",rating:"8.4",date:"2021-01-12"},
    {item:"Bacon Club Chalupa",restaurant:"Taco Bell",cost:"$3.49",rating:"3",date:"2021-01-08"},
    {item:"Epic Stuffed Crust Pizza",restaurant:"Papa John's",cost:"$12.00",rating:"8.7",date:"2021-01-03"},
    {item:"Beast Style Burger",restaurant:"MrBeast Burger",cost:"$6.99",rating:"7",date:"2020-12-20"},
    {item:"Triple Treat Box",restaurant:"Pizza Hut",cost:"$20.99",rating:"8.5",date:"2020-12-14"},
    {item:"McRib",restaurant:"McDonald's",cost:"$3.70",rating:"7.5",date:"2020-12-04"},
    {item:"Pizza Wings",restaurant:"Buffalo Wild Wings",cost:"$10.00",rating:"5.7",date:"2020-11-29"},
    {item:"Cheeser! Cheeser! Pizza",restaurant:"Little Caesars",cost:"$7.00",rating:"8.0",date:"2020-11-24"},
    {item:"Deep Fried Turkey Club Sandwich",restaurant:"Arby's",cost:"$9.00",rating:"5.5",date:"2020-11-21"},
    {item:"Beyond Italian Sausage Pizza",restaurant:"Pizza Hut",cost:"$14.99",rating:"9",date:"2020-11-16"},
    {item:"Toasted Cheddar Chalupa",restaurant:"Taco Bell",cost:"$2.99",rating:"7",date:"2020-11-10"},
    {item:"Twisty Wicked Shrimp",restaurant:"Popeyes",cost:"$5.00",rating:"8.25",date:"2020-11-06"},
    {item:"Halloween Doughnuts",restaurant:"Krispy Kreme",cost:"$7.00",rating:"6.7",date:"2020-10-31"},
    {item:"Double Cheeseburger Papadia",restaurant:"Papa John's",cost:"$8.00",rating:"4",date:"2020-10-27"},
    {item:"Classic Chicken Sandwich",restaurant:"Wendy's",cost:"$5.40",rating:"7",date:"2020-10-23"},
    {item:"Spicy Ghost Pepper Donut",restaurant:"Dunkin'",cost:"$1.00",rating:"8.5",date:"2020-10-18"},
    {item:"Slices-N-Stix",restaurant:"Little Caesars",cost:"$6.00",rating:"8.2",date:"2020-10-11"},
    {item:"J Balvin Meal",restaurant:"McDonald's",cost:"$6.00",rating:"7.5",date:"2020-10-05"},
    {item:"Pretzel Bacon Pub Cheeseburger",restaurant:"Wendy's",cost:"$5.39",rating:"9",date:"2020-10-02"},
    {item:"Grande Stacker",restaurant:"Taco Bell",cost:"$2.49",rating:"4.1",date:"2020-09-29"},
    {item:"Ghost Pepper Wings",restaurant:"Popeyes",cost:"$13.00",rating:"6.8",date:"2020-09-25"},
    {item:"Spicy Chicken Nuggets",restaurant:"McDonald's",cost:"$3.19",rating:"8.8",date:"2020-09-20"},
    {item:"Spicy Chicken Nuggets",restaurant:"Wendy's",cost:"$1.00",rating:"8.6",date:"2020-09-20"},
    {item:"Spicy Chicken Nuggets",restaurant:"Burger King",cost:"$1.00",rating:"8.1",date:"2020-09-20"},
    {item:"Travis Scott Meal",restaurant:"McDonald's",cost:"$6.00",rating:"8.6",date:"2020-09-08"},
    {item:"Grilled Buffalo Chicken Papadia",restaurant:"Papa John's",cost:"$6.00",rating:"7",date:"2020-09-03"},
    {item:"Beef Burrito",restaurant:"Taco Bell",cost:"$1.00",rating:"8",date:"2020-08-29"},
    {item:"Chicken Taco Pizza",restaurant:"Domino's",cost:"$11.99",rating:"9",date:"2020-08-25"},
    {item:"Honey Sesame Chicken",restaurant:"Panda Express",cost:"$7.80",rating:"8.6",date:"2020-08-20"},
    {item:"Spicy Crispy Chicken Sandwich",restaurant:"Wendy's",cost:"$1.29",rating:"8.5",date:"2020-08-15"},
    {item:"Hot Honey Bone-In Chicken",restaurant:"Popeyes",cost:"$5.00",rating:"7",date:"2020-08-09"},
    {item:"Crispy Chicken Taco",restaurant:"Del Taco",cost:"$1.00",rating:"6",date:"2020-08-03"},
    {item:"Beer Battered Fish Sandwich",restaurant:"Arby's",cost:"$5.69",rating:"7",date:"2020-07-30"},
    {item:"Steakhouse King",restaurant:"Burger King",cost:"$6.00",rating:"8.1",date:"2020-07-25"},
    {item:"Hot Buffalo Wings (10 piece)",restaurant:"Domino's",cost:"$7.99",rating:"8.4",date:"2020-07-20"},
    {item:"Secret Recipe Fries",restaurant:"KFC",cost:"$2.49",rating:"6",date:"2020-07-15"},
    {item:"Classic Crust Four Cheese Pizza",restaurant:"Red Baron",cost:"$4.00",rating:"7.7",date:"2020-07-11"},
    {item:"Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$2.99",rating:"8.5",date:"2020-07-06"},
    {item:"Shaq-a-Roni Pizza",restaurant:"Papa John's",cost:"$12.00",rating:"8",date:"2020-07-02"},
    {item:"Croissant Crust Pizza (Pepperoni)",restaurant:"DiGiorno",cost:"-",rating:"4.7",date:"2020-06-21"},
    {item:"Sweet Potato Waffle Fries",restaurant:"Arby's",cost:"$2.29",rating:"5.5",date:"2020-06-17"},
    {item:"Pineapple Whip Freeze",restaurant:"Taco Bell",cost:"$2.89",rating:"5.1",date:"2020-06-13"},
    {item:"Chocolate Chip Cake",restaurant:"KFC",cost:"-",rating:"6.4",date:"2020-06-13"},
    {item:"Stuffed Crazy Bread",restaurant:"Little Caesars",cost:"$3.49",rating:"8.9",date:"2020-06-07"},
    {item:"Buffalo Ranch Tenders",restaurant:"Popeyes",cost:"$5.00",rating:"4.7",date:"2020-06-02"},
    {item:"Cheddar Chicken Ranch Sandwich",restaurant:"Arby's",cost:"$3.99",rating:"5.9",date:"2020-05-27"},
    {item:"Spicy Nuggets (10 piece)",restaurant:"Burger King",cost:"$1.49",rating:"8.1",date:"2020-05-20"},
    {item:"Java Monster Mean Bean",restaurant:"Monster",cost:"$1.99",rating:"7",date:"2020-05-09"},
    {item:"Crispy Specialty Chicken",restaurant:"Domino's",cost:"$5.00",rating:"8",date:"2020-05-03"},
    {item:"Bacon Jalapeno Stuffed Cheesy Bread",restaurant:"Domino's",cost:"$5.00",rating:"8.7",date:"2020-05-03"},
    {item:"Handmade Pan Pizza (Pepperoni)",restaurant:"Domino's",cost:"$7.00",rating:"8.5",date:"2020-05-03"},
    {item:"BBQ Chicken Frozen Pizza",restaurant:"California Pizza Kitchen",cost:"$8.00",rating:"6.8",date:"2020-04-27"},
    {item:"Flamin' Hot Doritos Locos Taco",restaurant:"Taco Bell",cost:"$2.00",rating:"9",date:"2020-04-22"},
    {item:"Pepperoni Cheeser! Cheeser! Pizza",restaurant:"Little Caesars",cost:"$7.00",rating:"7.4",date:"2020-04-14"},
    {item:"Bacon and Cheese Stuffed Crust Pizza",restaurant:"DiGiorno",cost:"$8.00",rating:"6.8",date:"2020-04-09"},
    {item:"Double Big Mac",restaurant:"McDonald's",cost:"$8.60",rating:"9",date:"2020-04-03"},
    {item:"Beef Franks in a Puff Pastry Blanket",restaurant:"Hebrew National",cost:"-",rating:"8.5",date:"2020-03-31"},
    {item:"NightShift Sinus / Cold & Flu",restaurant:"Mucinex",cost:"$12.00",rating:"8.4",date:"2020-03-26"},
    {item:"Deep Dish Singles Pepperoni Pizza",restaurant:"Red Baron",cost:"-",rating:"8.0",date:"2020-03-20"},
    {item:"Big Dipper Pizza",restaurant:"Pizza Hut",cost:"$12.99",rating:"7.7",date:"2020-03-15"},
    {item:"Breakfast Baconator",restaurant:"Wendy's",cost:"$4.00",rating:"6",date:"2020-03-10"},
    {item:"Maple Bacon Chicken Croissant",restaurant:"Wendy's",cost:"$4.00",rating:"4.9",date:"2020-03-10"},
    {item:"Jalapeño Popper Rolls",restaurant:"Papa John's",cost:"$5.99",rating:"5.8",date:"2020-03-06"},
    {item:"Chicken and Donuts Sandwich",restaurant:"KFC",cost:"$5.99",rating:"6.8",date:"2020-02-27"},
    {item:"Buffalo Chicken Nacho Fries",restaurant:"Taco Bell",cost:"$3.00",rating:"8.26",date:"2020-02-24"},
    {item:"Buttermilk Biscuit Shrimp Combo",restaurant:"Popeyes",cost:"$6.00",rating:"9",date:"2020-02-19"},
    {item:"Mozzarella Poppers Pizza",restaurant:"Pizza Hut",cost:"$15.00",rating:"4.1",date:"2020-02-14"},
    {item:"Philly Cheesesteak Papadia",restaurant:"Papa John's",cost:"$8.00",rating:"6.62",date:"2020-02-09"},
    {item:"Coca-Cola Energy",restaurant:"Coca-Cola",cost:"$2.00",rating:"9",date:"2020-02-06"},
    {item:"Cherry Coca-Cola Energy",restaurant:"Coca-Cola",cost:"$2.00",rating:"9",date:"2020-02-06"},
    {item:"Strawberry Jell-O",restaurant:"Jell-O",cost:"-",rating:"7.2",date:"2020-02-01"},
    {item:"Orange Jell-O",restaurant:"Jell-O",cost:"-",rating:"7.2",date:"2020-02-01"},
    {item:"Blue Raspberry Sour Jell-O",restaurant:"Jell-O",cost:"-",rating:"7.2",date:"2020-02-01"},
    {item:"Cheddar Bacon King",restaurant:"Burger King",cost:"$6.49",rating:"7",date:"2020-01-21"},
    {item:"Reaper Ranch Double Stacked Taco",restaurant:"Taco Bell",cost:"$1.00",rating:"8.3",date:"2020-01-10"},
    {item:"Extra Cheesy Alfredo Garlic Parmesan Crust Pizza",restaurant:"Papa John's",cost:"$10.00",rating:"5.8",date:"2020-01-04"},
    {item:"Monster Energy Ultra Paradise",restaurant:"Monster",cost:"$1.99",rating:"8.0",date:"2019-12-30"},
    {item:"Stuffed Crust Pepperoni Pizza",restaurant:"DiGiorno",cost:"-",rating:"5",date:"2019-12-24"},
    {item:"Double Smoked Bacon, Cheddar and Egg Sandwich",restaurant:"Starbucks",cost:"$5.00",rating:"8.8",date:"2019-12-19"},
    {item:"Rolled Chicken Tacos",restaurant:"Taco Bell",cost:"-",rating:"7.3",date:"2019-12-14"},
    {item:"Rising Crust Pizza",restaurant:"Freschetta",cost:"-",rating:"7.5",date:"2019-12-10"},
    {item:"MeatZZa Pizza",restaurant:"Domino's",cost:"$7.00",rating:"7",date:"2019-12-06"},
    {item:"Bacon BBQ Burger",restaurant:"McDonald's",cost:"$5.89",rating:"8.6",date:"2019-12-01"},
    {item:"Snickerdoodle McFlurry (Snack Size)",restaurant:"McDonald's",cost:"$1.89",rating:"6.8",date:"2019-12-01"},
    {item:"Nashville Hot Chicken and Waffle Sandwich",restaurant:"KFC",cost:"$6.44",rating:"1",date:"2019-11-26"},
    {item:"Stuffed Garlic Knots Pizza",restaurant:"Pizza Hut",cost:"$14.99",rating:"5.7",date:"2019-11-22"},
    {item:"Garlic Parmesan Crust Pizza",restaurant:"Papa John's",cost:"$10.00",rating:"6.0",date:"2019-11-13"},
    {item:"Spicy Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$4.99",rating:"4.7",date:"2019-11-04"},
    {item:"Spicy Chicken Sandwich",restaurant:"Popeyes",cost:"-",rating:"9",date:"2019-11-04"},
    {item:"Spicy Chicken Sandwich",restaurant:"Chick-fil-A",cost:"-",rating:"8.2",date:"2019-11-04"},
    {item:"Spicy Chicken Sandwich",restaurant:"Wendy's",cost:"-",rating:"5.6",date:"2019-11-04"},
    {item:"Spicy Chicken Sandwich",restaurant:"Culver's",cost:"-",rating:"3",date:"2019-11-04"},
    {item:"Smoky Sriracha Wings",restaurant:"Pizza Hut",cost:"$7.00",rating:"8.1",date:"2019-11-02"},
    {item:"Double Chalupa",restaurant:"Taco Bell",cost:"$3.49",rating:"3",date:"2019-10-29"},
    {item:"Fried Oreos",restaurant:"Sonic",cost:"$3.00",rating:"5",date:"2019-10-25"},
    {item:"Voodoo Chicken Tenders",restaurant:"Popeyes",cost:"$5.00",rating:"8.5",date:"2019-10-22"},
    {item:"Jack-O'-Lantern Pizza",restaurant:"Papa John's",cost:"$11.00",rating:"4",date:"2019-10-16"},
    {item:"Buffalo Kentucky Fried Wings",restaurant:"KFC",cost:"$5.00",rating:"7.1",date:"2019-10-12"},
    {item:"Nashville Hot Kentucky Fried Wings",restaurant:"KFC",cost:"$5.00",rating:"4.9",date:"2019-10-12"},
    {item:"Honey BBQ Kentucky Fried Wings",restaurant:"KFC",cost:"$5.00",rating:"7.1",date:"2019-10-12"},
    {item:"McRib",restaurant:"McDonald's",cost:"$3.49",rating:"8.6",date:"2019-10-09"},
    {item:"Honey Sesame Chicken Bowl",restaurant:"Panda Express",cost:"$6.67",rating:"8.4",date:"2019-10-06"},
    {item:"Triple Steakburger with Bacon Meal",restaurant:"Steak 'n Shake",cost:"-",rating:"8.3",date:"2019-10-03"},
    {item:"Monster Energy Zero Ultra",restaurant:"7-Eleven",cost:"$3.50",rating:"8",date:"2019-09-29"},
    {item:"Pretzel Bacon King",restaurant:"Burger King",cost:"$6.49",rating:"3",date:"2019-09-24"},
    {item:"Stuffed Cheez-It Pizza (Cheese)",restaurant:"Pizza Hut",cost:"$6.49",rating:"6",date:"2019-09-19"},
    {item:"Stuffed Cheez-It Pizza (Pepperoni)",restaurant:"Pizza Hut",cost:"$6.49",rating:"5.2",date:"2019-09-19"},
    {item:"Spicy BBQ Chicken Sandwich",restaurant:"McDonald's",cost:"$4.26",rating:"7.5",date:"2019-09-17"},
    {item:"Toasted Cheddar Chalupa",restaurant:"Taco Bell",cost:"$2.49",rating:"4.9",date:"2019-09-13"},
    {item:"Mac and Cheese",restaurant:"Chick-fil-A",cost:"$3.50",rating:"7.4",date:"2019-09-06"},
    {item:"Spicy BBQ Glazed Tenders (6pc)",restaurant:"McDonald's",cost:"$7.00",rating:"7.0",date:"2019-09-02"},
    {item:"Quattro Pizza",restaurant:"Little Caesars",cost:"$7.00",rating:"6.2",date:"2019-08-29"},
    {item:"Popeyes Chicken Sandwich",restaurant:"Popeyes",cost:"$4.69",rating:"6.7",date:"2019-08-21"},
    {item:"Chick-fil-A Chicken Sandwich",restaurant:"Chick-fil-A",cost:"$3.55",rating:"7.3",date:"2019-08-21"},
    {item:"Triple Double Crunchwrap",restaurant:"Taco Bell",cost:"$3.49",rating:"7",date:"2019-08-17"},
    {item:"Spicy Chicken Nuggets",restaurant:"Wendy's",cost:"$3.94",rating:"8.6",date:"2019-08-13"},
    {item:"Impossible Whopper",restaurant:"Burger King",cost:"$5.59",rating:"8.2",date:"2019-08-08"},
    {item:"Deluxe Burger",restaurant:"Culver's",cost:"$5.19",rating:"7",date:"2019-07-29"},
    {item:"Wisconsin Cheese Curds",restaurant:"Culver's",cost:"$3.89",rating:"7",date:"2019-07-29"},
    {item:"Cookies and Cream Frozen Custard",restaurant:"Culver's",cost:"$2.49",rating:"6.5",date:"2019-07-29"},
    {item:"Bacon Jalapeno Cheeseburger",restaurant:"Wendy's",cost:"$5.99",rating:"6.1",date:"2019-07-22"},
    {item:"Sichuan Hot Chicken (Original)",restaurant:"Panda Express",cost:"$4.00",rating:"5.4",date:"2019-07-19"},
    {item:"Sichuan Hot Chicken (Extra Spicy)",restaurant:"Panda Express",cost:"$4.00",rating:"5.6",date:"2019-07-19"},
    {item:"Steak Reaper Ranch Fries Supreme",restaurant:"Taco Bell",cost:"$3.79",rating:"5",date:"2019-07-15"},
    {item:"Taco",restaurant:"Burger King",cost:"$1.00",rating:"6.85",date:"2019-07-10"},
    {item:"Cheetos Sandwich Meal",restaurant:"KFC",cost:"$6.79",rating:"8.1",date:"2019-07-02"},
    {item:"Sweet Lightning Mountain Dew",restaurant:"KFC",cost:"-",rating:"4.5",date:"2019-07-02"},
    {item:"Stuffed Crust Extra Most Bestest Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"8.0",date:"2019-06-29"},
    {item:"Rodeo King",restaurant:"Burger King",cost:"$8.00",rating:"8.1",date:"2019-06-18"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$1.30",rating:"7",date:"2019-06-13"},
    {item:"Grand McExtreme Bacon Burger",restaurant:"McDonald's",cost:"$7.24",rating:"3",date:"2019-06-06"},
    {item:"New Pan Pizza",restaurant:"Pizza Hut",cost:"$7.99",rating:"7.0",date:"2019-06-02"},
    {item:"Red Bull Slush (Original)",restaurant:"Sonic",cost:"$3.00",rating:"5",date:"2019-05-24"},
    {item:"Cherry Limeade Red Bull Slush",restaurant:"Sonic",cost:"$3.00",rating:"4",date:"2019-05-24"},
    {item:"Grande Nachos Box",restaurant:"Taco Bell",cost:"$5.00",rating:"5.5",date:"2019-05-19"},
    {item:"Pan Pizza",restaurant:"Domino's",cost:"$8.00",rating:"6.5",date:"2019-05-14"},
    {item:"Ultimate Pepperoni Pizza",restaurant:"Papa John's",cost:"$12.00",rating:"9.7",date:"2019-04-27"},
    {item:"Angry Whopper",restaurant:"Burger King",cost:"$6.20",rating:"9.4",date:"2019-04-15"},
    {item:"BBLT Sandwich",restaurant:"Sonic",cost:"-",rating:"7.1",date:"2019-04-05"},
    {item:"Bacon Wrapped Deep Deep Dish Pizza",restaurant:"Little Caesars",cost:"$12.00",rating:"8.55",date:"2019-04-01"},
    {item:"Bacon Cheesy Tots",restaurant:"Burger King",cost:"$2.20",rating:"2",date:"2019-03-25"},
    {item:"Pepperoni P'Zone",restaurant:"Pizza Hut",cost:"$5.99",rating:"8.0",date:"2019-03-21"},
    {item:"Donut Sticks",restaurant:"McDonald's",cost:"$3.39",rating:"7.7",date:"2019-03-12"},
    {item:"Extra Most Bestest Pizza",restaurant:"Little Caesars",cost:"$6.00",rating:"8.8",date:"2019-03-06"},
    {item:"Steak Rattlesnake Fries Burrito",restaurant:"Taco Bell",cost:"$2.99",rating:"9.1",date:"2019-03-03"},
    {item:"Southern Butterfly Shrimp",restaurant:"Popeyes",cost:"$5.00",rating:"8.3",date:"2019-02-22"},
    {item:"Ultimate Cheesy Crust Pizza",restaurant:"Pizza Hut",cost:"$12.99",rating:"8.0",date:"2019-02-17"},
    {item:"Barbecue Cheeseburger",restaurant:"Wendy's",cost:"$5.50",rating:"9.0",date:"2019-02-12"},
    {item:"Pretzel Crust Pizza",restaurant:"Little Caesars",cost:"$6.00",rating:"6.0",date:"2019-01-30"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$1.49",rating:"9.5",date:"2019-01-26"},
    {item:"Big King XL",restaurant:"Burger King",cost:"$6.50",rating:"8.6",date:"2019-01-19"},
    {item:"Bacon Melt Sonic Signature Slinger",restaurant:"Sonic",cost:"$2.49",rating:"6.5",date:"2019-01-16"},
    {item:"Nashville Hot Extra Crispy Chicken",restaurant:"KFC",cost:"$6.00",rating:"8.0",date:"2019-01-13"},
    {item:"Naked Chicken Chalupa",restaurant:"Taco Bell",cost:"$5.49",rating:"9.0",date:"2019-01-02"},
    {item:"Cheese Sticks",restaurant:"Papa John's",cost:"-",rating:"9.3",date:"2018-12-28"},
    {item:"Peppermint Mocha Frappuccino",restaurant:"Starbucks",cost:"$5.00",rating:"8.6",date:"2018-12-24"},
    {item:"Santa's Belly Donut",restaurant:"Krispy Kreme",cost:"-",rating:"7.2",date:"2018-12-24"},
    {item:"Ugly Sweater Penguin Donut",restaurant:"Krispy Kreme",cost:"-",rating:"6.5",date:"2018-12-24"},
    {item:"Holiday Plaid Donut",restaurant:"Krispy Kreme",cost:"-",rating:"7.5",date:"2018-12-24"},
    {item:"Mushroom & Swiss Burger",restaurant:"McDonald's",cost:"$5.39",rating:"8.0",date:"2018-12-16"},
    {item:"Cini Minis",restaurant:"Burger King",cost:"$1.49",rating:"8.3",date:"2018-12-08"},
    {item:"Bacon Maple Chicken Sandwich",restaurant:"Wendy's",cost:"$5.99",rating:"8.5",date:"2018-12-04"},
    {item:"Rolled Chicken Tacos",restaurant:"Taco Bell",cost:"-",rating:"8.0",date:"2018-11-28"},
    {item:"Mint Chocolate Shake",restaurant:"Arby's",cost:"$2.49",rating:"7.0",date:"2018-11-25"},
    {item:"Buffalo Chicken Sandwich",restaurant:"Arby's",cost:"$5.00",rating:"8.4",date:"2018-11-25"},
    {item:"Holiday Turkey & Stuffing Panini",restaurant:"Starbucks",cost:"$6.25",rating:"8.6",date:"2018-11-21"},
    {item:"Chicken and Waffle Sandwich",restaurant:"KFC",cost:"$5.99",rating:"7",date:"2018-11-18"},
    {item:"Double Cheeseburger Pizza",restaurant:"Papa John's",cost:"$11.77",rating:"7.1",date:"2018-11-14"},
    {item:"McRib",restaurant:"McDonald's",cost:"$3.00",rating:"7.92",date:"2018-11-09"},
    {item:"Thin Crust Pepperoni Pizza",restaurant:"Little Caesars",cost:"$6.42",rating:"8.0",date:"2018-11-05"},
    {item:"Superfood Side (Kale Salad)",restaurant:"Chick-fil-A",cost:"$4.19",rating:"9.0",date:"2018-10-30"},
    {item:"Nightmare King",restaurant:"Burger King",cost:"$6.39",rating:"6.7",date:"2018-10-26"},
    {item:"Caramel Apple Freeze",restaurant:"Taco Bell",cost:"$2.40",rating:"7.4",date:"2018-10-20"},
    {item:"Frozen Fanta Scary Black Cherry Slush",restaurant:"Burger King",cost:"$1.00",rating:"8.8",date:"2018-10-16"},
    {item:"S'Awesome Bacon Classic Double",restaurant:"Wendy's",cost:"$6.49",rating:"5.9",date:"2018-10-10"},
    {item:"Beefy Crunch Burrito Duo",restaurant:"Taco Bell",cost:"$2.00",rating:"8.0",date:"2018-10-04"},
    {item:"Bacon Smokehouse Buttermilk Crispy Chicken Sandwich",restaurant:"McDonald's",cost:"$5.00",rating:"7.2",date:"2018-10-01"},
    {item:"Hot Honey Chicken Tenders",restaurant:"KFC",cost:"$5.49",rating:"7.0",date:"2018-09-27"},
    {item:"Crispy Chicken Tenders",restaurant:"Burger King",cost:"$4.49",rating:"7.5",date:"2018-09-22"},
    {item:"Triple Double Crunchwrap",restaurant:"Taco Bell",cost:"$5.97",rating:"6.5",date:"2018-09-15"},
    {item:"Dave's Single",restaurant:"Wendy's",cost:"$5.00",rating:"8.6",date:"2018-09-12"},
    {item:"Italian Hero Pizza",restaurant:"Papa John's",cost:"$10.00",rating:"7.0",date:"2018-09-08"},
    {item:"Froot Loops Mini Donuts",restaurant:"Hardee's",cost:"$2.34",rating:"8.5",date:"2018-09-01"},
    {item:"Double Cheesy Gordita Crunch",restaurant:"Taco Bell",cost:"$3.49",rating:"5.5",date:"2018-08-27"},
    {item:"Sweet N Spicy Honey BBQ Glazed Tenders",restaurant:"McDonald's",cost:"$4.49",rating:"8.4",date:"2018-08-23"},
    {item:"Jalapeno King Sandwich",restaurant:"Burger King",cost:"$5.69",rating:"6.7",date:"2018-08-20"},
    {item:"Honey Sesame Chicken Breast",restaurant:"Panda Express",cost:"$8.00",rating:"9.8",date:"2018-08-16"},
    {item:"$9 Five Meat Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"7.7",date:"2018-08-11"},
    {item:"BeeBad Energy Drink",restaurant:"-",cost:"$2.00",rating:"8.82",date:"2018-08-09"},
    {item:"Chicken Tenders",restaurant:"Wendy's",cost:"$3.78",rating:"8.2",date:"2018-08-02"},
    {item:"Watermelon Freeze",restaurant:"Taco Bell",cost:"$2.39",rating:"7.0",date:"2018-07-27"},
    {item:"Donut Fries",restaurant:"Dunkin' Donuts",cost:"$2.00",rating:"7.26",date:"2018-07-24"},
    {item:"Cheesy Bites Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"9.17",date:"2018-07-21"},
    {item:"Crispy Chicken Tenders",restaurant:"Sonic",cost:"$5.79",rating:"5.0",date:"2018-07-18"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$1.49",rating:"9.5",date:"2018-07-14"},
    {item:"Buffalo Ranch Crispy Chicken Sandwich",restaurant:"Wendy's",cost:"$1.00",rating:"6.8",date:"2018-07-11"},
    {item:"Bacon Smokehouse Burger",restaurant:"McDonald's",cost:"$5.39",rating:"7",date:"2018-07-05"},
    {item:"American Brewhouse King",restaurant:"Burger King",cost:"$6.00",rating:"5",date:"2018-07-02"},
    {item:"Pickle Fried Chicken Sandwich",restaurant:"KFC",cost:"$4.80",rating:"6.0",date:"2018-06-26"},
    {item:"Classic with Bacon Burger",restaurant:"IHOb",cost:"$9.00",rating:"8.5",date:"2018-06-16"},
    {item:"Pickle Juice Slush",restaurant:"Sonic",cost:"$1.69",rating:"8.3",date:"2018-06-14"},
    {item:"Pretzel Chicken Fries",restaurant:"Burger King",cost:"-",rating:"7",date:"2018-06-09"},
    {item:"Chicken McGriddle",restaurant:"McDonald's",cost:"-",rating:"8.0",date:"2018-06-04"},
    {item:"Rippin' Chicken",restaurant:"Popeyes",cost:"$5.00",rating:"7.5",date:"2018-06-01"},
    {item:"Blueberry Glazed Doughnuts",restaurant:"Krispy Kreme",cost:"$5.00",rating:"6.2",date:"2018-05-23"},
    {item:"Quarter Pounder with Cheese (Fresh Beef)",restaurant:"McDonald's",cost:"$4.00",rating:"8.7",date:"2018-05-19"},
    {item:"Wild Naked Chicken Chalupa",restaurant:"Taco Bell",cost:"$2.99",rating:"8.0",date:"2018-05-14"},
    {item:"Spirit of Aloha Dinner Show",restaurant:"Disney Polynesian Resort",cost:"$70.00",rating:"6",date:"2018-05-05"},
    {item:"Stuffed Crust Pan Pizza",restaurant:"Pizza Hut",cost:"$15.00",rating:"8.0",date:"2018-05-01"},
    {item:"Spicy Chicken Nuggets",restaurant:"Burger King",cost:"$1.69",rating:"8.2",date:"2018-04-22"},
    {item:"Signature Garlic White Cheddar Burger",restaurant:"McDonald's",cost:"$4.59",rating:"2",date:"2018-04-13"},
    {item:"Triple Melt Burrito",restaurant:"Taco Bell",cost:"$1.00",rating:"7.3",date:"2018-04-07"},
    {item:"Crystal Ball Frappuccino",restaurant:"Starbucks",cost:"$5.45",rating:"9.0",date:"2018-03-25"},
    {item:"Apple Strawberry Banana Puree",restaurant:"Gerber",cost:"$0.75",rating:"6.7",date:"2018-03-19"},
    {item:"Extra Most Bestest Stuffed Crust Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"8.5",date:"2018-03-15"},
    {item:"Spicy Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$4.00",rating:"8.8",date:"2018-03-06"},
    {item:"Szechuan Sauce",restaurant:"McDonald's",cost:"-",rating:"9.4",date:"2018-02-26"},
    {item:"Cheesy Tots",restaurant:"Burger King",cost:"$2.00",rating:"1",date:"2018-02-22"},
    {item:"Cherry Mocha",restaurant:"Starbucks",cost:"$4.95",rating:"8.5",date:"2018-02-14"},
    {item:"Build Your Own Veggie Pizza",restaurant:"McDonald's",cost:"$9.00",rating:"9.3",date:"2018-02-06"},
    {item:"Smoky Mountain BBQ Chicken Tenders",restaurant:"KFC",cost:"$5.00",rating:"6.8",date:"2018-01-29"},
    {item:"Nacho Fries",restaurant:"Taco Bell",cost:"$1.00",rating:"9.5",date:"2018-01-25"},
    {item:"Double Quarter Pound King",restaurant:"Burger King",cost:"$5.00",rating:"8.9",date:"2018-01-22"},
    {item:"Strawberry Peach Fruit Fizz",restaurant:"Sonic",cost:"-",rating:"7.0",date:"2018-01-17"},
    {item:"Mango Lime Fruit Fizz",restaurant:"Sonic",cost:"-",rating:"4.3",date:"2018-01-17"},
    {item:"Raspberry Lemon Fruit Fizz",restaurant:"Sonic",cost:"-",rating:"8.5",date:"2018-01-17"},
    {item:"Ghost Pepper Wings",restaurant:"Popeyes",cost:"$4.99",rating:"7.2",date:"2018-01-11"},
    {item:"Bacon McDouble",restaurant:"McDonald's",cost:"$2.00",rating:"6.5",date:"2018-01-06"},
    {item:"Classic Chicken Sandwich",restaurant:"McDonald's",cost:"$3.00",rating:"8.3",date:"2018-01-06"},
    {item:"Stacker",restaurant:"Taco Bell",cost:"$1.00",rating:"8.8",date:"2018-01-02"},
    {item:"Flamin' Hot Mac n' Cheetos",restaurant:"Burger King",cost:"$2.99",rating:"8.6",date:"2017-12-03"},
    {item:"New York Style Pepperoni Pizza",restaurant:"Sbarro",cost:"$4.09",rating:"7.3",date:"2017-11-28"},
    {item:"Ultimate Cheesy Crust Pizza",restaurant:"Pizza Hut",cost:"$12.00",rating:"9.3",date:"2017-11-27"},
    {item:"Rolled Chicken Tacos (4pc)",restaurant:"Taco Bell",cost:"$4.00",rating:"7.3",date:"2017-11-20"},
    {item:"Cheddar and Apple Butter Turkey Slider",restaurant:"White Castle",cost:"$1.00",rating:"9.0",date:"2017-11-15"},
    {item:"Buffalo Chicken Pizza",restaurant:"Domino's",cost:"$13.00",rating:"7.7",date:"2017-11-11"},
    {item:"Chicken Tenders (3pc)",restaurant:"Wendy's",cost:"$3.00",rating:"8.6",date:"2017-10-30"},
    {item:"Zombie Frappuccino",restaurant:"Starbucks",cost:"$5.00",rating:"8.5",date:"2017-10-26"},
    {item:"Mystery Flavor Oreo Cookies",restaurant:"Oreo",cost:"$4.00",rating:"8.4",date:"2017-10-22"},
    {item:"Spicy Chicken Nuggets (10pc)",restaurant:"Burger King",cost:"$1.49",rating:"9.0",date:"2017-10-17"},
    {item:"Crispy Chicken Quesadilla",restaurant:"Taco Bell",cost:"-",rating:"8.7",date:"2017-10-09"},
    {item:"Buttermilk Crispy Tenders (4pc)",restaurant:"McDonald's",cost:"$4.00",rating:"9.2",date:"2017-10-07"},
    {item:"1/4 LB Popcorn Chicken",restaurant:"Popeyes",cost:"$4.00",rating:"9.0",date:"2017-09-26"},
    {item:"Chicken Biscuit",restaurant:"Hardee's",cost:"$1.30",rating:"9.7",date:"2017-09-24"},
    {item:"Backyard BBQ Chicken Pizza",restaurant:"Pizza Hut",cost:"$12.00",rating:"8.95",date:"2017-09-03"},
    {item:"Rodeo King Burger",restaurant:"Burger King",cost:"$6.00",rating:"8.5",date:"2017-08-27"},
    {item:"Cheesy Tots",restaurant:"Burger King",cost:"$2.13",rating:"7.6",date:"2017-08-20"},
    {item:"Hot Honey Crunch Tenders",restaurant:"Popeyes",cost:"$5.00",rating:"8.8",date:"2017-08-17"},
    {item:"Hot Wings",restaurant:"Domino's",cost:"$6.00",rating:"9.2",date:"2017-08-14"},
    {item:"Garlic Parmesan Dunked Chicken Sandwich",restaurant:"Sonic",cost:"$6.49",rating:"5.0",date:"2017-08-09"},
    {item:"Buffalo Chicken Tender Sub",restaurant:"Publix",cost:"$6.00",rating:"9.6",date:"2017-08-07"},
    {item:"Beefy Potato-Rito",restaurant:"Taco Bell",cost:"$1.00",rating:"8.6",date:"2017-07-31"},
    {item:"Signature Sriracha Quarter Pound Burger",restaurant:"McDonald's",cost:"$5.13",rating:"4.2",date:"2017-07-27"},
    {item:"Buffalo Chicken Tenders",restaurant:"Culver's",cost:"$10.64",rating:"9.38",date:"2017-07-25"},
    {item:"Papa's Chicken Poppers",restaurant:"Papa John's",cost:"$6.00",rating:"8.1",date:"2017-07-20"},
    {item:"Original Pretzel Dog",restaurant:"Sonic",cost:"$2.45",rating:"8.0",date:"2017-07-16"},
    {item:"Bacon Queso Cheeseburger",restaurant:"Wendy's",cost:"$5.87",rating:"8.4",date:"2017-07-14"},
    {item:"Triple Thick Brown Sugar Bacon BLT",restaurant:"Arby's",cost:"$5.80",rating:"5.0",date:"2017-07-10"},
    {item:"Parmesan Bread Twists",restaurant:"Domino's",cost:"$5.99",rating:"7.0",date:"2017-07-06"},
    {item:"Cheddar Biscuit Butterfly Shrimp",restaurant:"Popeyes",cost:"$5.00",rating:"4.8",date:"2017-07-05"},
    {item:"BBQ Bacon Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$5.63",rating:"0.5",date:"2017-07-02"},
    {item:"Lucky Charms Shake",restaurant:"Burger King",cost:"$3.31",rating:"6.0",date:"2017-06-28"},
    {item:"Bacon Cheddarburger Pizza",restaurant:"Papa John's",cost:"$10.00",rating:"7.0",date:"2017-06-25"},
    {item:"Double Chalupa",restaurant:"Taco Bell",cost:"$3.79",rating:"8.5",date:"2017-06-22"},
    {item:"Mushroom & Swiss King Burger",restaurant:"Burger King",cost:"$6.59",rating:"3.0",date:"2017-06-21"},
    {item:"Bacon Deluxe Burger",restaurant:"Culver's",cost:"$5.35",rating:"9.4",date:"2017-06-18"},
    {item:"Sweet & Crunchy Chicken Tenders",restaurant:"Popeyes",cost:"$5.35",rating:"5.1",date:"2017-06-15"},
    {item:"Sweet & Crunchy Chicken Tenders with Smokin' Pepper Jam Sauce",restaurant:"Popeyes",cost:"$5.35",rating:"7.5",date:"2017-06-15"},
    {item:"Breakfast Quesadilla",restaurant:"Taco Bell",cost:"$2.34",rating:"9.7",date:"2017-06-08"},
    {item:"Breakfast Salsa",restaurant:"Taco Bell",cost:"-",rating:"9.75",date:"2017-06-08"},
    {item:"Cheesy Bites Pizza",restaurant:"Pizza Hut",cost:"$12.00",rating:"8.9",date:"2017-06-04"},
    {item:"ExtraMostBestest Pizza",restaurant:"Little Caesars",cost:"$6.00",rating:"9.2",date:"2017-06-01"},
    {item:"Maple Bacon Dijon Signature Crafted Chicken Sandwich",restaurant:"McDonald's",cost:"$5.13",rating:"1.0",date:"2017-05-31"},
    {item:"Smokehouse BBQ Bacon Sandwich",restaurant:"Chick-fil-A",cost:"$6.00",rating:"9.7",date:"2017-05-27"},
    {item:"Bacon n' Cheese Triple Xtreme Steakburger",restaurant:"Steak 'n Shake",cost:"$6.00",rating:"9.6",date:"2017-05-21"},
    {item:"Mac n' Cheetos",restaurant:"Burger King",cost:"$2.00",rating:"8.0",date:"2017-05-18"},
    {item:"MunchPak Family Pack",restaurant:"MunchPak",cost:"$40.00",rating:"9.0",date:"2017-05-15"},
    {item:"Naked Chicken Chips",restaurant:"Taco Bell",cost:"$2.45",rating:"8.0",date:"2017-05-12"},
    {item:"Deluxe Chicken Sandwich",restaurant:"Chick-fil-A",cost:"$2.85",rating:"7.2",date:"2017-05-06"},
    {item:"Smokehouse Pork Belly Sandwich",restaurant:"Arby's",cost:"$6.00",rating:"6.5",date:"2017-05-03"},
    {item:"Signature Crafted Sweet BBQ Bacon Burger",restaurant:"McDonald's",cost:"$4.79",rating:"6.5",date:"2017-04-30"},
    {item:"Baby Back Rib Burger",restaurant:"Hardee's",cost:"$5.98",rating:"7.6",date:"2017-04-28"},
    {item:"Froot Loops Shake",restaurant:"Burger King",cost:"$3.09",rating:"9.77",date:"2017-04-25"},
    {item:"Zinger Sandwich",restaurant:"KFC",cost:"$4.00",rating:"8.1",date:"2017-04-22"},
    {item:"Steakhouse King",restaurant:"Burger King",cost:"$5.99",rating:"7.0",date:"2017-04-18"},
    {item:"Fresh Mozzarella Chicken Sandwich",restaurant:"Wendy's",cost:"$5.66",rating:"5.6",date:"2017-04-16"},
    {item:"Joker Mad Energy Drink",restaurant:"Joker",cost:"$2.00",rating:"8.8",date:"2017-04-14"},
    {item:"Hot-N-Ready Classic Pepperoni Pizza",restaurant:"Little Caesars",cost:"$5.00",rating:"8.7",date:"2017-04-12"},
    {item:"Loaded Taco Burrito",restaurant:"Taco Bell",cost:"$1.49",rating:"7.6",date:"2017-04-08"},
    {item:"Honey BBQ Bacon Lil' Chickie",restaurant:"Sonic",cost:"$1.49",rating:"7.3",date:"2017-04-04"},
    {item:"Double Pepperoni Pizza",restaurant:"Papa John's",cost:"$9.00",rating:"9.3",date:"2017-04-02"},
    {item:"Original Hot Wings",restaurant:"Wingstop",cost:"$8.99",rating:"8.6",date:"2017-03-29"},
    {item:"Cheesy Bacon Lil' Doggie",restaurant:"Sonic",cost:"$1.49",rating:"7.0",date:"2017-03-26"},
    {item:"Del Taco Soft Taco",restaurant:"Del Taco",cost:"$1.40",rating:"7.1",date:"2017-03-23"},
    {item:"Five Flavor Shrimp",restaurant:"Panda Express",cost:"$5.00",rating:"8.6",date:"2017-03-20"},
    {item:"St. Patrick's Day Green Original Glazed Doughnut",restaurant:"Krispy Kreme",cost:"$1.09",rating:"9.0",date:"2017-03-17"},
    {item:"Howie Bread",restaurant:"Hungry Howie's",cost:"$3.75",rating:"8.5",date:"2017-03-16"},
    {item:"Premium Cod Fillet Fish Sandwich",restaurant:"Wendy's",cost:"$3.99",rating:"7.0",date:"2017-03-13"},
    {item:"Meat Mountain Sandwich",restaurant:"Arby's",cost:"$10.70",rating:"8.5",date:"2017-03-10"},
    {item:"Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$4.39",rating:"5.5",date:"2017-03-07"},
    {item:"Triple Double Crunchwrap",restaurant:"Taco Bell",cost:"$5.00",rating:"9.0",date:"2017-03-04"},
    {item:"Smokehouse Pizza",restaurant:"Little Caesars",cost:"$9.00",rating:"9.2",date:"2017-03-02"},
    {item:"Pancake on a Stick",restaurant:"Sonic",cost:"$2.13",rating:"7.6",date:"2017-02-28"},
    {item:"Hand-Breaded Spicy Chicken Tenders",restaurant:"Hardee's",cost:"$4.38",rating:"8.3",date:"2017-02-24"},
    {item:"Chicken Biscuit",restaurant:"Chick-fil-A",cost:"$2.80",rating:"9.0",date:"2017-02-22"},
    {item:"Boneless Buffalo Wings",restaurant:"Sonic",cost:"$4.69",rating:"8.8",date:"2017-02-19"},
    {item:"Chicken Tenders Sub",restaurant:"Publix",cost:"$8.00",rating:"9.5",date:"2017-02-16"},
    {item:"Heart-Shaped Pizza",restaurant:"Pizza Hut",cost:"$10.00",rating:"7.1",date:"2017-02-13"},
    {item:"Shamrock Shake",restaurant:"McDonald's",cost:"$2.00",rating:"1.7",date:"2017-02-12"},
    {item:"Jalapeño Chicken Fries",restaurant:"Burger King",cost:"$2.00",rating:"8.5",date:"2017-02-09"},
    {item:"Bacon Ranch Fries",restaurant:"Wendy's",cost:"$2.00",rating:"8.26",date:"2017-02-06"},
    {item:"Ultimate Meats Pizza",restaurant:"Papa John's",cost:"$11.77",rating:"8.7",date:"2017-02-03"},
    {item:"Georgia Gold Chicken",restaurant:"KFC",cost:"$5.25",rating:"7.5",date:"2017-01-31"},
    {item:"McChicken Biscuit",restaurant:"McDonald's",cost:"$1.49",rating:"6.1",date:"2017-01-27"},
    {item:"Naked Chicken Chalupa",restaurant:"Taco Bell",cost:"$3.60",rating:"7.49",date:"2017-01-27"},
    {item:"Jalapeño McChicken Sandwich",restaurant:"McDonald's",cost:"$1.79",rating:"6.6",date:"2017-01-22"},
    {item:"BBQ Bacon King",restaurant:"Burger King",cost:"$6.00",rating:"2.6",date:"2017-01-19"},
    {item:"Roadhouse Baconzilla",restaurant:"Checkers",cost:"$5.00",rating:"7.3",date:"2017-01-17"},
    {item:"McCafé Coffee",restaurant:"McDonald's",cost:"$1.00",rating:"8.6",date:"2017-01-15"},
    {item:"BK Joe Coffee",restaurant:"Burger King",cost:"$1.00",rating:"7.6",date:"2017-01-15"},
    {item:"Firecracker Chicken Breast",restaurant:"Panda Express",cost:"$6.00",rating:"7.9",date:"2017-01-12"},
    {item:"Loaded Cinnamon Crazy Bites",restaurant:"Little Caesars",cost:"$5.00",rating:"8.8",date:"2017-01-09"},
    {item:"Nacho Crunch Double Stacked Taco",restaurant:"Taco Bell",cost:"$1.00",rating:"7.0",date:"2017-01-06"},
    {item:"Chicken McGriddle",restaurant:"McDonald's",cost:"$1.49",rating:"6.7",date:"2017-01-04"},
    {item:"Spicy Sweet Double Stacked Taco",restaurant:"Taco Bell",cost:"$1.00",rating:"7.5",date:"2017-01-03"},
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
  const periodColor = { domain: [EARLY, RECENT], range: ['#3b4cc0', '#b40426'] };

  const yearColor = { type: 'linear', scheme: 'turbo', label: 'Review year', tickFormat: 'd' };

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
        Plot.line(rolling, { x: 'date', y: 'avg', stroke: '#222', strokeWidth: 2 }),
        Plot.ruleY([overallMean], { stroke: '#888', strokeDasharray: '4 4' }),
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
        Plot.ruleX(yearStats, { x: 'year', y1: 'sdLo', y2: 'sdHi', stroke: '#333', strokeWidth: 1.2 }),
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
        Plot.linearRegressionY(priceData, { x: 'date', y: 'price', stroke: '#222', strokeWidth: 1.5, ci: 0.95 }),
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
        Plot.frame({ stroke: '#e0e0e0' }),
        Plot.dot(facetData, { fy: 'restaurant', x: 'date', y: 'rating', fill: 'year', r: 2.2, fillOpacity: 0.6, stroke: 'none' }),
        Plot.linearRegressionY(facetData, { fy: 'restaurant', x: 'date', y: 'rating', stroke: '#222', strokeWidth: 1.5, ci: 0.95, fillOpacity: 0.12 }),
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
        Plot.frame({ stroke: '#e0e0e0' }),
        Plot.line(chainYear, { fy: 'restaurant', x: 'year', y: 'mean', stroke: '#bbb', strokeWidth: 1.5 }),
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
        Plot.ruleX([overallMean], { stroke: '#888', strokeDasharray: '4 4' }),
        Plot.link(chainEarlyLate, { y: 'restaurant', x1: 'earlyMean', x2: 'recentMean', stroke: '#ddd', strokeWidth: 2 }),
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
  .sortable-table { width: 100%; border-collapse: collapse; font-size: 0.9em; }
  .sortable-table th, .sortable-table td { padding: 6px 10px; border: 1px solid #ddd; text-align: left; }
  .sortable-table th { cursor: pointer; user-select: none; background: #f5f5f5; white-space: nowrap; }
  .sortable-table th:hover { background: #e8e8e8; }
  .sortable-table tr:nth-child(even) { background: #fafafa; }
  .rating-count { margin-bottom: 1em; font-style: italic; color: #666; }
  .plot-container { margin: 1em 0 0.25em; overflow-x: auto; max-width: 100%; }
  .plot-container :global(svg) { display: block; height: auto; }
  .plot-container :global(figure) { margin: 0; }
  .plot-caption { font-size: 0.85em; color: #666; margin: 0 0 1.5em; font-style: italic; }
</style>

# Getting Every ReviewBrah Rating Using LLMs

## "Hello Everyone!"

A phrase that echoes throughout my house on weekly basis from my favorite YouTuber, ReviewBrah.

<p class="rating-count">{plotData.length} ratings analyzed | Last updated: May 2026</p>

## A Decade of Ratings

Across {plotData.length} ratings spanning 2017–2026, the scores drift down and spread out year over year — ReviewBrah's early reviews clustered high and tight, while recent years swing between glowing and scathing as the industry leaned into stunt menus and brand collabs. Every chart below is colored along a single 2017→2026 ramp so the year is readable everywhere.

## Ratings Over Time

<div class="plot-container" bind:this={timelineEl}></div>

<p class="plot-caption">Every review as a dot, colored by year; black line is the 15-review rolling average, dashed line the all-time mean ({overallMean.toFixed(2)}). Hover any point for the item, chain, date and score.</p>

## Distribution by Year

<div class="plot-container" bind:this={yearEl}></div>

<p class="plot-caption">Canonical box plot per year: box = interquartile range, line = median, whiskers = 1.5×IQR, dots = outliers. Boxes stay short and high through 2021, then stretch year after year. Hover a year for n, mean, median and SD.</p>

## Spread by Year

<div class="plot-container" bind:this={spreadEl}></div>

<p class="plot-caption">Standard deviation of each year's ratings — how far a typical review swings from that year's average. Black whiskers are 95% confidence intervals on the SD estimate (wider for smaller-n years like 2026). It roughly doubles from ~1.4 in the early years to ~3 by 2025–26. Hover a year for the exact SD, CI, mean and n.</p>

## By Chain

<div class="plot-container" bind:this={chainsEl}></div>

<p class="plot-caption">One panel per chain with ≥15 reviews ({topChains.length} chains, ordered by review count). Dots are individual reviews colored by year; each black line is a least-squares trend with a shaded 95% confidence band — a wide band means the slope is weakly determined. Caveat: all panels share one global time axis, so a chain reviewed mostly in later (lower-rated) years can show a downward slope even if its own quality held steady. Hover any point for details.</p>

## Yearly Average by Chain

<div class="plot-container" bind:this={eraEl}></div>

<p class="plot-caption">Each chain's mean rating per year, connected into a trajectory; dots colored by year. Same {topChains.length} chains, ordered with the steepest early→late decline at top. Hover a dot for the exact yearly mean and sample size.</p>

## Who Soured the Most

<div class="plot-container" bind:this={souredEl}></div>

<p class="plot-caption">The trajectory above shows the shape; this is the verdict. Each chain's mean rating early (2017–2021, blue) vs recent (2022–2026, red); dot size ∝ number of reviews and the faint colored whiskers are 95% confidence intervals on each mean. Read the ranking with that uncertainty in mind — a big swing on a small dot with wide whiskers is weak evidence. Sorted by biggest drop at top; dashed line is the all-time mean ({overallMean.toFixed(2)}). Hover a dot for mean, n and CI.</p>

## Price Over Time

<div class="plot-container" bind:this={priceEl}></div>

<p class="plot-caption">Every priced review ({priceData.length} with a parseable dollar amount, ≤ $30) plotted by date, colored by year. The black line is a least-squares fit with a 95% confidence band. The upward slope is real (it tracks known fast-food CPI), but treat the band as a lower bound on uncertainty: prices were parsed from messy free-text ("~$22", "$6–$8", "Included") and the ≤ $30 filter drops combo/range outliers, so true uncertainty is wider than shown. Hover any point for the item, chain, date and price.</p>

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
        <td>{r.item}</td>
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
