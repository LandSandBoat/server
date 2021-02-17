-----------------------------------
-- Ability: Dragon Breaker
-- Description: Lowers accuracy, evasion, magic accuracy, magic evasion and TP gain for dragons.
-- Obtained: DRG Level 87
-- Recast Time: 00:05:00
-- Duration: 00:03:00
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    tpz.job_utils.dragoon.useDragonBreaker(player, target, ability)
end

return ability_object
