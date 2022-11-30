-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'xzomit
-- Note: Pet for JOJ
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:timer(math.random(7500, 10000),
        function(mobArg)
            mobArg:useMobAbility(xi.jsa.MIJIN_GAKURE)
            mobArg:timer((2000),
            function(mobArg2)
                mobArg2:setHP(0)
            end)
        end)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 60)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
