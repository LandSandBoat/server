-----------------------------------
-- Ability: Curing Waltz II
-- Heals HP to target player.
-- Obtained: Dancer Level 30
-- TP Required: 35%
-- Recast Time: 00:08
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.dancer.checkWaltzAbility(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.dancer.useWaltzAbility(player, target, ability, action)
end

return abilityObject
