-----------------------------------
-- Ability: Liement
-- Absorbs elemental damage. The types of elemental damage absorbed depend on the runes you harbor.
-- Obtained: Rune Fencer Level 85
-- Recast Time: 3:00
-- Duration: 10 seconds or first absorb
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.rune_fencer.checkHaveRunes(player)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.rune_fencer.useLiement(player, target, ability, action)
end

return abilityObject
