-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Felourie
-- Type: Phanauet Channel Barge Timekeeper
-- !pos -300.134 -2.999 505.016 2
-----------------------------------
require("scripts/globals/barge")
-----------------------------------
local entity = {}

local eventId = 20
local location = xi.barge.location.NORTH_LANDING

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
