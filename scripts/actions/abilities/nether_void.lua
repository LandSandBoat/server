-----------------------------------
-- Ability: Nether Void
-- Description: Increases the absorption of your next dark magic spell.
-- Obtained: Dark Knight Level 78
-- Recast Time: 00:05:00
-- Duration: 00:01:00 or the next Dark Magic cast
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useNetherVoid(player, target, ability)
end

return abilityObject
