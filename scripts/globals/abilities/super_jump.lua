-----------------------------------
-- Ability: Super Jump
-- Performs a super jump.
-- Obtained: Dragoon Level 50
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    tpz.job_utils.dragoon.useSuperJump(player, target, ability)
end

return ability_object
