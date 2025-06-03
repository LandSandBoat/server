-----------------------------------
-- Area: Beadeaux
--  NPC: ???
-- !pos -166.230 -1 -73.685 147
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local duration = math.random(600, 900)

    npc:entityAnimationPacket(xi.animationString.EFFECT_SILENCE, player)
    player:addStatusEffect(xi.effect.SILENCE, 0, 0, duration)
end

return entity
