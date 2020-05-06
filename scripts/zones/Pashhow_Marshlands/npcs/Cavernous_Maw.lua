-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Cavernous Maw
-- !pos 418 25 27 109
-- Teleports Players to Pashhow Marshlands [S]
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
