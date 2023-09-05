-----------------------------------
-- Ability: Feather Step
-- Description Lowers a target's critical hit evasion. If successful, will earn you a finishing move.
-- Obtained: DNC Level 83
-- Recast Time: 00:00:05 (Step)
-- Duration: 00:01:00
-- Cost: 100TP
-----------------------------------
require('scripts/globals/job_utils/dancer')
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dancer.checkStepAbility(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.dancer.useStepAbility(player, target, ability, action, xi.effect.BEWILDERED_DAZE_1, 2, 6)
end

return abilityObject
