-----------------------------------
-- Ability: Contradance
-- Description: Increases the amount of HP restored by your next Waltz.
-- Obtained: DNC Level 50
-- Recast Time: 00:05:00
-- Duration: 00:01:00
-----------------------------------
require('scripts/globals/job_utils/dancer')
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dancer.checkContradanceAbility(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.dancer.useContradanceAbility(player, target, ability, action)
end

return abilityObject
