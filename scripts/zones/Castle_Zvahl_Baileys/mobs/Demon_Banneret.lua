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
    mob:addStatusEffect(xi.effect.STUN, { duration = 5, origin = mob, flag = xi.effectFlag.NO_LOSS_MESSAGE, silent = true }) -- Holds the mobs until the NM has "arrived"
end

return entity
