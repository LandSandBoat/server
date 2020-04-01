-----------------------------------
-- Area: Pashhow Marshlands [S]
--  NPC: Cavernous Maw
-- !pos 418 25 27 90
-- Teleports Players to Pashhow_Marshlands
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
