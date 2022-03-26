-----------------------------------
-- Ability: Gambit
-- Expends all runes harbored to reduce an enemy's elemental defense. The types of elemental defense reduced depend on the runes you harbor.
-- Obtained: Rune Fencer level 70
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.rune_fencer.checkHaveRunes(player)
end

ability_object.onUseAbility = function(player, target, ability, action)
    xi.job_utils.rune_fencer.useGambit(player, target, ability, action)
end

return ability_object
