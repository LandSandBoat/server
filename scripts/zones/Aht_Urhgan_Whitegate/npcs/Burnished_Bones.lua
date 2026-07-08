-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Burnished Bones
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= -95 then
        player:startEvent(224)

    -- Inside dock zone.
    else
        player:startEvent(228)
    end
end

return entity
