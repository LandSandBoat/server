-----------------------------------
-- Ability: Heel
-- Commands the pet to cease attacking and return to you.
-- Obtained: Beastmaster Level 10
-- Recast Time: 5 seconds
-- Duration: N/A
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.onAbilityCheckNilPet(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.beastmaster.onUseAbilityHeel(player, target, ability)
end

return abilityObject
