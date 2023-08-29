-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Metsanneitsyt
-- BCNM: Grove Guardians
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

entity.onMobDeath = function(mob, player, optParams)
end

return entity
