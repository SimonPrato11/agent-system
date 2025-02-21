//STUDENT NAME:
//STUDENT ID:


/*  Rules */
//Hero is at the position of agent P (variable), if agent P's position is identical to Hero's position 
at(P) :- pos(P,X,Y) & pos(hero,X,Y).

/*  Initial beliefs */
visited(0,0).

/*  Initial goal */
!started.

/* Plans */

// In the event that the agent started
// Under all circumstances
// Start searching
+!started 
   :true
   <- .print("I'm not scared of that smelly Goblin!").
      !search_items(slots). 

// In the event that the agent is searching
// And have all the three items
// Find the goblin
+!search_items(slots) : hero(coin) & hero(gem) & hero(vase) <-
    .print("I have all items! Looking for the goblin now.");
    !find_goblin.

// In the event that the agent is searching
// And there is an item (gem, coin or vase)
// Pick the item
+!search_items(slots) : gem(hero) 
 <- .print("Found gem!");
       !ensurePick(gem).

+!search_items(slots) : coin(hero) 
 <- .print("Found coin!");
      !ensurePick(coin).

+!search_items(slots) : vase(hero) 
 <- .print("Found vase!");
      !ensurePick(vase).

// In the event that the agent is searching
// And is not at the end of the forest
// Keep searching
+!search_items(slots) : not pos(hero,7,7)
 <-  next(slot);
       !search_items(slots).

// In the event that the agent is searching
// And is at the end of the forest and there is an item
// Count items
+!search_items(slots) : pos(hero,7,7) & hero(gem)
      <- pick(gem);
!count_items.

+!search_items(slots) : pos(hero,7,7) & hero(coin)
   <- pick(coin);
 !count_items.

+!search_items(slots) : pos(hero,7,7) & hero(vase)
  <- pick(vase);
 !count_items.
       
// In the event that the agent is searching
// And is at the end of the forest
//Leave the forest
+!search_items(slots) : pos(hero,7,7)
 <- .print("We did't find all the items. Leaving the forest...").

 //In the event that I want to pick an item
 // And don't have that item
 // Pick it and keep searching
 +!ensurePick(Item) : not hero(Item)
   <-  pick(Item);
   !ensurePick(Item);
   !search_items(slots).

+!ensurePick(_).

// In the event that is counting the items
// And have them all 
// Find the goblin
+!count_items: hero(coin) & hero(gem) & hero(vase)
 <- .print("We have all thge items!");
 !find_goblin.

// In the event that is counting the items
// And don't have them all 
// Leave the forest
 +!count_items: true
  <- .print("We did't find all the items. Leaving the forest...").


// Find the goblin
// Drop the items if at goblin's 
// Keep moving if not
+!find_goblin : at(goblin) <-
    .print("Found the goblin! Dropping items...");
    !drop_items.

+!find_goblin : pos(goblin,GX,GY) <-
    .print("Moving towards goblin at position", X, ",", Y);
    move_towards(GX,GY);
    !find_goblin.

// Drop the items at at goblin's location
+!drop_items : true <-
    .print("Dropping the items");
    !drop_gem;
    !drop_coin;
    !drop_vase;
    move_towards(7,7);
    .print("All items dropped. Leaving the forest!").

// Plan to drop gem
+!drop_gem : hero(gem) <-
    .print("Dropping gem");
    drop(gem).

// Plan to drop coin
+!drop_coin : hero(coin) <-
    .print("Dropping coin");
    drop(coin).

// Plan to drop vase
+!drop_vase : hero(vase) <-
    .print("Dropping vase");
    drop(vase).
