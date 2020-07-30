-----------------------------------
-- Area: Residential Area
--  NPC: Moogle
-- Defunct Script - Should not be called by anything anymore
-- Moogle scripts are in each zone, calling a function from moghouse.lua
-----------------------------------
require("scripts/globals/moghouse")

function onTrade(player, npc, trade)
    moogleTrade(player, npc, trade)
end

function onTrigger(player, npc)
    moogleTrigger(player, npc)
end

function onEventUpdate(player, csid, option)
    moogleEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    moogleEventFinish(player, csid, option)
end
