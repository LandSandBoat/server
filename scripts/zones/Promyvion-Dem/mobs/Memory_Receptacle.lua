-----------------------------------
-- Area: Promyvion-Dem
--   NM: Memory Receptacle
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:SetAutoAttackEnabled(false) -- Receptacles only use TP moves.
end

entity.onMobFight = function(mob, target)
    xi.promyvion.receptacleOnFight(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.promyvion.receptacleOnDeath(mob, isKiller)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.DEF, 55)
end

return entity
