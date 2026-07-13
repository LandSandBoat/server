-----------------------------------
-- Area: Port Windurst
--  NPC: Kunchichi
-- !pos -115.933 -4.25 109.533 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onSpawn = function(npc)
    npcUtil.castingAnimation(npc, xi.magic.spellGroup.BLACK, 16)
end

entity.onTrigger = function(player, npc)
    player:startEvent(228)
end

return entity
