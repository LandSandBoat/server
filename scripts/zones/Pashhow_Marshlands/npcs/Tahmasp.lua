-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Tahmasp
-- Type: Outpost Vendor
-- !pos 464 24 416 109
-----------------------------------
require("scripts/globals/conquest")
-----------------------------------
local entity = {}

local vendorRegion  = tpz.region.DERFLAND
local vendorEvent   = 32756

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.conquest.vendorOnTrigger(player, vendorRegion, vendorEvent)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.conquest.vendorOnEventUpdate(player, vendorRegion)
end

entity.onEventFinish = function(player, csid, option)
    tpz.conquest.vendorOnEventFinish(player, option, vendorRegion)
end

return entity
