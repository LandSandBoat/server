-----------------------------------
-- Area: Garlaige Citadel (200)
--   NM: Serket
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -155.000, y =  19.000, z =  244.000 },
    { x = -123.968, y =  19.123, z =  196.309 },
    { x = -159.937, y =  19.034, z =  237.676 },
    { x = -165.156, y =  19.212, z =  230.020 },
    { x = -117.164, y =  19.000, z =  200.375 },
    { x = -165.160, y =  19.460, z =  220.486 },
    { x = -138.278, y =  19.750, z =  240.786 },
    { x = -127.813, y =  19.247, z =  240.123 },
    { x = -114.685, y =  19.445, z =  218.520 },
    { x = -160.123, y =  19.250, z =  205.139 },
    { x = -159.629, y =  19.408, z =  211.318 },
    { x = -121.179, y =  19.000, z =  197.685 },
    { x = -131.474, y =  19.438, z =  242.540 },
    { x = -164.159, y =  19.190, z =  235.805 },
    { x = -147.583, y =  19.412, z =  245.273 },
    { x = -139.063, y =  19.750, z =  198.544 },
    { x = -131.077, y =  19.378, z =  240.586 },
    { x = -136.678, y =  19.426, z =  244.692 },
    { x = -141.367, y =  19.146, z =  247.842 },
    { x = -143.110, y =  19.268, z =  193.103 },
    { x = -125.611, y =  19.180, z =  193.884 },
    { x = -116.376, y =  19.190, z =  205.379 },
    { x = -116.267, y =  19.519, z =  224.755 },
    { x = -117.685, y =  19.000, z =  239.765 },
    { x = -121.338, y =  19.000, z =  200.745 },
    { x = -155.791, y =  19.250, z =  199.302 },
    { x = -119.397, y =  19.250, z =  209.755 },
    { x = -114.963, y =  19.154, z =  204.267 },
    { x = -148.529, y =  19.427, z =  198.422 },
    { x = -138.026, y =  19.747, z =  241.748 },
    { x = -119.536, y =  19.500, z =  212.511 },
    { x = -119.085, y =  19.500, z =  225.520 },
    { x = -167.192, y =  19.157, z =  235.746 },
    { x = -126.718, y =  19.140, z =  246.689 },
    { x = -126.280, y =  19.115, z =  246.072 },
    { x = -143.935, y =  19.500, z =  240.142 },
    { x = -117.266, y =  19.000, z =  202.293 },
    { x = -139.057, y =  19.750, z =  199.460 },
    { x = -148.803, y =  19.392, z =  240.088 },
    { x = -114.629, y =  19.047, z =  237.230 },
    { x = -121.567, y =  19.000, z =  245.373 },
    { x = -155.056, y =  19.221, z =  242.651 },
    { x = -155.492, y =  19.250, z =  200.878 },
    { x = -133.576, y =  19.500, z =  200.166 },
    { x = -160.077, y =  19.000, z =  197.804 },
    { x = -129.743, y =  19.212, z =  201.519 },
    { x = -154.830, y =  19.167, z =  195.725 },
    { x = -143.700, y =  19.530, z =  240.467 },
    { x = -159.615, y =  19.250, z =  233.174 },
    { x = -132.043, y =  19.397, z =  244.589 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 86400))

    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.POISON)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 1800) -- 30 minutes
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) > mob:getMeleeRange(target),
        },
        position = mob:getPos(),
        wait = 3,
    }
    utils.drawIn(target, drawInTable)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.SERKET_BREAKER)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(75600, 86400)) -- 21 to 24 hours
end

return entity
