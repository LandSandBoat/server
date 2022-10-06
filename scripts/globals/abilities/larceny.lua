-----------------------------------
-- Ability: Larceny
-- Description: Steals one beneficial effect from the target enemy.
-- Obtained: THF Level 96
-- Recast Time: 01:00:00
-----------------------------------
require("scripts/globals/job_utils/thief")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.thief.checkLarceny(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.thief.useLarceny(player, target, ability, action)
end

return abilityObject
