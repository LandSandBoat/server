-----------------------------------
-- Area: Qufim Island
--  NPC: Jiwon
-- Type: Outpost Vendor
-- !pos -249 -19 300 126
-----------------------------------
---@type TNpcEntity
local entity = {}

local vendorRegion  = xi.region.QUFIMISLAND
local vendorEvent   = 32756

entity.onTrigger = function(player, npc)
    xi.conquest.vendorOnTrigger(player, vendorRegion, vendorEvent)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.conquest.vendorOnEventUpdate(player, vendorRegion)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.conquest.vendorOnEventFinish(player, option, vendorRegion)
end

return entity
