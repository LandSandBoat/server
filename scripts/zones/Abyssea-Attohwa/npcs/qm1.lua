-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm1 (???)
-- Spawns Granite Borer
-- !pos 401.489 19.730 -282.864 215
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
