-----------------------------------
-- Ability: Naturalists's Roll
-- Increases the duration of enhancing magic effects received for party members within area of effect.
-- Optimal Job: Geomancer
-- Lucky Number: 3
-- Unlucky Number: 7
-- Level: 67
-- Phantom Roll +1 Value: 1
--
-- Die Roll    | Duration %
-- --------    -------
-- 1           |+6
-- 2           |+7
-- 3           |+15
-- 4           |+8
-- 5           |+9
-- 6           |+10
-- 7           |+5
-- 8           |+11
-- 9           |+12
-- 10          |+13
-- 11          |+20
-- Bust        |-5
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local effectID = tpz.effect.NATURALISTS_ROLL
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
        corsairSetup(caster, ability, action, tpz.effect.NATURALISTS_ROLL, tpz.job.GEO)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return applyRoll(caster, target, ability, action, total)
end

function applyRoll(caster, target, ability, action, total)
    local duration = 300 + caster:getMerit(tpz.merit.WINNING_STREAK) + caster:getMod(tpz.mod.PHANTOM_DURATION)
    local effectpowers = {6, 7, 15, 8, 9, 10, 5, 11, 12, 13, 20, -5}
    local effectpower = effectpowers[total]
    if (caster:getLocalVar("corsairRollBonus") == 1 and total < 12) then -- TODO Add logic for Phantom Roll +
        effectpower = effectpower + 5
    end
-- Apply Additional Phantom Roll+ Buff
    local phantomBase = 1 -- Base increment buff
    local effectpower = effectpower + (phantomBase * phantombuffMultiple(caster))
-- Check if COR Main or Sub
    if (caster:getMainJob() == tpz.job.COR and caster:getMainLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getMainLvl() / target:getMainLvl())
    elseif (caster:getSubJob() == tpz.job.COR and caster:getSubLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getSubLvl() / target:getMainLvl())
    end
    if (target:addCorsairRoll(caster:getMainJob(), caster:getMerit(tpz.merit.BUST_DURATION), tpz.effect.NATURALISTS_ROLL, effectpower, 0, duration, caster:getID(), total, tpz.mod.ENH_MAGIC_DURATION) == false) then
        ability:setMsg(tpz.msg.basic.ROLL_MAIN_FAIL)
    elseif total > 11 then
        ability:setMsg(tpz.msg.basic.DOUBLEUP_BUST)
    end
    return total
end
