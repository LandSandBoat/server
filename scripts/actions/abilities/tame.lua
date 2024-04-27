-----------------------------------
-- Ability: Tame
-- Makes target docile and more susceptible to charm.
-- Obtained: Beastmaster Level 30
-- Recast Time: 10:00
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.onAbilityCheckTame(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.beastmaster.onUseAbilityTame(player, target, ability)
end

return abilityObject
