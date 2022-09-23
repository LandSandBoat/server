-----------------------------------
-- Ability: Vivacious Pulse
-- Restores the caster's HP.
-- Obtained: Rune Fencer Level 65
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.rune_fencer.useVivaciousPulse(player, target, ability)
end

return ability_object

