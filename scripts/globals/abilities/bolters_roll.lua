-----------------------------------
-- Ability: Bolter's Roll
-- Increases Movement speed for party members with area of effect.
-- Optimal Job: None
-- Lucky Number: 3
-- Unlucky Number: 9
-- Level: 76
-- Phantom Roll +1 Value: 4
--
-- Die Roll    | %
-- --------    -------
-- 1           |+6
-- 2           |+6
-- 3           |+16
-- 4           |+8
-- 5           |+8
-- 6           |+10
-- 7           |+10
-- 8           |+12
-- 9           |+4
-- 10          |+14
-- 11          |+20
-- Bust        |0
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local effectID = tpz.effect.BOLTERS_ROLL
    ability:setRange(ability:getRange() + player:getMod(tpz.mod.ROLL_RANGE))
    if (player:hasStatusEffect(effectID)) then
        return tpz.msg.basic.ROLL_ALREADY_ACTIVE, 0
    elseif atMaxCorsairBusts(player) then
        return tpz.msg.basic.CANNOT_PERFORM, 0
    else
        return 0, 0
    end
end

function onUseAbility(caster, target, ability, action)
    if (caster:getID() == target:getID()) then
        corsairSetup(caster, ability, action, tpz.effect.BOLTERS_ROLL, tpz.job.COR)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return applyRoll(caster, target, ability, action, total)
end

function applyRoll(caster, target, ability, action, total)
    local duration = 300 + caster:getMerit(tpz.merit.WINNING_STREAK) + caster:getMod(tpz.mod.PHANTOM_DURATION)
    local effectpowers = {6, 6, 16, 8, 8, 10, 10, 12, 4, 14, 20, 0}
    local effectpower = effectpowers[total]
-- Apply Additional Phantom Roll+ Buff
    local phantomBase = 4 -- Base increment buff
    local effectpower = effectpower + (phantomBase * phantombuffMultiple(caster))
-- Check if COR Main or Sub
    if (caster:getMainJob() == tpz.job.COR and caster:getMainLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getMainLvl() / target:getMainLvl())
    elseif (caster:getSubJob() == tpz.job.COR and caster:getSubLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getSubLvl() / target:getMainLvl())
    end
    if (target:addCorsairRoll(caster:getMainJob(), caster:getMerit(tpz.merit.BUST_DURATION), tpz.effect.BOLTERS_ROLL, effectpower, 0, duration, caster:getID(), total, tpz.mod.MOVE) == false) then
        ability:setMsg(tpz.msg.basic.ROLL_MAIN_FAIL)
    elseif total > 11 then
        ability:setMsg(tpz.msg.basic.DOUBLEUP_BUST)
    end
    return total
end
