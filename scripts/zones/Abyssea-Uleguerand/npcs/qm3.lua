-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm3 (???)
-- Spawns Blanga
-- !pos -615.221 -39.768 -16.079 253
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
