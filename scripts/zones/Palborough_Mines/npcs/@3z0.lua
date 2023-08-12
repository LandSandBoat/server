-----------------------------------
-- Area: Palborough Mines
--  NPC: @3z0
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    local elevator =
    {
        id = xi.elevator.PALBOROUGH_MINES_LIFT,
        lowerDoor = npc:getID() - 7,
        upperDoor = npc:getID() - 6,
        elevator = npc:getID(),
        reversedAnimations = true,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end

return entity
