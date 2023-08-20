-----------------------------------
-- Flame Breath
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(pet, target, skill, action)
    return xi.job_utils.dragoon.useDamageBreath(pet, target, skill, action, xi.damageType.FIRE)
end

return abilityObject
