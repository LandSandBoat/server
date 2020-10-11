-----------------------------------
-- Area: Dangruf Wadi
--  NPC: Strange Apparatus
-- !pos -494 -4 -100 191
-----------------------------------
require("scripts/globals/strangeapparatus")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.strangeApparatus.onTrade(player, trade, 3)
end

function onTrigger(player, npc)
    tpz.strangeApparatus.onTrigger(player, 1)
end

function onEventUpdate(player, csid, option)
    if csid == 1 then
        tpz.strangeApparatus.onEventUpdate(player, option)
    end
end

function onEventFinish(player, csid, option)
    if csid == 3 then
        tpz.strangeApparatus.onEventFinish(player)
    end
end
