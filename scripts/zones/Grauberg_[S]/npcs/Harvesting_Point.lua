-----------------------------------
-- Area: Grauberg [S]
--  NPC: Harvesting Point
-----------------------------------
require("scripts/globals/helm")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.helm.onTrade(player, npc, trade, tpz.helm.type.HARVESTING, 901)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.HARVESTING_IS_POSSIBLE_HERE, 1020)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
