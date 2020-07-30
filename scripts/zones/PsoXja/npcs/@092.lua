-----------------------------------
-- Area: PsoXja
--  NPC: TOWER_C_Lift_1 !pos 260 31.282 300
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
