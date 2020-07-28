-----------------------------------
-- Area: Zeruhn Mines
--  NPC: Mining Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.helm.onTrade(player, npc, trade, tpz.helm.type.MINING, 165)
end

function onTrigger(player, npc)
    tpz.helm.onTrigger(player, tpz.helm.type.MINING)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
