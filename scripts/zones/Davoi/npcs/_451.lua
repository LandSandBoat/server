-----------------------------------
-- Area: Davoi
--  NPC: _451 (Elevator Lever)
-- Notes: Used to operate Elevator @450 (actual npc script is _454)
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(3) -- lever animation
    RunElevator(xi.elevator.DAVOI_LIFT) -- elevator @450 (actual npc script is _454)
end

return entity
