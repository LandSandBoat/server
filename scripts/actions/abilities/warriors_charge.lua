-----------------------------------
-- Ability: Warrior's Charge
-- Job: Warrior
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.warrior.useWarriorsCharge(player, target, ability)
end

return abilityObject
