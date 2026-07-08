-----------------------------------
-- Area: Port Windurst
--  NPC: Noragu-Meragu
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.castingAnimation(npc, xi.magic.spellGroup.BLACK, 10)
end

return entity
