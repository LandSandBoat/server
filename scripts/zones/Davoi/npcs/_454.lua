-----------------------------------
-- Area: Davoi
-- NPC:
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onSpawn(npc)

    local elevator =
    {
        id = tpz.elevator.DAVOI_LIFT,
        lowerDoor = npc:getID() - 2,
        upperDoor = npc:getID(),
        elevator = npc:getID() - 3,
        reversedAnimations = true,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end
