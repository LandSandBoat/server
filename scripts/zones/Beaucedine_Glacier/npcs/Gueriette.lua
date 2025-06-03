-----------------------------------
-- Area: Beaucedine Glacier
--  NPC: Gueriette
-- Type: Outpost Vendor
-- !pos -24 -59 -120 111
-----------------------------------
---@type TNpcEntity
local entity = {}

local vendorRegion  = xi.region.FAUREGANDI
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
