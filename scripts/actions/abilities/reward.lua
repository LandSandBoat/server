-----------------------------------
-- Ability: Reward
-- Feeds pet to restore its HP.
-- Obtained: Beastmaster Level 12
-- Recast Time: 1:30
-- Duration: Instant
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.beastmaster.checkReward(player, target, ability)
end

abilityObject.onUseAbility = function(player, target, ability, action)
    return xi.job_utils.beastmaster.useReward(player, target, ability)
end

return abilityObject
