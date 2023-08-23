-----------------------------------
-- Ability: Gallant's Roll
-- Reduces physical damage taken by party members within area of effect
-- Optimal Job: Paladin
-- Lucky Number: 3
-- Unlucky Number: 7
-- Level: 55
-- Phantom Roll +1 Value: 2.34
--
-- Die Roll    |No PLD  |With PLD
-- --------    -------  -----------
-- 1           |6%      |11%
-- 2           |8%      |13%
-- 3           |24%     |29%
-- 4           |9%      |14%
-- 5           |11%     |16%
-- 6           |12%     |17%
-- 7           |3%      |8%
-- 8           |15%     |20%
-- 9           |17%     |22%
-- 10          |18%     |23%
-- 11          |30%     |35%
-- Bust        |-5%     |-5%
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.onRollAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    return xi.job_utils.corsair.onRollUseAbility(caster, target, ability, action)
end

return abilityObject
