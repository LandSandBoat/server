-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm4 (???)
-- Spawns Yaguarogui
-- !pos 432 .001 -424 253
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
