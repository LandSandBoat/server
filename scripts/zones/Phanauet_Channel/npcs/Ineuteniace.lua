-----------------------------------
-- Area: Phanauet Channel
--  NPC: Ineuteniace
-- Type: Standard NPC
-- !pos 11.701 -3 1.360 1
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(101)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
