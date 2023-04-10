-----------------------------------
-- Ability: Chaos Roll
-- Enhances attack for party members within area of effect
-- Optimal Job: Dark Knight
-- Lucky Number: 4
-- Unlucky Number: 8
-- Level: 14
-- Phantom Roll +1 Value: 3
--
-- Die Roll    |No DRK    |With DRK
-- --------    -------- -----------
-- 1           |6%      |16%
-- 2           |8%      |18%
-- 3           |9%      |19%
-- 4           |25%     |35%
-- 5           |11%     |21%
-- 6           |13%     |23%
-- 7           |16%     |26%
-- 8           |3%      |13%
-- 9           |17%     |27%
-- 10          |19%     |29%
-- 11          |31%     |41%
-- Bust        |-10%    |-10%
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
