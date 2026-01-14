-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Namtar
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -148.457, y =  9.171, z =  175.332 }
}

entity.phList =
{
    [ID.mob.NAMTAR - 6] = ID.mob.NAMTAR, -- -128.762 9.595 164.996
    [ID.mob.NAMTAR - 1] = ID.mob.NAMTAR, -- -157.606 9.905 168.518
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.GIL_MIN, 1200)
    mob:setMobMod(xi.mobMod.GIL_MAX, 1200)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 369)
    xi.regime.checkRegime(player, mob, 805, 2, xi.regime.type.GROUNDS)
    xi.magian.onMobDeath(mob, player, optParams, set{ 366 })
end

return entity
