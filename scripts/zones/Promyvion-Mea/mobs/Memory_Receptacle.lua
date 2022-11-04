-----------------------------------
-- Area: Promyvion-Mea
--   NM: Memory Receptacle
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:SetAutoAttackEnabled(false) -- Receptacles only use TP moves.
    mob:addMod(xi.mod.DEF, 50)
    mob:addMod(xi.mod.REGAIN, 100)
end

entity.onMobEngage = function(mob)
    mob:addTP(3000)
end

entity.onMobFight = function(mob, target)
    xi.promyvion.receptacleOnFight(mob, target)
end

entity.onMobRoam = function(mob)
    xi.promyvion.receptacleIdle(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.promyvion.receptacleOnDeath(mob, optParams)
end

return entity
