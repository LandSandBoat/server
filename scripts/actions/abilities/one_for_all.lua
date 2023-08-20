-----------------------------------
-- Ability: One for All
-- Grants a Magic Shield effect for party members within area of effect.
-- Obtained: Rune Fencer Level 95
-- Recast Time: 0:30
-- Duration: 5:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.rune_fencer.useOneForAll(player, target, ability, action)
end

return abilityObject
