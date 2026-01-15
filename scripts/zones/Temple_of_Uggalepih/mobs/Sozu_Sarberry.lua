-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Sozu Sarberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = 94.330, y = 0.000, z = -14.457 },
    { x = 90.956, y = 0.000, z = -33.977 },
    { x = 79.882, y = 0.000, z = -31.421 },
    { x = 65.848, y = 0.000, z = -29.772 },
    { x = 70.533, y = 0.000, z = -20.880 },
    { x = 68.699, y = 0.000, z = -10.828 },
    { x = 79.437, y = 0.000, z =  -6.995 },
    { x = 99.397, y = 0.000, z = -21.299 },
    { x = 83.668, y = 0.000, z = -21.268 },
    { x = 74.658, y = 0.000, z = -21.304 },
    { x = 74.462, y = 0.000, z = -26.719 },
    { x = 92.406, y = 0.000, z = -16.127 },
    { x = 74.895, y = 0.000, z = -14.012 },
    { x = 84.892, y = 0.000, z =  -5.982 },
    { x = 69.782, y = 0.000, z = -35.072 }
}

entity.phList =
{
    [ID.mob.SOZU_SARBERRY - 3] = ID.mob.SOZU_SARBERRY, -- 89 0.499 -23
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3000)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIJIN_GAKURE, hpp = math.random(20, 30) },
        },
    })

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 388)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
