-----------------------------------
-- Ability: Pflug
-- Enhances resistance. The types of resistance enhanced depend upon the runes you harbor.
-- Obtained: Rune Fencer Level 40
-- Recast Time: 3:00
-- Duration: 2:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.rune_fencer.checkHaveRunes(player)
end

ability_object.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.rune_fencer.usePflug(player, target, ability, action)
end

return ability_object
