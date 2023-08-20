-----------------------------------
-- Ability: Diabolic Eye
-- Description: Reduces max. HP, increases accuracy.
-- Obtained: Dark Knight Level 75
-- Recast Time: 00:05:00
-- Duration: 00:03:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useDiabolicEye(player, target, ability)
end

return abilityObject
