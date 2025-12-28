-----------------------------------
-- Area: Rabao
-- NPC: Jourdenaux
-- !pos -27.100 8.442 36
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.fishingAnimation(npc, 2)
end

entity.onTrigger = function(player, npc)
    player:startEvent(154, 0, 99, xi.item.SANDFISH) -- TODO: Count goes up as he successfully catches fish as observed in captures. Might act similar to the Lu Shang fishing NPCs in Port San d'Oria where the count resets.
end

return entity
