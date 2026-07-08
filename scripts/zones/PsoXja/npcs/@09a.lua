-----------------------------------
-- Area: PsoXja
--  NPC: TOWER_C_Lift_S !pos 250 6.250 250
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    local lowerDoorNpc = GetNPCByID(npc:getID() + 2)
    local upperDoorNpc = GetNPCByID(npc:getID() + 1)

    if lowerDoorNpc then
        lowerDoorNpc:setNpcAlwaysRelevant(true)
    end

    if upperDoorNpc then
        upperDoorNpc:setNpcAlwaysRelevant(true)
    end

    npc:setNpcAlwaysRelevant(true)

    local elevator =
    {
        id = xi.elevator.TIMED_AUTOMATIC,
        lowerDoor = npc:getID() + 2,
        upperDoor = npc:getID() + 1,
        elevator = npc:getID(),
        reversedAnimations = true,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end

return entity
