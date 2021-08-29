-----------------------------------
-- Ability: Unda
-- Increases resistance against fire and deals water damage.
-- Obtained: Rune Fencer Level 5
-- Recast Time: 0:05
-- Duration: 5:00
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    return xi.job_utils.rune_fencer.runeEnchantment(player, target, ability, xi.effect.UNDA)
end

return ability_object
