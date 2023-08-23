-----------------------------------
-- Ability: Dark Seal
-- Description: Enhances the accuracy of your next dark magic spell.
-- Obtained: Dark Knight Level 75
-- Recast Time: 00:05:00
-- Duration: 1 Spell or 60 seconds, whichever occurs first.
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dark_knight.useDarkSeal(player, target, ability)
end

return abilityObject
