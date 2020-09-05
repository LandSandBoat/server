-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Kleh Engyumoh
-- Type: Standard NPC
-- !pos -54.962 -4.5 57.701 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(431)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
