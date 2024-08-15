-----------------------------------
-- Ability: Unbridled Learning
-- Description: Allows access to additional blue magic spells.
-- Obtained: BLU Level 95
-- Recast Time: 00:05:00
-- Duration: 00:01:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.blue_mage.checkUnbridledLearning(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.blue_mage.useUnbridledLearning(player, target, ability, action)
end

return abilityObject
