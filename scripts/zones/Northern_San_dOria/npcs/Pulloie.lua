-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pulloie
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getNation() == 0 then
        player:startEvent(595)
    else
        player:startEvent(598)
    end
end

return entity
