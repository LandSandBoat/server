-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Somnolent Rooster
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= 95 then
        player:startEvent(226)

    -- Inside dock zone.
    else
        player:startEvent(231)
    end
end

return entity
