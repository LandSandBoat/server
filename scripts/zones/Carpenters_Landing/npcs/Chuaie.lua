-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Chuaie
-- Type: Phanauet Channel Barge Timekeeper
-- !pos 231.384 -3 -531.830 2
-----------------------------------
require("scripts/globals/barge")
-----------------------------------
local entity = {}
local eventId = 18
local location = xi.barge.location.SOUTH_LANDING

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, location, eventId)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
