-----------------------------------
-- Area: Rolanberry Fields (110)
--  HNM: Simurgh
-----------------------------------
mixins =
{
    require('scripts/mixins/rage'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -681.000, y = -31.000, z =  -447.000 },
    { x = -741.999, y = -31.101, z =  -476.679 },
    { x = -762.596, y = -31.872, z =  -433.425 },
    { x = -686.700, y = -30.714, z =  -451.877 },
    { x = -762.363, y = -31.715, z =  -369.721 },
    { x = -687.011, y = -30.960, z =  -464.879 },
    { x = -720.617, y = -31.932, z =  -479.403 },
    { x = -731.898, y = -31.067, z =  -474.763 },
    { x = -683.789, y = -31.830, z =  -477.062 },
    { x = -764.133, y = -31.467, z =  -425.046 },
    { x = -766.514, y = -32.804, z =  -450.794 },
    { x = -705.103, y = -31.291, z =  -372.666 },
    { x = -755.315, y = -30.373, z =  -420.765 },
    { x = -747.757, y = -30.220, z =  -451.413 },
    { x = -762.782, y = -32.000, z =  -396.991 },
    { x = -761.614, y = -31.683, z =  -389.636 },
    { x = -757.612, y = -31.638, z =  -468.737 },
    { x = -681.578, y = -31.431, z =  -411.597 },
    { x = -740.791, y = -31.196, z =  -474.806 },
    { x = -706.424, y = -31.100, z =  -471.294 },
    { x = -763.917, y = -31.391, z =  -456.188 },
    { x = -740.159, y = -30.523, z =  -370.074 },
    { x = -715.756, y = -31.205, z =  -474.926 },
    { x = -729.948, y = -30.918, z =  -473.787 },
    { x = -684.333, y = -31.075, z =  -451.765 },
    { x = -752.684, y = -31.514, z =  -468.267 },
    { x = -753.242, y = -31.516, z =  -469.220 },
    { x = -688.741, y = -29.117, z =  -406.312 },
    { x = -741.897, y = -31.500, z =  -469.452 },
    { x = -742.486, y = -31.125, z =  -361.306 },
    { x = -682.881, y = -31.647, z =  -402.822 },
    { x = -718.222, y = -31.610, z =  -363.180 },
    { x = -753.263, y = -30.658, z =  -409.927 },
    { x = -681.591, y = -31.441, z =  -386.368 },
    { x = -756.179, y = -31.152, z =  -428.418 },
    { x = -684.970, y = -31.566, z =  -371.229 },
    { x = -687.766, y = -31.201, z =  -467.353 },
    { x = -687.602, y = -30.415, z =  -432.963 },
    { x = -686.544, y = -29.245, z =  -410.142 },
    { x = -761.158, y = -31.248, z =  -375.569 },
    { x = -691.454, y = -31.628, z =  -362.358 },
    { x = -677.197, y = -32.000, z =  -443.500 },
    { x = -752.291, y = -30.438, z =  -398.885 },
    { x = -718.513, y = -32.000, z =  -360.126 },
    { x = -761.066, y = -31.122, z =  -422.411 },
    { x = -687.957, y = -30.687, z =  -429.768 },
    { x = -681.903, y = -31.171, z =  -376.607 },
    { x = -679.461, y = -31.114, z =  -422.262 },
    { x = -679.544, y = -31.819, z =  -432.354 },
    { x = -686.844, y = -30.652, z =  -396.784 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- When server restarts, reset timer

    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 2550) -- (https://ffxiclopedia.fandom.com/wiki/Simurgh)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.EVA, 400)
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            target:checkDistance(mob) > mob:getMeleeRange(target),
        },
        position = mob:getPos(),
        offset = 5,
        degrees = 180,
        wait = 3,
    }
    utils.drawIn(target, drawInTable)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.SIMURGH_POACHER)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
