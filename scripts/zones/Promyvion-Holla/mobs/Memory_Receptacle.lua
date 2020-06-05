-----------------------------------
-- Area: Promyvion-Holla
--   NM: Memory Receptacle
-----------------------------------
require("scripts/globals/promyvion")
-----------------------------------

function onMobInitialize(mob)
    mob:SetAutoAttackEnabled(false) -- Receptacles only use TP moves.
end

function onMobFight(mob, target)
    tpz.promyvion.receptacleOnFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
    tpz.promyvion.receptacleOnDeath(mob, isKiller)
end
