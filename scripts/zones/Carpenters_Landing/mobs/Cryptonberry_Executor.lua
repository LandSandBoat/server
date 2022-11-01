-----------------------------------
-- Area: Carpenters' Landing
--   NM: Cryptonberry Executor
-- !pos 120.615 -5.457 -390.133 2
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("addSpawnTimer", os.time() + 20)

    xi.mix.jobSpecial.config(mob, {
        delay = 180,
        specials =
        {
            {
                id = xi.jsa.MIJIN_GAKURE,
                hpp = 100,
                begCode = function(mobArg)
                    mobArg:messageText(mobArg, ID.text.CRYPTONBERRY_EXECUTOR_2HR)
                end,
            },
        },
    })
end

entity.onMobFight = function(mob, target)
    -- spawn Assassins when enmity is gained against Executor
    if
        mob:getLocalVar("spawnedAssassins") == 0 and
        mob:getCE(target) > 0 and
        mob:getLocalVar("addSpawnTimer") < os.time()
    then
        mob:setLocalVar("spawnedAssassins", 1)
        local tp = mob:getTP()
        mob:useMobAbility(625) -- 2hr dust cloud to spawn assassins
        mob:addTP(tp)
        for i = 1, 3 do
            SpawnMob(ID.mob.CRYPTONBERRY_EXECUTOR + i)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
