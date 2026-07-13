-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Phairupegiont
-- !pos -46 0.1 76 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(663)
end

return entity
