-----------------------------------
-- Area: Promyvion-Mea
--   NM: Memory Receptacle
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:SetAutoAttackEnabled(false) -- Receptacles only use TP moves.
end

entity.onMobFight = function(mob, target)
    tpz.promyvion.receptacleOnFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
    tpz.promyvion.receptacleOnDeath(mob, isKiller)
end

return entity
