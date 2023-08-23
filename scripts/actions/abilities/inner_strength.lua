-----------------------------------
-- Ability: Inner Strength
-- Description: Increases your maximum HP.
-- Obtained: MNK Level 96
-- Recast Time: 01:00:00
-- Duration: 0:00:30
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.monk.checkInnerStrength(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.monk.useInnerStrength(player, target, ability)
end

return abilityObject
