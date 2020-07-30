-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Prucco-Lurucco
-- Type: Standard NPC
-- !pos 140.772 -3.499 132.942 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(420)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
