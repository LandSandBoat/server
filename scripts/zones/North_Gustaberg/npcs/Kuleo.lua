-----------------------------------
-- Area: North Gustaberg
--  NPC: Kuleo
-- Type: Outpost Vendor
-- !pos -586 39 61 106
-----------------------------------
---@type TNpcEntity
local entity = {}

local vendorRegion  = xi.region.GUSTABERG
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
