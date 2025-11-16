-----------------------------------
-- Frost Breath
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, petskill, owner, action)
    return xi.job_utils.dragoon.useDamageBreath(pet, target, petskill, action, xi.damageType.ICE)
end

return abilityObject
