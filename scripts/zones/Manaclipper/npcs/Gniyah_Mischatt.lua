-----------------------------------
-- Area: Manaclipper
--  NPC: Gniyah Mischatt
-- Type: Manaclipper Timekeeper
-- !pos 0.033 -4 2.725 3
-----------------------------------
require("scripts/globals/manaclipper")
-----------------------------------
local entity = {}

local timekeeperLocation = tpz.manaclipper.location.MANACLIPPER
local timekeeperEventId = 2

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.manaclipper.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
