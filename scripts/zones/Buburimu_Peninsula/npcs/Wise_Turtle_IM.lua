-----------------------------------
-- Area: Buburimu Peninsula
--  NPC: Wise Turtle, I.M.
-- Border Conquest Guards
-- !pos -599.903 -41.441 165.776 118
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

local guardNation = tpz.nation.BASTOK
local guardType   = tpz.conq.guard.BORDER
local guardRegion = tpz.region.KOLSHUSHU
local guardEvent  = 32760

function onTrade(player, npc, trade)
    tpz.conq.overseerOnTrade(player, npc, trade, guardNation, guardType)
end

function onTrigger(player, npc)
    tpz.conq.overseerOnTrigger(player, npc, guardNation, guardType, guardEvent, guardRegion)
end

function onEventUpdate(player, csid, option)
    tpz.conq.overseerOnEventUpdate(player, csid, option, guardNation)
end

function onEventFinish(player, csid, option)
    tpz.conq.overseerOnEventFinish(player, csid, option, guardNation, guardType, guardRegion)
end
