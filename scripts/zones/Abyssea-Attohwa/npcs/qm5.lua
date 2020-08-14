-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm5 (???)
-- Spawns Kharon
-- !pos -403.909 -4.234 200.832 215
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
