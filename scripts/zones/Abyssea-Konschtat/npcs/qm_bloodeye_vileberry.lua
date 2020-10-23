-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: ???
-- Spawns Bloodeye Vileberry
-- !pos 554.000 24.198 714.000 15
-- !pos 539.000 24.198 714.000 15
-- !pos 554.000 23.098 699.000 15
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
