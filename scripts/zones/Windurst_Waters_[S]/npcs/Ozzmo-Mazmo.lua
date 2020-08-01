-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ozzmo-Mazmo
-- Type: Standard NPC
-- !pos -61.677 -13.311 106.400 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(432)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
