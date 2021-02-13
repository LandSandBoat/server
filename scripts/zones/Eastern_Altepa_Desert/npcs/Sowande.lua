-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: Sowande
-- Type: Outpost Vendor
-- !pos -257 8 -249 114
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

local vendorRegion  = tpz.region.KUZOTZ
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
