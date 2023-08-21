-----------------------------------
-- Ability: Animated Flourish
-- Provokes the target. Requires at least one, but uses two Finishing Moves.
-- Obtained: Dancer Level 20
-- Finishing Moves Used: 1-2
-- Recast Time: 00:30
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dancer.checkFlourishAbility(player, target, ability, false, 1)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.dancer.useAnimatedFlourishAbility(player, target, ability)
end

return abilityObject
