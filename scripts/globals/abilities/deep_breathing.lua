-----------------------------------
-- Ability: Deep Breathing
-- Enhances the effect of next breath used by wyvern.
-- Obtained: Dragoon Level 75
-- Recast Time: 5 minutes
-- Duration: 0:03:00 or until the next breath is executed
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return tpz.job_utils.dragoon.abilityCheckDeepBreathing(player, target, ability)
end

ability_object.onUseAbility = function(player, target, ability)
    tpz.job_utils.dragoon.useDeepBreathing(player, target, ability)
end

return ability_object
