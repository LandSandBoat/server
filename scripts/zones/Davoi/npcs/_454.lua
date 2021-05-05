-----------------------------------
-- Area: Davoi
--  NPC: _454
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)

    local elevator =
    {
        id = xi.elevator.DAVOI_LIFT,
        lowerDoor = npc:getID() - 2,
        upperDoor = npc:getID(),
        elevator = npc:getID() - 3,
        reversedAnimations = true,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end

return entity
