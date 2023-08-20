-----------------------------------
-- Ability: Assassin's Charge
-- Will triple your next attack.
-- Obtained: Thief Level 75
-- Recast Time: 5:00
-- Duration: 1:00 minute
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    xi.job_utils.thief.useAssassinsCharge(player, target, ability)
end

return abilityObject
