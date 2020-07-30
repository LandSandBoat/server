-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm10 (???)
-- Spawns Maahes
-- !pos 214.107 19.970 -93.816 215
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
