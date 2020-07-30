-----------------------------------
-- Area: Giddeus
--  NPC: Harvesting Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.helm.onTrade(player, npc, trade, tpz.helm.type.HARVESTING, 70)
end

function onTrigger(player, npc)
    tpz.helm.onTrigger(player, tpz.helm.type.HARVESTING)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
