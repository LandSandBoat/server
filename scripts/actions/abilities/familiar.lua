-----------------------------------
-- Ability: Familiar
-- Enhances your pet's powers and increases the duration of Charm.
-- Obtained: Beastmaster Level 1
-- Recast Time: 1:00:00
-- Duration: 0:30:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.onAbilityCheckFamiliar(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.beastmaster.onUseAbilityFamiliar(player, target, ability)
end

return abilityObject
