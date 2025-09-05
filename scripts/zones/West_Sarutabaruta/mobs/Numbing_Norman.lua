-----------------------------------
-- Area: West Sarutabaruta
--   NM: Numbing Norman
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -347.000, y = -29.000, z = 465.000 },
    { x = -383.000, y = -29.000, z = 435.000 },
    { x = -405.000, y = -29.000, z = 381.000 },
    { x = -433.000, y = -28.000, z = 332.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(1200) -- When server restarts, reset timer

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 252)
    xi.regime.checkRegime(player, mob, 61, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(1200) -- 20 minutes
end

return entity
