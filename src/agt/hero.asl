// Rules
//Hero is at the position of agent P (variable), if agent P's position is identical to Hero's position 
at(P) :- pos(P,X,Y) & pos(hero,X,Y).

// Initial goal */
!started.

 // Plans

 // Starting plan*/
+!started 
   :true
   <- .print("I'm not scared of that smelly Goblin!").
      !search_items(slots). 


// Search for items:

// In the event that the hero is searching
// And it has the three items
// Find the goblin
+!search_items(slots) : hero(coin) & hero(gem) & hero(vase) 
   <- .print("I have all items! Looking for the goblin now.");
    !find_goblin.

// In the event that the hero is searching
// And it is at last position (7,7)
// Check last position
+!search_items(slots) : pos(hero,7,7)
  <- !check_last_position.

// In the event that the hero is searching
// And there is an item (gem, coin or vase)
// Ensure pick the item
+!search_items(slots) : gem(hero) 
 <- .print("Found gem!");
       !ensurePick(gem).

+!search_items(slots) : coin(hero) 
 <- .print("Found coin!");
      !ensurePick(coin).

+!search_items(slots) : vase(hero) 
 <- .print("Found vase!");
      !ensurePick(vase).

// In the event that the hero is searching
// And is not at the last position
// Keep searching
+!search_items(slots)
 <-  next(slot);
       !search_items(slots).

// Check last position: 

// In the event that the hero is checking the last position
// And there is an item
// Count the items

// There is a gem
+!check_last_position : gem(hero)
   <- pick(gem);
      !count_items.

// There is a coin
+!check_last_position : coin(hero)
   <- pick(coin);
      !count_items.

// There is a vase
+!check_last_position : vase(hero)
   <- pick(vase);
      !count_items.

+!check_last_position
   <- .print("We didn’t find all the items. Leaving the forest...").

// Ensure pick items:

// In the event that the hero want to pick an item
// And it does not have that item
// Pick the item
// Keep searching
 +!ensurePick(Item) : not hero(Item)
   <-  pick(Item);
   !search_items(slots).

// In the event that the hero want to pick an item
// And already has that item
// Move to next slot
// Keep searching
 +!ensurePick(Item) : hero(Item)
    <- .print("We don't need this item!");
        next(slot);
       !search_items(slots).
   
// Count items in the event that the hero is at the last position (7,7):

// In the event the hero is counting the items
// And it has them all 
// Find the goblin
+!count_items: hero(coin) & hero(gem) & hero(vase)
 <- .print("We have all the items!");
 !find_goblin.

// In the event the hero is counting the items
// And it does't have them all 
// Leave the forest
 +!count_items: true
  <- .print("We did't find all the items. Leaving the forest...").

// Find goblin:

// In the event the hero is finding the gobling
// And it is at the same position
// Drop the items
+!find_goblin : at(goblin) <-
    .print("Found the goblin! Dropping items...");
    !drop_items.

// In the event the hero is finding the gobling
// And it is not at the same position
// Move towards the goblin's position
+!find_goblin : pos(goblin,GX,GY) <-
    .print("Moving towards goblin at position", X, ",", Y);
    move_towards(GX,GY);
    !find_goblin.

// Drop items to at the goblin:

// In the event the hero is dropiing the items
// Under all circunstances
// Drop all the items 
// Leave the forest
+!drop_items : true <-
    .print("Dropping the items");
    !drop_gem;
    !drop_coin;
    !drop_vase;
    .print("All items dropped!");
    !leave_forest.

// Drop gem
+!drop_gem : hero(gem) <-
    .print("Dropping gem");
    drop(gem).

// Drop coin
+!drop_coin : hero(coin) <-
    .print("Dropping coin");
    drop(coin).

// Drop vase
+!drop_vase : hero(vase) <-
    .print("Dropping vase");
    drop(vase).

// In the event the is leaving the forest
// And it is at last position (7,7)
// Print leaving the forest
+!leave_forest : pos(hero,7,7)
  <-  .print("Leaving the forest...").

// In the event the is leaving the forest
// And it is not at last position (7,7)
// Move towards 7,7
// Leave the forest
+!leave_forest : true
   <- move_towards(7,7);
   !leave_forest;
   .print("Moving towads the exit...");.

// Plan to deal with teleporter:

// Initial beliefs */
// last_known_x_position(0,0).

// Plan */
// : pos(hero, X) & last_known_x_position(LastX, _) & X == LastX + 1
//
// +!update_last_position 
//    : pos(hero, X, Y) 
//    <- ?last_known_x_position(OldX,OldY);    // Query current last known position
//       -last_known_x_position(OldX,OldY);    // Remove old belief
//       +last_known_x_position(X,Y);          // Add new belief

// Plan excecution:
// Hero is at initial_position (pos(hero,0,0) ? keep going : 
// check if pos(hero,x)  ==  last_known_x_position + 1 ?
// !update_last_x_position and keep going : 
//  update last position to last position + 1 and move to last position + 2 (to avoid teleporter again)


