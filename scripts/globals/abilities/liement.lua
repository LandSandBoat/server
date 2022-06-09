-----------------------------------
-- Ability: Liement
-- Absorbs elemental damage. The types of elemental damage absorbed depend on the runes you harbor.
-- Obtained: Rune Fencer Level 85
-- Recast Time: 3:00
-- Duration: 10 seconds or first absorb
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.rune_fencer.checkHaveRunes(player)
end

ability_object.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.rune_fencer.useLiement(player, target, ability, action)
end

return ability_object
