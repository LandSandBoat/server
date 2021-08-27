-----------------------------------
-- Area: Carpenters' Landing
--   NM: Cryptonberry Executor
-- !pos 120.615 -5.457 -390.133 2
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
end

entity.onMobSpawn = function(mob)
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
    if mob:getLocalVar("spawnedAssassins") == 0 and mob:getCE(target) > 0 then
        mob:setLocalVar("spawnedAssassins", 1)
        SpawnMob(ID.mob.CRYPTONBERRY_EXECUTOR + 1)
        SpawnMob(ID.mob.CRYPTONBERRY_EXECUTOR + 2)
        SpawnMob(ID.mob.CRYPTONBERRY_EXECUTOR + 3)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:messageText(mob, ID.text.CRYPTONBERRY_EXECUTOR_DIE)
    if player:getCurrentMission(COP) == xi.mission.id.cop.CALM_BEFORE_THE_STORM and player:getCharVar("Cryptonberry_Executor_KILL") < 2 then
        player:setCharVar("Cryptonberry_Executor_KILL", 1)
    end
end

return entity
