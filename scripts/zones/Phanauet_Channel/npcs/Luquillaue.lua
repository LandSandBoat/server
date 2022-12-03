-----------------------------------
-- Area: Phanauet Channel
--  NPC: Luquillaue
-- Type: Barge Timekeeper
-- !pos 4.066 -4.5 -10.450 1
-----------------------------------
require("scripts/globals/barge")
-----------------------------------
local entity = {}

local timekeeperLocation = xi.barge.location.BARGE
local timekeeperEventId = 4 -- (north to main)

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.barge.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
