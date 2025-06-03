-----------------------------------
-- Area: Selbina
--  NPC: Catus
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() < -28.750 then
        player:startEvent(220)
    else
        player:startEvent(229)
    end
end

return entity
