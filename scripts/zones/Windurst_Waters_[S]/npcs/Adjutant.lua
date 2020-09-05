-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Adjutant
-- Type: Standard NPC
-- !pos -67.819 -4.499 58.997 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(305)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
