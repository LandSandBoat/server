-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Furious Boulder
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= -105 then
        player:startEvent(229)

    -- Inside dock zone.
    else
        player:startEvent(225)
    end
end

return entity
