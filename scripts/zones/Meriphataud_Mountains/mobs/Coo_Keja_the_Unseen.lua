-----------------------------------
-- Area: Meriphataud Mountains (119)
--   NM: Coo Keja the Unseen
-----------------------------------
mixins = { require('scripts/mixins/job_special'), require('scripts/mixins/rotz_bodyguarded_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  684.000, y = -23.000, z =   6.000 },
    { x =  716.442, y = -31.286, z = -65.679 },
    { x =  673.816, y = -24.326, z =  -9.020 },
    { x =  719.337, y = -31.908, z =   6.541 },
    { x =  673.860, y = -31.907, z = -45.640 },
    { x =  713.757, y = -31.726, z =   3.473 },
    { x =  717.300, y = -31.758, z =  23.904 },
    { x =  721.760, y = -32.000, z = -35.884 },
    { x =  721.095, y = -31.928, z = -34.545 },
    { x =  679.588, y = -31.316, z = -64.119 },
    { x =  656.251, y = -26.226, z = -28.532 },
    { x =  708.957, y = -32.011, z = -23.967 },
    { x =  686.957, y = -32.211, z = -57.123 },
    { x =  687.428, y = -32.102, z = -45.738 },
    { x =  714.578, y = -32.035, z =  16.230 },
    { x =  693.369, y = -31.653, z = -41.429 },
    { x =  700.039, y = -31.003, z = -43.542 },
    { x =  719.882, y = -31.807, z =  31.575 },
    { x =  677.592, y = -23.934, z =   7.763 },
    { x =  707.975, y = -32.500, z = -18.764 },
    { x =  716.387, y = -31.162, z = -51.941 },
    { x =  714.745, y = -32.000, z = -24.761 },
    { x =  720.619, y = -31.348, z = -54.566 },
    { x =  674.778, y = -26.549, z = -14.611 },
    { x =  669.815, y = -24.250, z =  13.968 },
    { x =  686.200, y = -32.176, z = -71.215 },
    { x =  719.374, y = -32.000, z = -38.598 },
    { x =  704.685, y = -31.973, z = -30.884 },
    { x =  678.898, y = -23.953, z =  33.910 },
    { x =  677.673, y = -31.837, z = -65.387 },
    { x =  681.563, y = -32.087, z = -45.488 },
    { x =  715.503, y = -32.069, z = -17.095 },
    { x =  723.219, y = -31.060, z = -18.827 },
    { x =  700.845, y = -27.525, z =  32.313 },
    { x =  700.133, y = -27.643, z =  -4.011 },
    { x =  711.559, y = -32.500, z = -18.145 },
    { x =  659.313, y = -28.275, z = -35.541 },
    { x =  690.271, y = -31.793, z = -33.406 },
    { x =  683.267, y = -31.615, z = -36.833 },
    { x =  714.758, y = -32.103, z = -73.451 },
    { x =  673.336, y = -31.978, z = -53.779 },
    { x =  723.475, y = -32.000, z =  -4.249 },
    { x =  691.581, y = -31.817, z = -46.128 },
    { x =  716.621, y = -32.000, z =  -5.769 },
    { x =  690.499, y = -25.285, z =  18.114 },
    { x =  697.028, y = -26.785, z =  25.154 },
    { x =  719.587, y = -31.629, z = -50.699 },
    { x =  704.116, y = -32.029, z = -35.809 },
    { x =  721.342, y = -32.000, z = -42.506 },
    { x =  696.720, y = -28.484, z = -11.413 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

-- all body guard functionality in the rotz_bodyguarded_nm mixin

entity.onMobSpawn = function(mob)
    -- retail captures show these mods are not dependent on region control
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIJIN_GAKURE, hpp = math.random(10, 15) },
        },
    })
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
