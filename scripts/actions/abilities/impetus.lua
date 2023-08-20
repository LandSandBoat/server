-----------------------------------
-- Ability: Impetus
-- Description: Enhances attack and critical hit rate with each successive melee attack you land.
-- Obtained: MNK Level 88
-- Recast Time: 00:05:00
-- Duration: 0:03:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.monk.useImpetus(player, target, ability)
end

return abilityObject
