-----------------------------------
-- Area: Qufim Island
--  NPC: Jiwon
-- Type: Outpost Vendor
-- !pos -249 -19 300 126
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

local vendorRegion  = xi.region.QUFIMISLAND
local vendorEvent   = 32756

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.conquest.vendorOnTrigger(player, vendorRegion, vendorEvent)
end

entity.onEventUpdate = function(player, csid, option)
    xi.conquest.vendorOnEventUpdate(player, vendorRegion)
end

entity.onEventFinish = function(player, csid, option)
    xi.conquest.vendorOnEventFinish(player, option, vendorRegion)
end

return entity
