-----------------------------------
-- Area: Yuhtunga Jungle
--   NM: Mischievous Micholas
-----------------------------------
local ID = zones[xi.zone.YUHTUNGA_JUNGLE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -279.575, y =  3.317, z =  16.011 }
}

entity.phList =
{
    [ID.mob.MISCHIEVOUS_MICHOLAS - 1] = ID.mob.MISCHIEVOUS_MICHOLAS, -- -265.616 -0.5 -24.389
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 362)
    xi.regime.checkRegime(player, mob, 126, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 128, 1, xi.regime.type.FIELDS)
    xi.magian.onMobDeath(mob, player, optParams, set{ 780 })
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
