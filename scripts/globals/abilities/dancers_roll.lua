-----------------------------------
-- Ability: Dancer's Roll
-- Grants Regen status to party members within area of effect
-- Optimal Job: Dancer
-- Lucky Number: 3
-- Unlucky Number: 7
-- Level: 61
-- Phantom Roll +1 Value: 2
--
-- Die Roll    |No DNC              |With DNC
-- --------    ----------           ----------
-- 1           |3HP/Tick            |7HP/Tick
-- 2           |4HP/Tick            |8HP/Tick
-- 3           |12HP/Tick           |16HP/Tick
-- 4           |5HP/Tick            |9HP/Tick
-- 5           |6HP/Tick            |10HP/Tick
-- 6           |7HP/Tick            |11HP/Tick
-- 7           |1HP/Tick            |5HP/Tick
-- 8           |8HP/Tick            |12HP/Tick
-- 9           |9HP/Tick            |13HP/Tick
-- 10          |10HP/Tick           |14HP/Tick
-- 11          |16HP/Tick           |20HP/Tick
-- 12+         |-4hp(regen)/Tick    |-4hp(regen)/Tick
-- A bust will cause a regen effect on you to be reduced by 4, it will not drain HP from you if no regen effect is active.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local effectID = tpz.effect.DANCERS_ROLL
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
        corsairSetup(caster, ability, action, tpz.effect.DANCERS_ROLL, tpz.job.DNC)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return applyRoll(caster, target, ability, action, total)
end

function applyRoll(caster, target, ability, action, total)
    local duration = 300 + caster:getMerit(tpz.merit.WINNING_STREAK) + caster:getMod(tpz.mod.PHANTOM_DURATION)
    local effectpowers = {3, 4, 12, 5, 6, 7, 1, 8, 9, 10, 16, 4}
    local effectpower = effectpowers[total]
    if (caster:getLocalVar("corsairRollBonus") == 1 and total < 12) then
        effectpower = effectpower + 4
    end
-- Apply Additional Phantom Roll+ Buff
    local phantomBase = 2 -- Base increment buff
    local effectpower = effectpower + (phantomBase * phantombuffMultiple(caster))
-- Check if COR Main or Sub
    if (caster:getMainJob() == tpz.job.COR and caster:getMainLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getMainLvl() / target:getMainLvl())
    elseif (caster:getSubJob() == tpz.job.COR and caster:getSubLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getSubLvl() / target:getMainLvl())
    end
    if (target:addCorsairRoll(caster:getMainJob(), caster:getMerit(tpz.merit.BUST_DURATION), tpz.effect.DANCERS_ROLL, effectpower, 0, duration, caster:getID(), total, tpz.mod.REGEN) == false) then
        ability:setMsg(tpz.msg.basic.ROLL_MAIN_FAIL)
    elseif total > 11 then
        ability:setMsg(tpz.msg.basic.DOUBLEUP_BUST)
    end
    return total
end
