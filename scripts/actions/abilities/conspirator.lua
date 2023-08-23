-----------------------------------
-- Ability: Conspirator
-- Enhances accuracy and "Subtle Blow" effect for party members within area of effect.
-- Does not affect the party member being targeted by the enemy.
-- Obtained: Thief Level 87
-- Recast Time: 5:00
-- Duration: 1:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.thief.useConspirator(player, target, ability)
end

return abilityObject
