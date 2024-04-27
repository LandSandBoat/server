-----------------------------------
-- Ability: Gauge
-- Checks to see if an enemy can be charmed.
-- Obtained: Beastmaster Level 10
-- Recast Time: 0:30
-- Duration: Instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.onAbilityCheckGauge(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.beastmaster.onUseAbilityGauge(player, target, ability)
end

return abilityObject
