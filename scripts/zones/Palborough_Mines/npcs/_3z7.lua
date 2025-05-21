-----------------------------------
-- Elevator in Palborough
-- Notes: Used to operate Elevator @3z0
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local state  = GetElevatorState(xi.elevator.PALBOROUGH_MINES_LIFT)
    local isBusy = npc:getLocalVar('isBusy')

    if
        isBusy == 0 and
        (state == xi.elevatorState.BOTTOM or
        state == xi.elevatorState.TOP)
    then
        player:startEvent(10)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local isBusy = npc:getLocalVar('isBusy')

    if
        isBusy == 0 and
        csid == 10 and
        option == 1
    then
        local state = GetElevatorState(xi.elevator.PALBOROUGH_MINES_LIFT)

        if state == xi.elevatorState.BOTTOM or state == xi.elevatorState.TOP then
            if npc:getAnimation() == xi.animation.OPEN_DOOR then
                npc:setAnimation(xi.animation.CLOSE_DOOR)
            else
                npc:setAnimation(xi.animation.OPEN_DOOR)
            end

            npc:setLocalVar('isBusy', 1)
            npc:timer(3000, function()
                RunElevator(xi.elevator.PALBOROUGH_MINES_LIFT)
                npc:setLocalVar('isBusy', 0)
            end)
        end
    end
end

return entity
