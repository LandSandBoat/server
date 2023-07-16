-----------------------------------
-- Area: West Ronfaure
--  NPC: Saradorial
-- Type: Goldfish Scooping
-- !pos -399.671 -10.999 -438.910 100
-----------------------------------
require("scripts/globals/events/sunbreeze_festival")
-----------------------------------
local entity = {}
local event = 139

entity.onTrade = function(player, npc, trade)
    xi.events.sunbreeze_festival.goldfishVendorOnTrade(player, npc, trade, event)
end

entity.onTrigger = function(player, npc)
    xi.events.sunbreeze_festival.goldfishVendorOnTrigger(player, npc, event)
end

entity.onEventUpdate = function(player, csid, option)
    xi.events.sunbreeze_festival.goldfishVendorOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.events.sunbreeze_festival.goldfishVendorOnEventFinish(player, csid, option)
end

return entity
