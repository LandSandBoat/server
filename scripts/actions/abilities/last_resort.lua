-----------------------------------
-- Ability: Last Resort
-- Description: Increases user's attack, but lowers defense.
-- Obtained: Dark Knight Level 15
-- Recast Time: 00:05:00
-- Duration: 00:03:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useLastResort(player, target, ability)
end

return abilityObject
