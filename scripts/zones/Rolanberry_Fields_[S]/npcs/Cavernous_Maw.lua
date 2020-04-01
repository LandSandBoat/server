-----------------------------------
-- Area: Rolanberry Fields [S]
--  NPC: Cavernous Maw
-- !pos -198 8 360 91
-- Teleports Players to Rolanberry Fields
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
