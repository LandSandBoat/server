-----------------------------------
-- Area: Mhaura
--  NPC: Condor Eye
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Outside dock zone.
    if player:getZPos() >= 39 then
        player:startEvent(229)

    -- Inside dock zone.
    else
        player:startEvent(13)
    end
end

return entity
