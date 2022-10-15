-----------------------------------
-- Ability: Bully
-- Intimidates target. (About 15% proc rate)
-- Removes the direction requirement from Sneak Attack for main job Thieves when active.
-- Obtained: Thief Level 93
-- Recast Time: 3:00
-- Duration: 0:30
-----------------------------------
require("scripts/globals/job_utils/thief")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.thief.useBully(player, target, ability)
end

return abilityObject
