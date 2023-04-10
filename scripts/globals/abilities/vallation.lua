-----------------------------------
-- Ability: Vallation
-- Reduces elemental damage. The types of elemental damage reduced depend on the runes you harbor.
-- Obtained: Rune Fencer Level 10
-- Recast Time: 3:00
-- Duration: 2:00
-----------------------------------
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.rune_fencer.checkHaveRunes(player)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.rune_fencer.useVallationValiance(player, target, ability, action)
end

return abilityObject
