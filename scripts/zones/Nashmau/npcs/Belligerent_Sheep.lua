-----------------------------------
-- Area: Nashmau
--  NPC: Belligerent Sheep
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= -65 then
        player:startEvent(237)

    -- Inside dock zone.
    else
        player:startEvent(223)
    end
end

return entity
