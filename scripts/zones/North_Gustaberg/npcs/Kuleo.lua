-----------------------------------
-- Area: North Gustaberg
--  NPC: Kuleo
-- Type: Outpost Vendor
-- !pos -586 39 61 106
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------

local vendorRegion  = tpz.region.GUSTABERG
local vendorEvent   = 32756

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.conquest.vendorOnTrigger(player, vendorRegion, vendorEvent)
end

function onEventUpdate(player, csid, option)
    tpz.conquest.vendorOnEventUpdate(player, vendorRegion)
end

function onEventFinish(player, csid, option)
    tpz.conquest.vendorOnEventFinish(player, option, vendorRegion)
end
