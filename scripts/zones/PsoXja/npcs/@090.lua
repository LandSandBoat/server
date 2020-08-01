-----------------------------------
-- Area: PsoXja
--  NPC: TOWER_A_Lift_0 !pos 300 15.450 -60
-----------------------------------
-----------------------------------
require("scripts/globals/status")
-----------------------------------
function onSpawn(npc)

    local elevator =
    {
        id = tpz.elevator.TIMED_AUTOMATIC,
        lowerDoor = npc:getID() + 2,
        upperDoor = npc:getID() + 1,
        elevator = npc:getID(),
        reversedAnimations = true,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end
