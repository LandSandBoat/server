-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Ratoulle
-- Type: Phanauet Channel Barge Timekeeper
-- !pos -133.959 -3 60.839 2
-----------------------------------
require("scripts/globals/barge")
-----------------------------------
local entity = {}
local eventId = 19
local location = xi.barge.location.CENTRAL_LANDING

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
