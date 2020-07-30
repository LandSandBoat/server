-----------------------------------
-- Area: PsoXja
--  NPC: TOWER_F_Lift_W !pos -340 22.500 340
-----------------------------------
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onSpawn(npc)

    local elevator =
    {
        id = tpz.elevator.TIMED_AUTOMATIC,
        lowerDoor = npc:getID() + 5,
        upperDoor = npc:getID() + 4,
        elevator = npc:getID(),
        reversedAnimations = true,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end
