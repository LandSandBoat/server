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
tpz = tpz or {}
tpz.magian = tpz.magian or {}

function onTrade(player,npc,trade)
  tpz.magian.magianOrangeOnTrade(player,npc,trade)
end

function onTrigger(player,npc)
  tpz.magian.magianOrangeOnTrigger(player,npc)
end

function onEventUpdate(player,csid,option)
  tpz.magian.magianOrangeEventUpdate(player,itemId,csid,option)
end

function onEventFinish(player,csid,option)
  tpz.magian.magianOrangeOnEventFinish(player,itemId,csid,option)
end
