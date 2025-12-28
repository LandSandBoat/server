-----------------------------------
-- Area: Mhaura
--  NPC: Standing Bear
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= 39 then
        player:startEvent(14)

    -- Inside dock zone.
    else
        player:startEvent(235)
    end
end

return entity
