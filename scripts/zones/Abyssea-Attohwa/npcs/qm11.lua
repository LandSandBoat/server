-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm11 (???)
-- Spawns Nightshade
-- !pos 410.304 19.500 13.227 215
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
