-----------------------------------
-- Ability: Convergence
-- Increases the power of your next magical blue magic spell. Limits area of effect to single target.
-- Obtained: Blue Mage Level 75
-- Recast Time: 10:00
-- Duration: 1:00, or until the next eligible blue magic spell is cast.
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.blue_mage.checkConvergence(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.blue_mage.useConvergence(player, target, ability, action)
end

return abilityObject
