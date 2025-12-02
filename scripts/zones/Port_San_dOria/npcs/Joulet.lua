-----------------------------------
-- Area: Port San d'Oria
-- NPC: Joulet
-- !pos -18 -2 -45 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.fishingAnimation(npc, 2)
end

return entity
