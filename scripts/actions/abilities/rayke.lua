-----------------------------------
-- Ability: Rayke
-- Expends runes to reduce elemental resistance of the target.
-- Obtained: Rune Fencer level 75 (merit ability)
-- Recast Time: 5:00
-- Duration: 0:30 + an additional 3 for every merit after the first
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.rune_fencer.checkHaveRunes(player)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.rune_fencer.useRayke(player, target, ability, action)
end

return abilityObject
