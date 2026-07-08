-----------------------------------
-- Area: Port Windurst
--  NPC: Mojo-Pojo
-- !pos -108.041 -4.25 109.545 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.castingAnimation(npc, xi.magic.spellGroup.BLACK, 14)
end

return entity
