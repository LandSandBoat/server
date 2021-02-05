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
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
local corsair = require("scripts/globals/job_utils/corsair")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    local effectID = tpz.effect.FIGHTERS_ROLL
    ability:setRange(ability:getRange() + player:getMod(tpz.mod.ROLL_RANGE))
    if player:hasStatusEffect(effectID) then
        return tpz.msg.basic.ROLL_ALREADY_ACTIVE, 0
    elseif corsair.atMaxCorsairBusts(player) then
        return tpz.msg.basic.CANNOT_PERFORM, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(caster, target, ability, action)
    if caster:getID() == target:getID() then
        corsair.corsairSetup(caster, ability, action, tpz.effect.FIGHTERS_ROLL, tpz.job.WAR)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
