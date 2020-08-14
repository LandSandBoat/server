-----------------------------------
-- Area: Jugner Forest
--  NPC: Logging Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.helm.onTrade(player, npc, trade, tpz.helm.type.LOGGING, 20)
end

function onTrigger(player, npc)
    tpz.helm.onTrigger(player, tpz.helm.type.LOGGING)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
