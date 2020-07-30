-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm8 (???)
-- Spawns Kampe
-- !pos -401.612 3.738 -200.972 215
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
