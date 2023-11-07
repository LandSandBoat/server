-----------------------------------
-- Area: Al'Taieu
--  Mob: Qn'xzomit
-- Note: Pet for JOJ
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob)
    mob:timer(30000, function(mobArg)
        if mobArg:isAlive() then
            mobArg:useMobAbility(xi.jsa.MIJIN_GAKURE)
            mobArg:timer(2000, function(mobArg2)
                mobArg2:setHP(0)
            end)
        end
    end)

    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:addStatusEffectEx(xi.effect.FLEE, 0, 100, 0, 60)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
