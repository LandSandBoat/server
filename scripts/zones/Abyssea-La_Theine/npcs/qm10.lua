-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm10 (???)
-- Spawns Poroggo Dom Juan
-- !pos 405.785 26.404 -543.056 132
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
