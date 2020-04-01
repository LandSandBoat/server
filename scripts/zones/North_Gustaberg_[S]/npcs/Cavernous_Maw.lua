-----------------------------------
-- Area: North Gustaberg [S]
--  NPC: Cavernous Maw
-- !pos 466 0 479 88
-- Teleports Players to North Gustaberg
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
