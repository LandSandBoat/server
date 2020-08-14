-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Cavernous Maw
-- Teleports Players to West Sarutabaruta [S]
-- !pos -2.229 0.001 -162.715 115
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
