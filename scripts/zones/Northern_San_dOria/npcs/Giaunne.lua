-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Giaunne
-- !pos -13 0 36 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(667)
end

return entity
