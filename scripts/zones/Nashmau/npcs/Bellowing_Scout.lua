-----------------------------------
-- Area: Nashmau
--  NPC: Bellowing Scout
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= -55 then
        player:startEvent(229)

    -- Inside dock zone.
    else
        player:startEvent(236)
    end
end

return entity
