-----------------------------------
-- Area: Castle Oztroja [S]
--   NM: Loo Kutto the Pensive
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  7.990, y = -16.500, z = -187.812 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(900, 10800))
end

entity.onMobFight = function(mob, target)
    --[[
    "Possess high Regain and/or Store TP, which seems to increase further as its HP declines."

    Using formula below, mob will have:
    at 100% HP, 20 storeTP
        75% HP, 80 storeTP
        50% HP, 140 storeTP
        25% HP, 200 storeTP (caps here - this is about 50% TP per greatsword swing)
    --]]
    local power = 20 + math.floor(utils.clamp(100 - mob:getHPP(), 0, 75) * 2.4)
    mob:setMod(xi.mod.STORETP, power)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
