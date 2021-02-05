-----------------------------------
-- Ability: Rogue's Roll
-- Improves critical hit rate for party members within area of effect
-- Optimal Job: Thief
-- Lucky Number: 5
-- Unlucky Number: 9
-- Level: 43
-- Phantom Roll +1 Value: 1
--
-- Die Roll    |No THF  |With THF
-- --------    -------  -----------
-- 1           |2%      |8%
-- 2           |2%      |8%
-- 3           |3%      |9%
-- 4           |4%      |10%
-- 5           |12%     |18%
-- 6           |5%      |11%
-- 7           |6%      |12%
-- 8           |6%      |12%
-- 9           |1%      |7%
-- 10          |8%      |14%
-- 11          |19%     |25%
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
    local effectID = tpz.effect.ROGUES_ROLL
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
        corsair.corsairSetup(caster, ability, action, tpz.effect.ROGUES_ROLL, tpz.job.THF)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return corsair.applyRoll(caster, target, ability, action, total)
end

return ability_object
