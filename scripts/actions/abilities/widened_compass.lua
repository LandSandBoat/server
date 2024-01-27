-----------------------------------
-- Ability: Widened Compass
-- Increases the area of effect for geomancy spells.
-- Obtained: Geomancer Level 96
-- Recast Time: 1:00:00
-- Duration: 0:60
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.geomancer.widenedCompass(player, target, ability)
end

return abilityObject
