-----------------------------------
-- Area: Selbina
--  NPC: Aleria
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= -28.750 then
        player:startEvent(228)

    -- Inside dock zone.
    else
        player:startEvent(223)
    end
end

return entity
