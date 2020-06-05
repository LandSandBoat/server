-----------------------------------
-- Area: Carpenters' Landing
--   NM: Cryptonberry Executor
-- !pos 120.615 -5.457 -390.133 2
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
end

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        delay = 180,
        specials =
        {
            {
                id = tpz.jsa.MIJIN_GAKURE,
                hpp = 100,
                begCode = function(mob)
                    mob:messageText(mob, ID.text.CRYPTONBERRY_EXECUTOR_2HR)
                end,
            },
        },
    })
end

function onMobFight(mob, target)
    -- spawn Assassins when enmity is gained against Executor
    if mob:getLocalVar("spawnedAssassins") == 0 and mob:getCE(target) > 0 then
        mob:setLocalVar("spawnedAssassins", 1)
        SpawnMob(ID.mob.CRYPTONBERRY_EXECUTOR + 1)
        SpawnMob(ID.mob.CRYPTONBERRY_EXECUTOR + 2)
        SpawnMob(ID.mob.CRYPTONBERRY_EXECUTOR + 3)
    end
end

function onMobDeath(mob, player, isKiller)
    mob:messageText(mob, ID.text.CRYPTONBERRY_EXECUTOR_DIE)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.CALM_BEFORE_THE_STORM and player:getCharVar("Cryptonberry_Executor_KILL") < 2 then
        player:setCharVar("Cryptonberry_Executor_KILL", 1)
    end
end
