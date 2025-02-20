-----------------------------------
-- Area: Mhaura
--  NPC: Albin
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() <= 39 then
        player:startEvent(220)
    else
        player:startEvent(229)
    end
end

return entity
