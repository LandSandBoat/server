-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: ???
-- Spawns Kukulkan
-- !pos -40.000 71.992 560.000 15
-- !pos -40.000 68.692 575.000 15
-- !pos -25.000 68.792 560.000 15
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------

function onTrade(player, npc, trade)
    tpz.abyssea.qmOnTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.abyssea.qmOnTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    tpz.abyssea.qmOnEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.abyssea.qmOnEventFinish(player, csid, option)
end
