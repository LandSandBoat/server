-----------------------------------
-- Healing Breath IV
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(pet, target, skill, action)
    return xi.job_utils.dragoon.useHealingBreath(pet, target, skill, action)
end

return abilityObject
