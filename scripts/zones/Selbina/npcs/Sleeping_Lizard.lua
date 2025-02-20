-----------------------------------
-- Area: Selbina
--  NPC: Sleeping Lizard
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() < -28.750 then
        player:startEvent(213)
    else
        player:startEvent(229)
    end
end

return entity
