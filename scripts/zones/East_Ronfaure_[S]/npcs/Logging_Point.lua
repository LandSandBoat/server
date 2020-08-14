-----------------------------------
-- Area: East Ronfaure [S]
--  NPC: Logging Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.helm.onTrade(player, npc, trade, tpz.helm.type.LOGGING, 901)
end

function onTrigger(player, npc)
    tpz.helm.onTrigger(player, tpz.helm.type.LOGGING)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
