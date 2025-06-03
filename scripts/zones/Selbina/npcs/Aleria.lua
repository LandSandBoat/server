-----------------------------------
-- Area: Selbina
--  NPC: Aleria
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() < -28.750 then
        player:startEvent(223)
    else
        player:startEvent(228)
    end
end

return entity
