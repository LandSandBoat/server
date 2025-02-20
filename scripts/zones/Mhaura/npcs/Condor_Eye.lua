-----------------------------------
-- Area: Mhaura
--  NPC: Condor Eye
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() <= 39 then
        player:startEvent(13)
    else
        player:startEvent(229)
    end
end

return entity
