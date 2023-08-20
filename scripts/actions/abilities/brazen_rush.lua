-----------------------------------
-- Ability: Brazen Rush
-- Job: Warrior
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.warrior.checkBrazenRush(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.warrior.useBrazenRush(player, target, ability)
end

return abilityObject
