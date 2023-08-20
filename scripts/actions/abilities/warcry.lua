-----------------------------------
-- Ability: Warcry
-- Job: Warrior
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    return xi.job_utils.warrior.useWarcry(player, target, ability)
end

return abilityObject
