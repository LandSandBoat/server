-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Mahien-Uhien
-- Type: Outpost Vendor
-- !pos -13 -12 311 115
-----------------------------------
local entity = {}

local vendorRegion  = xi.region.SARUTABARUTA
local vendorEvent   = 32756

entity.onTrade = function(player, npc, trade)
end

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
