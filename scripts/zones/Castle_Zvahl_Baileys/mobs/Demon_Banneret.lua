-----------------------------------
-- Area: Castle Zvahl Baileys (161)
-- Demon Banneret
-- Quest: Better The Demon You Know
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addStatusEffectEx(xi.effect.STUN, xi.effect.STUN, 0, 0, 5, 0, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE, true) -- Holds the mobs until the NM has "arrived"
end

return entity
