-----------------------------------
-- Area: Qu'Bia Arena
-- Mob: Generic Doll
-- BCNM: Factory Rejects
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("control", 0)
end

entity.onMobFight = function(mob, target)
    if not mob:hasStatusEffect(xi.effect.SHOCK_SPIKES) and mob:getLocalVar("control") == 0 then
        mob:setLocalVar("control", 1)
        mob:castSpell(251, mob) -- shock spikes
        mob:timer(15000, function(mobArg1)
            mobArg1:setLocalVar("control", 0)
        end)
    end
end

entity.onMobDeath = function(mob)
end

return entity
