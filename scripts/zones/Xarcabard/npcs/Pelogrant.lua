-----------------------------------
-- Area: Xarcabard
--  NPC: Pelogrant
-- Type: Outpost Vendor
-- !pos 210 -22 -201 112
-----------------------------------
---@type TNpcEntity
local entity = {}

local vendorRegion  = xi.region.VALDEAUNIA
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
