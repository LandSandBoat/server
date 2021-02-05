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
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.CHAOS_ROLL
    return corsair.onAbilityCheck(player, target, ability, effectID)
end

ability_object.onUseAbility = function(caster, target, ability, action)
    if caster:getID() == target:getID() then
        corsair.corsairSetup(caster, ability, action, tpz.effect.CHAOS_ROLL, tpz.job.DRK)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
