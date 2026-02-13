<script>
  let sortCol = $state('date');
  let sortAsc = $state(false);

  const ratings = [
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
    {item:"Burger with bacon",restaurant:"Culver's",cost:"N/A",rating:"1/5",date:"2023-11-04"},
    {item:"Fried Mac and Cheese Bites",restaurant:"Arby's",cost:"$4.50 - $5.00",rating:"4",date:"2023-11-02"},
    {item:"Roasted Garlic Cheese Sticks",restaurant:"Pizza Hut",cost:"$14.00",rating:"7.7",date:"2023-10-27"},
    {item:"Spicy Truff Chicken Sandwich",restaurant:"Popeyes",cost:"$8.00",rating:"4",date:"2023-10-24"},
    {item:"KFC Jamal Murray Meal",restaurant:"KFC",cost:"$11.00",rating:"6.4",date:"2023-10-21"},
    {item:"Steak and Bacon Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$7.00",rating:"8.2",date:"2023-10-16"},
    {item:"Ghost Pepper Whopper",restaurant:"Burger King",cost:"$8.40",rating:"8.1",date:"2023-10-13"},
    {item:"Ghost Pepper Chicken Fries",restaurant:"Burger King",cost:"$5.00",rating:"3.0",date:"2023-10-13"},
    {item:"Pepperoni Stuffed Cheesy Bread",restaurant:"Domino's",cost:"$7.00",rating:"7",date:"2023-10-06"},
    {item:"Honey Mustard BK Royal Crispy Chicken Sandwich",restaurant:"Burger King",cost:"$8.00",rating:"2",date:"2023-09-30"},
    {item:"Cheeseburger",restaurant:"Joe's Diner",cost:"$12.99",rating:"4.5",date:"2023-09-26"},
    {item:"Pepperoni Pizza",restaurant:"Pizza Palace",cost:"$15.00",rating:"4.0",date:"2023-09-25"},
    {item:"Caesar Salad",restaurant:"Healthy Greens",cost:"$10.50",rating:"5.0",date:"2023-09-24"},
    {item:"Chicken Enchilada Burrito",restaurant:"Taco Bell",cost:"$2.00",rating:"3",date:"2023-09-24"},
    {item:"Chicken Tikka",restaurant:"Curry House",cost:"$14.99",rating:"4.8",date:"2023-09-23"},
    {item:"Sushi Platter",restaurant:"Tokyo Sushi",cost:"$25.00",rating:"4.9",date:"2023-09-22"},
    {item:"Spaghetti Bolognese",restaurant:"Italian Bistro",cost:"$18.00",rating:"4.4",date:"2023-09-21"},
    {item:"Tacos",restaurant:"Taco Time",cost:"$10.00",rating:"4.2",date:"2023-09-20"},
    {item:"Steak Frites",restaurant:"Grill House",cost:"$22.50",rating:"4.7",date:"2023-09-19"},
    {item:"Chocolate Cake",restaurant:"Sweet Tooth Bakery",cost:"$5.50",rating:"4.6",date:"2023-09-18"},
    {item:"Big Game Burger",restaurant:"Arby's",cost:"$9.00",rating:"7.1",date:"2023-09-18"},
    {item:"Pad Thai",restaurant:"Bangkok Cuisine",cost:"$13.50",rating:"4.3",date:"2023-09-17"},
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
    {item:"Cheeseburger with Barbecue Sauce",restaurant:"McDonald's",cost:"$18.00",rating:"6.5",date:"2023-02-16"},
    {item:"Quarter Pounder with Cheese",restaurant:"McDonald's",cost:"$18.00",rating:"6.5",date:"2023-02-16"},
    {item:"Large Fries",restaurant:"McDonald's",cost:"$18.00",rating:"6.5",date:"2023-02-16"},
    {item:"Apple Pie",restaurant:"McDonald's",cost:"$18.00",rating:"6.5",date:"2023-02-16"},
    {item:"Large Coke",restaurant:"McDonald's",cost:"$18.00",rating:"6.5",date:"2023-02-16"},
    {item:"High C Orange",restaurant:"McDonald's",cost:"$18.00",rating:"6.5",date:"2023-02-16"},
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
    {item:"New York Style Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"7.7",date:"2021-12-27"},
    {item:"Spicy Tender Sandwich",restaurant:"PDQ",cost:"$7.25",rating:"5.7",date:"2021-12-22"},
    {item:"Small Fries",restaurant:"Wendy's",cost:"$1.69",rating:"7.7",date:"2021-12-10"},
    {item:"Medium Fries",restaurant:"McDonald's",cost:"$3.19",rating:"7.9",date:"2021-12-10"},
    {item:"Cheetos Boneless Wings",restaurant:"Applebee's",cost:"$11.99",rating:"6.5",date:"2021-11-27"},
    {item:"Italian Original Chicken Sandwich",restaurant:"Burger King",cost:"$7.00",rating:"2",date:"2021-11-23"},
    {item:"McRib",restaurant:"McDonald's",cost:"$3.00 - $5.00",rating:"5",date:"2021-11-05"},
    {item:"Grilled Cheese Burrito",restaurant:"Taco Bell",cost:"$6.00",rating:"7.75",date:"2021-11-01"},
    {item:"Triple Bacon Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"8.2",date:"2021-10-27"},
    {item:"Ghost Pepper Chicken Nuggets",restaurant:"Burger King",cost:"$1.49 (8 pcs)",rating:"5.4",date:"2021-10-13"},
    {item:"Cantina Crispy Melt Taco",restaurant:"Taco Bell",cost:"$2.19",rating:"7.7",date:"2021-10-08"},
    {item:"Detroit Style Pizza",restaurant:"Pizza Hut",cost:"$13.00",rating:"9",date:"2021-09-15"},
    {item:"Big Bacon Cheddar Cheeseburger",restaurant:"Wendy's",cost:"$7.00",rating:"7.8",date:"2021-09-09"},
    {item:"Crispy Chicken Sandwich Taco",restaurant:"Taco Bell",cost:"$2.49",rating:"5.5",date:"2021-09-04"},
    {item:"Chakaroni Pizza",restaurant:"Papa John's",cost:"$13.00",rating:"8",date:"2021-09-01"},
    {item:"Loaded Taco Fries Burrito",restaurant:"Taco Bell",cost:"$3.00",rating:"6",date:"2021-08-26"},
    {item:"Crazy Calzone Pepperoni",restaurant:"Little Caesars",cost:"$8.50",rating:"7.4",date:"2021-08-19"},
    {item:"Big Dinner Box",restaurant:"Pizza Hut",cost:"$23.00",rating:"8.3",date:"2021-08-14"}
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
</script>

<style>
  .sortable-table { width: 100%; border-collapse: collapse; font-size: 0.9em; }
  .sortable-table th, .sortable-table td { padding: 6px 10px; border: 1px solid #ddd; text-align: left; }
  .sortable-table th { cursor: pointer; user-select: none; background: #f5f5f5; white-space: nowrap; }
  .sortable-table th:hover { background: #e8e8e8; }
  .sortable-table tr:nth-child(even) { background: #fafafa; }
  .rating-count { margin-bottom: 1em; font-style: italic; color: #666; }
</style>

# Getting Every ReviewBrah Rating Using LLMs

## "Hello Everyone!"

A phrase that echoes throughout my house on weekly basis from my favorite YouTuber, ReviewBrah.

<p class="rating-count">{ratings.length} ratings tracked | Last updated: February 2026</p>

## 2025 Year in Review

Chick-fil-A dominated with the year's highest score, a **9.9** for the Pretzel Cheddar Club Sandwich, while Burger King hit rock bottom with the SpongeBob Crabby Whopper at **0.2**. The McRib returned to a 9.2, Taco Bell's Birthday Cake Churros surprised at 9.1, and Chili's Big QP Burger made the case that sit-down restaurants are now the better value play. On the other end, Chick-fil-A's reformulated fries earned a devastating 1.0, Domino's Hot Buffalo Loaded Chicken got compared to dog food, and every Mike's Hot Honey collaboration was terrible. Recurring themes: rising prices, missing ingredients, and an industry chasing brand deals over quality.

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
