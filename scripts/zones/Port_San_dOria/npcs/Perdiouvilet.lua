-----------------------------------
-- Area: Port San d'Oria
--  NPC: Perdiouvilet
-- !pos -59 -5 -29 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(762)
end

return entity
