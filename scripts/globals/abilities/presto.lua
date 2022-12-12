-----------------------------------
-- Ability: Presto
-- Description Enhances the effect of your next step and grants you an additional finishing move.
-- Obtained: DNC Level 77
-- Recast Time: 00:00:15 (Step)
-- Duration: 00:00:30
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dancer.usePrestoAbility(player, target, ability)
end

return abilityObject
