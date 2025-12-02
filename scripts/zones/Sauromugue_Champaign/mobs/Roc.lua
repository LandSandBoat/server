-----------------------------------
-- Area: Sauromugue Champaign (120)
--  HNM: Roc
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
    { x =  232.000, y = -0.010, z = -327.000 },
    { x =  213.997, y = -1.672, z = -255.685 },
    { x =  260.032, y = -1.617, z = -306.151 },
    { x =  279.663, y =  0.200, z = -328.021 },
    { x =  308.569, y = -0.448, z = -295.158 },
    { x =  205.831, y = -0.116, z = -243.033 },
    { x =  197.226, y =  0.757, z = -295.616 },
    { x =  367.044, y = -0.148, z = -309.743 },
    { x =  198.305, y =  0.916, z = -258.350 },
    { x =  252.489, y =  0.600, z = -328.980 },
    { x =  203.876, y =  0.000, z = -236.865 },
    { x =  240.723, y =  0.256, z = -310.858 },
    { x =  255.410, y =  0.180, z = -340.951 },
    { x =  209.015, y =  0.491, z = -224.618 },
    { x =  196.563, y =  0.134, z = -273.294 },
    { x =  266.925, y =  0.103, z = -330.613 },
    { x =  200.236, y =  0.932, z = -298.671 },
    { x =  212.020, y = -0.019, z = -235.566 },
    { x =  216.767, y = -0.868, z = -250.954 },
    { x =  277.400, y =  0.250, z = -350.978 },
    { x =  209.989, y = -0.117, z = -244.348 },
    { x =  214.700, y = -1.369, z = -264.888 },
    { x =  173.726, y =  0.565, z = -244.018 },
    { x =  202.205, y =  0.247, z = -271.049 },
    { x =  229.122, y =  0.343, z = -320.375 },
    { x =  210.545, y = -0.093, z = -238.031 },
    { x =  211.885, y =  0.092, z = -273.763 },
    { x =  235.673, y = -0.025, z = -263.352 },
    { x =  195.317, y =  0.111, z = -287.885 },
    { x =  153.669, y =  0.145, z = -226.129 },
    { x =  206.695, y = -0.034, z = -267.380 },
    { x =  270.178, y =  0.277, z = -334.811 },
    { x =  300.981, y = -1.754, z = -305.046 },
    { x =  240.526, y =  0.000, z = -323.063 },
    { x =  197.310, y =  0.167, z = -272.637 },
    { x =  354.299, y =  0.084, z = -280.288 },
    { x =  188.566, y = -1.168, z = -296.794 },
    { x =  263.840, y =  0.807, z = -321.000 },
    { x =  215.711, y =  0.404, z = -312.421 },
    { x =  212.596, y = -0.216, z = -249.303 },
    { x =  189.023, y =  0.348, z = -196.885 },
    { x =  260.332, y =  0.510, z = -332.862 },
    { x =  195.192, y = -0.067, z = -194.328 },
    { x =  199.956, y =  0.000, z = -278.615 },
    { x =  346.999, y =  0.496, z = -318.475 },
    { x =  266.687, y =  0.051, z = -346.511 },
    { x =  191.796, y =  0.263, z = -250.968 },
    { x =  304.025, y =  0.638, z = -326.122 },
    { x =  248.637, y = -0.510, z = -355.112 },
    { x =  321.210, y =  0.000, z = -282.105 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 7200))

    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
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
        offset = 10,
        degrees = 180,
        wait = 15,
    }
    utils.drawIn(target, drawInTable)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ROC_STAR)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
