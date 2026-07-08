-----------------------------------
-- Ability: Theurgic Focus
-- Increases the power of your next applicable elemental magic spell. Casting range and area of effect are reduced by half.
-- Obtained: Geomancer Level 80
-- Recast Time: 00:05:00
-- Duration: 00:01:00 or next elemental magic spell.
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.geomancer.geoOnTheurgicFocusCheck(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.geomancer.theurgicFocus(player, ability, action)
end

return abilityObject
