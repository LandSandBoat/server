-----------------------------------
-- Ability: Tellus
-- Increases resistance against lightning and deals earth damage.
-- Obtained: Rune Fencer Level 5
-- Recast Time: 0:05
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
    return xi.job_utils.runefencer.runeEnchantment(player, target, ability, xi.effect.TELLUS)
end

return ability_object
