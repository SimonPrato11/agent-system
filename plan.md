Goal:
Grodor the Goblin has stolen some of your items. In order for him to return them, he has sent you on a quest to search the forest and collect particular items of great value to him: a coin, a vase, and a gem.
You need to collect these items, and then return to Grodor the Goblin and give them to him.

Required functionalitty:
The hero agent is to move through the environment in a systematic way. It should collect one (1) vase, one (1) coin, and one (1) gem. Upon collecting these items, it should then move to where the goblin is, and drop the items at the goblin. If it does not find all three times, then it should not visit the goblin.

A rule has been placed in ~/agt/hero.asl for you. This rule is at(P). This rule will state whether it is true that the Hero agent is in the same position as the agent named in the parameter P. For example, if there is an agent named “philby” within the system, then adding the achievement goal !at(philby) will instruct the hero agent to achieve the state of affairs where it is at the same position in the grid as the agent “philby”. If you wish to use this rule, you must define and implement an applicable plan.

The Goblin agent
The goblin agent (given for you in ~/agt/goblin.asl) is waiting in his given position (this is defined by the environment), and he will stash an item that is dropped in his location, should it be a coin, gem, or vase.

The enviremonent
The forest environment consists of an 8x8 grid, each square representing the location within the forest. Within several squares of the forest, there will be items that the Hero Agent can choose to pick up, if so desired. There may be a teleporter present (this is a square labelled as T) in the environment which teleports the hero to a different spot in the forest.

Percepts
pos(hero, x, y) The hero agent is at the position (x,y)
pos(goblin, x, y) The goblin agent is at the position (x,y)

gem(hero) The hero is at a position that contains a gem
coin(hero) The hero is at a position that contains a coin
vase(hero) The hero is at a position that contains a vase

gem(goblin) The goblin is at a position that contains a gem
coin(goblin) The goblin is at a position that contains a coin
vase(goblin) The goblin is at a position that contains a vase

hero(coin)The hero is currently holding a coin
hero(vase)The hero is currently holding a vase
hero(gem)The hero is currently holding a gem

Actions:
next(slot) The hero will advance its position to the next one in the forest. This is on a left-to-right, top-to-bottom sequence. Once the hero agent reaches the final position of the forest, it will advance to the start position (in a wrap-around fashion).

move towards(x,y) The hero will move one step towards the location stated.

pick(coin) Hero will pick up the coin object in the current position, if there is one.
drop(coin) Hero will drop the coin object, should they have one, in the current position.

pick(gem) Hero will pick up the gem object in the current position, if there is one.
drop(gem) Hero will drop the gem object, should they have one, in the current position. The hero will then advance to the next position.

pick(vase) Hero will pick up the vase object in the current position, if there is one.
drop(vase) Hero will drop the vase object, should they have one, in the current position. The hero will then advance to the next position.

Tips:
Your hero agent should do as is described above. A basic implementation would be expected to collect the three items (if present) and drop them at the goblin.

More advanced implementations would deal with the teleporter and deal with multiple objects. It is important that the agent acts rationally in all situations, so consider carefully how you make your agent behave in different situations – use your understanding of what it means for an agent to be rational in its actions and allow this to inform your agent's actions.
