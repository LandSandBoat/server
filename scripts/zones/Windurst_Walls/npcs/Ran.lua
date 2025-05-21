-----------------------------------
-- Area: Windurst Walls
--  NPC: Ran
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if math.random(1, 100) <= 50 then
        player:startEvent(272)
    else
        player:startEvent(273)
    end
end

return entity
