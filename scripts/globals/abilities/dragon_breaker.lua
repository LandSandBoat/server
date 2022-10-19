-----------------------------------
-- Ability: Dragon Breaker
-- Description: Lowers accuracy, evasion, magic accuracy, magic evasion and TP gain for dragons.
-- Obtained: DRG Level 87
-- Recast Time: 00:05:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.dragoon.useDragonBreaker(player, target, ability)
end

return abilityObject
