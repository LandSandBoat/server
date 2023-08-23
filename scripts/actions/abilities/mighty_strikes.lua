-----------------------------------
-- Ability: Mighty Strikes
-- Job: Warrior
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.warrior.checkMightyStrikes(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.warrior.useMightyStrikes(player, target, ability)
end

return abilityObject
