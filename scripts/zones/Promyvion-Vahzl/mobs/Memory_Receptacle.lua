-----------------------------------
-- Area: Promyvion-Vahzl
--   NM: Memory Receptacle
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setAutoAttackEnabled(false) -- Receptacles only use TP moves.
end

entity.onMobFight = function(mob, target)
    xi.promyvion.receptacleOnFight(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.promyvion.receptacleOnDeath(mob, optParams)
end

return entity
