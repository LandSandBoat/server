-----------------------------------
-- Area: Yhoator Jungle
--   NM: Bisque-heeled Sunberry
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  296.401, y = -18.499, z = -505.720 },
    { x =  301.844, y = -18.000, z = -526.287 },
    { x =  297.768, y = -18.000, z = -509.508 },
    { x =  307.721, y = -18.000, z = -508.739 },
    { x =  301.095, y = -18.000, z = -520.230 },
    { x =  300.542, y = -18.000, z = -535.823 },
    { x =  300.282, y = -18.000, z = -529.967 },
    { x =  304.054, y = -18.000, z = -542.151 },
    { x =  307.117, y = -18.000, z = -507.640 },
    { x =  302.125, y = -18.000, z = -544.137 },
    { x =  302.482, y = -18.000, z = -512.559 },
    { x =  300.566, y = -18.000, z = -534.386 },
    { x =  302.281, y = -18.000, z = -547.544 },
    { x =  299.451, y = -18.000, z = -499.702 },
    { x =  298.604, y = -18.000, z = -514.682 },
    { x =  300.656, y = -18.000, z = -527.634 },
    { x =  296.003, y = -18.000, z = -504.583 },
    { x =  307.050, y = -18.000, z = -518.318 },
    { x =  300.211, y = -18.000, z = -522.827 },
    { x =  301.361, y = -18.000, z = -515.915 },
    { x =  300.088, y = -18.000, z = -539.121 },
    { x =  302.978, y = -18.000, z = -539.390 },
    { x =  303.954, y = -18.000, z = -502.099 },
    { x =  299.197, y = -18.000, z = -544.995 },
    { x =  303.977, y = -18.000, z = -537.417 },
    { x =  300.977, y = -18.000, z = -512.878 },
    { x =  304.826, y = -18.000, z = -541.718 },
    { x =  300.991, y = -18.000, z = -505.109 },
    { x =  302.582, y = -18.000, z = -531.308 },
    { x =  300.414, y = -18.000, z = -514.964 },
    { x =  299.397, y = -18.000, z = -519.590 },
    { x =  305.018, y = -18.000, z = -520.864 },
    { x =  301.675, y = -18.000, z = -524.355 },
    { x =  300.797, y = -18.000, z = -531.748 },
    { x =  299.512, y = -18.000, z = -540.896 },
    { x =  297.901, y = -18.000, z = -514.013 },
    { x =  304.629, y = -18.000, z = -507.668 },
    { x =  303.521, y = -18.000, z = -532.454 },
    { x =  307.055, y = -18.000, z = -543.625 },
    { x =  301.880, y = -18.000, z = -521.569 },
    { x =  301.330, y = -18.000, z = -524.741 },
    { x =  303.473, y = -18.000, z = -545.524 },
    { x =  308.312, y = -18.000, z = -509.446 },
    { x =  296.595, y = -18.000, z = -505.966 },
    { x =  302.471, y = -18.000, z = -503.336 },
    { x =  300.448, y = -18.000, z = -539.814 },
    { x =  298.774, y = -18.000, z = -508.050 },
    { x =  302.130, y = -18.000, z = -519.046 },
    { x =  302.110, y = -18.000, z = -522.843 },
    { x =  301.194, y = -18.000, z = -531.676 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours

    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)

    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 350)
    mob:setMobMod(xi.mobMod.GIL_MAX, 900)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
