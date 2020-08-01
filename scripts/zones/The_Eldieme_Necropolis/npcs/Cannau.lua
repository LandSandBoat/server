-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Cannau
-- Type: Escort NPC
-- !pos 419.838 -56.999 -114.870 195
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(51)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
