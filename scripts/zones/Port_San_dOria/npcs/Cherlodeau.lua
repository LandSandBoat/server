-----------------------------------
-- Area: Port San d'Oria
--  NPC: Cherlodeau
-- !pos -20 -4 -69 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(590)
end

return entity
