-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm3 (???)
-- Spawns Funeral Apkallu
-- !pos 209 -23 321 216
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
