-----------------------------------
-- Ability: Warrior's Charge
-- Job: Warrior
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.warrior.useWarriorsCharge(player, target, ability, action)
end

return abilityObject
