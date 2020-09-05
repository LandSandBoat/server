-----------------------------------
-- Area: Port Windurst
--  NPC: Door: Arrivals Entrance
-- !pos 212 -6 96 240
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(182)
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
