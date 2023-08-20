-----------------------------------
-- Ability: Box Step
-- Lowers target's defense. If successful, you will earn two Finishing Moves.
-- Obtained: Dancer Level 30
-- TP Required: 10%
-- Recast Time: 00:05
-- Duration: First Step lasts 1 minute, each following Step extends its current duration by 30 seconds.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dancer.checkStepAbility(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.dancer.useStepAbility(player, target, ability, action, xi.effect.SLUGGISH_DAZE_1, 2, 6)
end

return abilityObject
