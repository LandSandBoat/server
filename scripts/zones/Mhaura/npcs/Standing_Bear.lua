-----------------------------------
-- Area: Mhaura
--  NPC: Standing Bear
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() > 38.5 then
        player:startEvent(14)
    else
        player:startEvent(235)
    end
end

return entity
