-----------------------------------
-- Ability: Smiting Breath
-- Orders the wyvern to attack with its breath.
-- Obtained: Dragoon Level 90
-- Recast Time: 01:00
-- Duration: instant
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    -- You can't actually use Restoring Breath on retail unless your wyvern is up
    -- This is on the pet menu, but just in case...
    return xi.job_utils.dragoon.abilityCheckRequiresPet(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    xi.job_utils.dragoon.useSmitingBreath(player, target, ability, action, true)
end

return abilityObject
