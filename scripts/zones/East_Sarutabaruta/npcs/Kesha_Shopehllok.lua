-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Kesha Shopehllok
-- Type: Goldfish Scooping
-- !pos -22.316 -2.79 -50.815 116
-----------------------------------
require("scripts/globals/events/sunbreeze_festival")
-----------------------------------
local entity = {}
local event = 55

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
