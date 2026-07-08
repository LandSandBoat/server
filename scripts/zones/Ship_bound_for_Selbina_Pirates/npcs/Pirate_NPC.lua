-----------------------------------
--  Area: Ship bound for Mhaura Pirates
--   NPC: Pirate
-- Notes: Does nothing but trigger summoning start/stop animations while the pirate ship is next to the boat
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    xi.pirates.setupPirateNPCSchedule(npc)
end

entity.onTimeTrigger = function(npc, triggerID)
    xi.pirates.pirateNPCTimeTrigger(npc, triggerID, xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES)
end

return entity
