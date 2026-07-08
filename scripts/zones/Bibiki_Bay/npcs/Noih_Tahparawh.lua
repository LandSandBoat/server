-----------------------------------
-- Area: Bibiki Bay
--  NPC: Noih Tahparawh
-- Type: Manaclipper Timekeeper
-- !pos -392 -3 -385 4
-----------------------------------
---@type TNpcEntity
local entity = {}

local timekeeperLocation = xi.manaclipper.location.PURGONORGO_ISLE
local timekeeperEventId = 19

entity.onTrigger = function(player, npc)
    xi.manaclipper.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

return entity
