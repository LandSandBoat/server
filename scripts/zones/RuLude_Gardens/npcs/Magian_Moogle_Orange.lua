-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Orange Bobble)
-- Type: Magian Trials NPC (Weapon/Empyrean Armor)
-- !pos -11 2.453 118 64
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/magiantrials")
-----------------------------------

function onTrade(player,npc,trade)
  magianOrangeOnTrade(player,npc,trade)
end

function onTrigger(player,npc)
  magianOrangeOnTrigger(player,npc)
end

function onEventUpdate(player,csid,option)
  magianOrangeEventUpdate(player,itemId,csid,option)
end

function onEventFinish(player,csid,option)
  magianOrangeOnEventFinish(player,itemId,csid,option)
end
