-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Tahmasp
-- Type: Outpost Vendor
-- !pos 464 24 416 109
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------

local vendorRegion  = tpz.region.DERFLAND
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
