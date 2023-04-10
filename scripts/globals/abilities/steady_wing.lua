-----------------------------------
-- Ability: Steady Wing
-- Creates a barrier that temporarily absorbs a certain amount of damage dealt to your wyvern.
-- Obtained: Dragoon Level 95
-- Recast Time: 05:00
-- Duration:    03:00
-----------------------------------
require("scripts/globals/job_utils/dragoon")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    -- You can't actually use Steady Wing on retail unless your wyvern is up
    -- This is on the pet menu, but just in case...
    return xi.job_utils.dragoon.abilityCheckRequiresPet(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.dragoon.useSteadyWing(player, target, ability, action)
end

return abilityObject
