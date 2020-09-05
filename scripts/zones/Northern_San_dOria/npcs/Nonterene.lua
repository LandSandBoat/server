-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Nonterene
-- Type: Adventurer's Assistant NPC
-- !pos -6.347 0.000 -11.265 231
--
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(503)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
