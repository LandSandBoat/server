-----------------------------------
-- Area: Bastok Mines
--  NPC: Gerbaum
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local rand = math.random(1, 2)

    if rand == 1 then
        player:startEvent(22)
    else
        player:startEvent(23)
    end
end

return entity
