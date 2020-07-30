-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm1 (???)
-- Spawns Khalkotaur
-- !pos -115.911 -40.034 -201.988 217
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
end

function onEventFinish(player, csid, option)
end
