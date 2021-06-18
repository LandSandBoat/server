-----------------------------------
-- Ability: Ignis
-- Increases resistance against ice and deals fire damage.
-- Obtained: Rune Fencer level 5
-- Recast Time: 0:05 (shared with all runes)
-- Duration: 5:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/job_utils/runefencer")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    return xi.job_utils.runefencer.runeEnchantment(player, target, ability, xi.effect.IGNIS)
end

return ability_object
