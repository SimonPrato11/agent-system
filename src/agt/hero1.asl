//STUDENT NAME: Simon Prato
//STUDENT ID: 200052101

// Hero is at the position of agent P (variable), if agent P's position is identical to Hero's position
at(P) :- pos(P,X,Y) & pos(hero,X,Y).

// Initial beliefs
visited(0,0).

// Initial goal
!started.

/* 
 * In the event that the agent must achieve "started", under all circumstances, print the message
 */
+!started : true <- 
    .print("I'm not scared of that smelly Goblin!");
    !collect_items.


// HERE
// Plan to collect all required items and find goblin
+!collect_items : hero(coin) & hero(gem) & hero(vase) <-
    .print("I have all items! Looking for the goblin now.");
    !find_goblin.

// If we don't have all items, continue searching
+!collect_items : true <-
    !explore;
    !collect_items.

// // End of the grid and no values:
// +!explore : pos(hero,7,7)
//  <- .print("Done! We don't have all the items").

// Explore the forest systematically
+!explore : not pos(hero,7,7) <-
    next(slot);
    ?pos(hero,X,Y);
    +visited(X,Y).

// Pickup gem if we find one and don't already have one
+gem(hero) : not hero(gem) <-
    .print("I found a gem!");
    pick(gem).

// Pickup coin if we find one and don't already have one
+coin(hero) : not hero(coin) <-
    .print("I found a coin!");
    pick(coin).

// Pickup vase if we find one and don't already have one
+vase(hero) : not hero(vase) <-
    .print("I found a vase!");
    pick(vase).

// Find the goblin after collecting all items
+!find_goblin : at(goblin) <-
    .print("Found the goblin! Dropping items...");
    !drop_all_items.

// If not at goblin's position, move towards the goblin
+!find_goblin : hero(coin) & hero(gem) & hero(vase) & pos(goblin,GX,GY) <-
    .print("Moving towards goblin at position ", GX, ",", GY);
    move_towards(GX,GY);
    !find_goblin.

// Drop all collected items at goblin's location
+!drop_all_items : true <-
    .print("Dropping all items for the goblin");
    !drop_gem;
    !drop_coin;
    !drop_vase;
    .print("All items dropped. Task completed!").

// Plan to drop gem
+!drop_gem : hero(gem) <-
    .print("Dropping gem");
    drop(gem).
+!drop_gem : true <- true.

// Plan to drop coin
+!drop_coin : hero(coin) <-
    .print("Dropping coin");
    drop(coin).
+!drop_coin : true <- true.

// Plan to drop vase
+!drop_vase : hero(vase) <-
    .print("Dropping vase");
    drop(vase).
+!drop_vase : true <- true.

// // Handle teleportation by updating position
// +pos(hero,X,Y) : true <-
//     +visited(X,Y).

// Failure handling - if any subgoal fails, continue exploring
// -!collect_items : true <- 
//     .print("Collection failed, continuing exploration");
//     !explore; 
//     !collect_items.

// -!find_goblin : true <- 
//     .print("Finding goblin failed, retrying");
//     !find_goblin.