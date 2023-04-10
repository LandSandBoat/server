-----------------------------------
-- Ability: Vivacious Pulse
-- Restores the caster's HP.
-- Obtained: Rune Fencer Level 65
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/rune_fencer")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.rune_fencer.useVivaciousPulse(player, target, ability)
end

return abilityObject
