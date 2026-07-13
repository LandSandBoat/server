-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Anilla
-- !pos 8 0.1 61 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(586)
end

return entity
