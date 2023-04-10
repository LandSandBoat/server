-----------------------------------
-- Area: Metalworks
--  NPC: North side Elevator platform
-- @6l0  North Elevator Platform    -56.006 -13.100 12.014
-- _6lu  North Upper Elevator Door  -53.126 -12.098 12.040
-- _6lv  North Lower Elevator Door  -58.850 0.000 12.002
-- _6lk  North Elevator Winch       -55.911 -14.221 11.958
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    local elevator =
    {
        id = xi.elevator.TIMED_AUTOMATIC,
        lowerDoor = npc:getID() + 5,
        upperDoor = npc:getID() + 4,
        elevator = npc:getID(),
        reversedAnimations = false,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end

return entity
