-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm5 (???)
-- Spawns Kadraeth the Hatespawn
-- !pos -475 -40 -280 217
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
