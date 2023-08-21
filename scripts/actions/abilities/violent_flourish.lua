-----------------------------------
-- Ability: Violent Flourish
-- Stuns target with a low rate of success. Requires one Finishing Move.
-- Obtained: Dancer Level 45
-- Finishing Moves Used: 1
-- Recast Time: 0:20
-- Duration: ??
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dancer.checkFlourishAbility(player, target, ability, true, 1)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.dancer.useViolentFlourishAbility(player, target, ability, action)
end

return abilityObject
