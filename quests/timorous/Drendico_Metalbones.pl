# Necromancer Epic NPC -- Drendico_Metalbones
# items: 18086, 1278, 20656, 20655, 20653
sub EVENT_SAY {

    quest::emote("turns to you in amazement. 'You actually did it! These are the correct components! Kazen will be most pleased. I searched the planes for almost a year and could not find all the correct components.' Drendico fiddles with the components, puts them into a box and hands it to you. 'You must have access to an army, $name. Return the components to Kazen quickly!");
  }
  plugin::return_items(\%itemcount);