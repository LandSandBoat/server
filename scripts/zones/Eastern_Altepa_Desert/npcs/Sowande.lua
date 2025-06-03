-----------------------------------
-- Area: Eastern Altepa Desert
--  NPC: Sowande
-- Type: Outpost Vendor
-- !pos -257 8 -249 114
-----------------------------------
---@type TNpcEntity
local entity = {}

local vendorRegion  = xi.region.KUZOTZ
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
