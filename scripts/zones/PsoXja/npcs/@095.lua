-----------------------------------
-- Area: PsoXja
--  NPC: TOWER_F_Lift_E !pos -300 24 340
-----------------------------------
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onSpawn(npc)

    local elevator =
    {
        id = tpz.elevator.TIMED_AUTOMATIC,
        lowerDoor = npc:getID() - 1,
        upperDoor = npc:getID() - 2,
        elevator = npc:getID(),
        reversedAnimations = true,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end
