-----------------------------------
-- Soothing Ruby
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(pet:getMaster(), pet, target, petskill)
    return xi.job_utils.summoner.useSoothingRuby(target, pet, petskill, summoner, action)
end

return abilityObject
