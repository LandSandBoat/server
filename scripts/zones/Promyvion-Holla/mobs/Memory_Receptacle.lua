-----------------------------------
-- Area: Promyvion-Holla
--   NM: Memory Receptacle
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:SetAutoAttackEnabled(false) -- Receptacles only use TP moves.
    mob:addMod(xi.mod.DEF, 55)
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
