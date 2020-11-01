-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: ???
-- Spawns Eccentric Eve
-- !pos 230.413 32.278 280.677 15
-- !pos 215.413 32.778 280.677 15
-- !pos 245.413 31.778 280.677 15
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
