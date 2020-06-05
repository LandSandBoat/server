-----------------------------------
-- Area: East Ronfaure [S]
--  NPC: Cavernous Maw
-- Teleports Players to East Ronfaure
-- !pos 322 -59 503 81
-----------------------------------
require("scripts/globals/maws")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.maws.onTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.maws.onEventFinish(player, csid, option)
end
