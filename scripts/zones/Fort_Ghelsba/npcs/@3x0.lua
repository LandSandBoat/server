-----------------------------------
-- Area: Fort Ghelsba
--  NPC: Elevator Platform
-- !pos  6.912 -52.135 97.998 141
-- @3x0  Elevator platform
-- _3x3  Elevator stationary lower door
-- _3x4  Elevator stationary upper door
-- _3xb  Elevator moving lower door
-- _3xa  Elevator moving upper door
-- _3x0  bigwinch
-- _3x1  Elevator Lever 1
-- _3x2  Elevator Lever 2
-- _3x5  winch1 (lever's gear)
-- _3x6  winch2 (lever's gear)
-- ALL THAT FOR ONE PLATFORM.
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    local elevator =
    {
        id = xi.elevator.FORT_GHELSBA_LIFT,
        lowerDoor = npc:getID() + 1,
        upperDoor = npc:getID() + 2,
        elevator = npc:getID(),
        reversedAnimations = true,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end

return entity
