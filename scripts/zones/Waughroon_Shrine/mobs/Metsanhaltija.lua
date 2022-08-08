-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Metsanhaltija
-- BCNM: Grove Guardians
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 50)
end

entity.onMobEngaged = function(mob, target)
    mob:timer(3000, function(mobArg)
        mobArg:useMobAbility(686)
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
