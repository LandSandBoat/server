-----------------------------------
-- Area: Selbina
--  NPC: Sleeping Lizard
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= -28.750 then
        player:startEvent(229)

    -- Inside dock zone.
    else
        player:startEvent(213)
    end
end

return entity
