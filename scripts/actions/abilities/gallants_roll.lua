-----------------------------------
-- Ability: Gallant's Roll
-- Enhances defense for party members within area of effect
-- Optimal Job: Paladin
-- Lucky Number: 3
-- Unlucky Number: 7
-- Level: 55
-- Phantom Roll +1 Value: 2
--
-- Die Roll    |No PLD  |With PLD
-- --------    -------  -----------
-- 1           |4%      |15%
-- 2           |5%      |16%
-- 3           |19%     |30%
-- 4           |7%      |18%
-- 5           |8%      |19%
-- 6           |10%     |21%
-- 7           |3%      |14%
-- 8           |11%     |22%
-- 9           |13%     |24%
-- 10          |15%     |26%
-- 11          |23%     |34%
-- Bust        |-11%    |-11%
-----------------------------------
---@type TAbility
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.onRollAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    return xi.job_utils.corsair.onRollUseAbility(caster, target, ability, action)
end

return abilityObject
