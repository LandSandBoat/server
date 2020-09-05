-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Rakh Mhappyoh
-- Type: Standard NPC
-- !pos -55.989 -4.5 48.365 94
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(411)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
