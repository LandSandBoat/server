-----------------------------------
-- Area: Palborough Mines
--  NPC: Refiner Lever
-- Involved In Mission: Journey Abroad
-- !pos 180 -32 167 143
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local refinerInput = player:getCharVar('refiner_input')

    if refinerInput > 0 then
        player:startEvent(17, 1, 1, 1, 1, 1, 1, 1, 1) -- machine is working, you hear the sound of metal hitting metal down below.
        player:incrementCharVar('refiner_output', refinerInput)
        player:setCharVar('refiner_input', 0)
    else
        player:startEvent(17) -- machine is working, but you cannot discern its purpose.
    end
end

return entity
