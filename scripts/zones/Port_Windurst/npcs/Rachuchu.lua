-----------------------------------
-- Area: Port Windurst
--  NPC: Rachuchu
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.castingAnimation(npc, xi.magic.spellGroup.WHITE, 10.5)
end

return entity
