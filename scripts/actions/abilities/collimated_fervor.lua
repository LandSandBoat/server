-----------------------------------
-- Ability: Collimated Fervor
-- Enhances cardinal chant effects for party members within area of effect.
-- Obtained: Geomancer Level 40
-- Recast Time: 00:05:00
-- Duration: 00:01:00
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.geomancer.collimatedFervor(player, target, ability)
end

return abilityObject
