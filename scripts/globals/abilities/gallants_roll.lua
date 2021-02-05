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
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.GALLANTS_ROLL
    return corsair.onRollAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    local effectID = tpz.effect.GALLANTS_ROLL
    local bonusJob = tpz.job.PLD
    return corsair.onRollUseAbility(caster, target, ability, action, effectID, bonusJob)
end

return ability_object
