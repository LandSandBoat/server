-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm4 (???)
-- Spawns Gaizkin
-- !pos -132.253 0.015 0.753 215
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
