-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm6 (???)
-- Spawns Drekavac
-- !pos -158.000 -0.340 220.000 215
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
