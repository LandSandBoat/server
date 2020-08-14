-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Uricca-Koricca
-- Type: Standard NPC
-- !pos -102.221 -3 48.791 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(437)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
