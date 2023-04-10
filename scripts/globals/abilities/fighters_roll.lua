-----------------------------------
-- Ability: Fighter's Roll
-- Improves "Double Attack" rate for party members within area of effect
-- Optimal Job: Warrior
-- Lucky Number: 5
-- Unlucky Number: 9
-- Level: 49
-- Phantom Roll +1 Value: 1
--
-- Die Roll    |No WAR  |With WAR
-- --------    -------- -----------
-- 1           |2%      |8%
-- 2           |2%      |8%
-- 3           |3%      |9%
-- 4           |4%      |10%
-- 5           |12%     |18%
-- 6           |5%      |11%
-- 7           |6%      |12%
-- 8           |7%      |13%
-- 9           |1%      |7%
-- 10          |9%      |15%
-- 11          |18%     |24%
-- 12+         |-6%     |-6%
-----------------------------------
require("scripts/globals/job_utils/corsair")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.corsair.onRollAbilityCheck(player, target, ability)
end

abilityObject.onUseAbility = function(caster, target, ability, action)
    return xi.job_utils.corsair.onRollUseAbility(caster, target, ability, action)
end

return abilityObject
