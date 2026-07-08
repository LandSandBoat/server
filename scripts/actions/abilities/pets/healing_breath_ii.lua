-----------------------------------
-- Healing Breath II
-----------------------------------
---@type TAbilityPet
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, petskill, owner, action)
    return xi.job_utils.dragoon.useHealingBreath(pet, target, petskill, action)
end

return abilityObject
