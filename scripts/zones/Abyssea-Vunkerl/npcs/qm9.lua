-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm9 (???)
-- Spawns Chhir Batti
-- !pos -395.665 -31.565 358.085 217
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
