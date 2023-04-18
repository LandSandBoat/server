-----------------------------------
-- Elevator in Palborough
-- Notes: Used to operate Elevator @3z0
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.isBusy = false

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local state = GetElevatorState(xi.elevator.PALBOROUGH_MINES_LIFT)

    if
        not entity.isBusy and
        (state == xi.elevatorState.BOTTOM or
        state == xi.elevatorState.TOP)
    then
        player:startEvent(9)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        not entity.isBusy and
        csid == 9 and
        option == 1
    then
        local state = GetElevatorState(xi.elevator.PALBOROUGH_MINES_LIFT)

        if state == xi.elevatorState.BOTTOM or state == xi.elevatorState.TOP then
            if npc:getAnimation() == xi.animation.OPEN_DOOR then
                npc:setAnimation(xi.animation.CLOSE_DOOR)
            else
                npc:setAnimation(xi.animation.OPEN_DOOR)
            end

            entity.isBusy = true
            npc:timer(3000, function()
                RunElevator(xi.elevator.PALBOROUGH_MINES_LIFT)
                entity.isBusy = false
            end)
        end
    end
end

return entity
