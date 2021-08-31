-----------------------------------
-- Ability: Jump
-- Delivers a short jumping attack on a targeted enemy.
-- Obtained: Dragoon Level 10
-- Recast Time: 1:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.dragoon.useJump(player, target, ability, action)
end

return ability_object
