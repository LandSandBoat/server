-----------------------------------
-- Area: Port San d'Oria
--  NPC: Pomilla
-- !pos -38 -4 -55 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(562)
end

return entity
