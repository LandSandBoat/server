-----------------------------------
-- Area: Manaclipper
--  NPC: Gniyah Mischatt
-- Type: Manaclipper Timekeeper
-- !pos 0.033 -4 2.725 3
-----------------------------------
---@type TNpcEntity
local entity = {}

local timekeeperLocation = xi.manaclipper.location.MANACLIPPER
local timekeeperEventId = 2

entity.onTrigger = function(player, npc)
    xi.manaclipper.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

return entity
