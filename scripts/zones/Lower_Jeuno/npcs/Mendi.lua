-----------------------------------
-- Area: Lower Jeuno
--  NPC: Mendi
-- Reputation NPC
-- !pos -55 5 -68 245
-----------------------------------
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(82, player:getFame(JEUNO))
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
