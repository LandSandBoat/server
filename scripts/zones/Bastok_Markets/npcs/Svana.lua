-----------------------------------
-- Area: Bastok Markets
--  NPC: Svana
-- Type: Weather Reporter
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(4, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
