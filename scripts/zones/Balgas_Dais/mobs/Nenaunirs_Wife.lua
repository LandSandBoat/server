-----------------------------------
-- Area: Balgas Dais
-- Mob: Nenaunir's Wife
-- BCNM: Harem Scarem
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobEngage = function(mob, target)
    mob:useMobAbility(xi.mobSkill.BERSERK_DHALMEL)
end

-- Only uses Stomping as a weapon skill.
entity.onMobMobskillChoose = function(mob, target)
    return xi.mobSkill.STOMPING
end

return entity
