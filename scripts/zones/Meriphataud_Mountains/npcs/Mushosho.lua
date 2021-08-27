-----------------------------------
-- Area: Meriphataud Mountains
--  NPC: Mushosho
-- Type: Outpost Vendor
-- !pos -290 16 415 119
-----------------------------------
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

local vendorRegion  = xi.region.ARAGONEU
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
