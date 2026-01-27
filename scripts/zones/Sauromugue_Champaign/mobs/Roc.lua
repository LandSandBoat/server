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
    { x =  213.997, y = -1.672, z = -255.685 },
    { x =  205.831, y = -0.116, z = -243.033 },
    { x =  197.226, y =  0.757, z = -295.616 },
    { x =  198.305, y =  0.916, z = -258.350 },
    { x =  203.876, y =  0.000, z = -236.865 },
    { x =  209.015, y =  0.491, z = -224.618 },
    { x =  196.563, y =  0.134, z = -273.294 },
    { x =  173.726, y =  0.565, z = -244.018 },
    { x =  202.205, y =  0.247, z = -271.049 },
    { x =  195.317, y =  0.111, z = -287.885 },
    { x =  153.669, y =  0.145, z = -226.129 },
    { x =  206.695, y = -0.034, z = -267.380 },
    { x =  197.310, y =  0.167, z = -272.637 },
    { x =  188.566, y = -1.168, z = -296.794 },
    { x =  215.711, y =  0.404, z = -312.421 },
    { x =  212.596, y = -0.216, z = -249.303 },
    { x =  189.023, y =  0.348, z = -196.885 },
    { x =  195.192, y = -0.067, z = -194.328 },
    { x =  199.956, y =  0.000, z = -278.615 },
    { x =  191.796, y =  0.263, z = -250.968 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 7200))

    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    mob:setMod(xi.mod.EVA, 400)
    mob:setMod(xi.mod.ATT, 325)
    mob:setMod(xi.mod.ACC, 525)
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
