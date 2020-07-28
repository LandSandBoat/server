-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pebul-Tabul
-- Type: Standard NPC
-- !pos -68.500 -4.5 3.694 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(405)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
