-----------------------------------
-- Area: Port Bastok
--  NPC: Door: Arrivals Entrance
-- !pos -80 1 -26 236
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(140)
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
