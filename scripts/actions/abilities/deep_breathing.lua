-----------------------------------
-- Ability: Deep Breathing
-- Enhances the effect of next breath used by wyvern.
-- Obtained: Dragoon Level 75
-- Recast Time: 5 minutes
-- Duration: 0:03:00 or until the next breath is executed
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dragoon.abilityCheckDeepBreathing(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dragoon.useDeepBreathing(player, target, ability)
end

return abilityObject
