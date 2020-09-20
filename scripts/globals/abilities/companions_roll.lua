-----------------------------------
-- Ability: Companion's Roll
-- Grants "Regain" and "Regen" effects to pets of party members within area of effect.
-- Optimal Job: None
-- Lucky Number: 2
-- Unlucky Number: 10
-- Level: 95
-- Phantom Roll +1 Value: 5/2
--
-- Die Roll Logic in globals/effects/companions_roll.lua
--
-- Die Roll    | Regain | Regen
-- --------    -------   -------
-- 1           |+20     |+4
-- 2           |+50     |+20
-- 3           |+20     |+6
-- 4           |+20     |+8
-- 5           |+30     |+10
-- 6           |+30     |+12
-- 7           |+30     |+14
-- 8           |+40     |+16
-- 9           |+40     |+18
-- 10          |+10     |+3
-- 11          |+60     |+25
-- Bust        |-0      | 0
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local effectID = tpz.effect.COMPANIONS_ROLL
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
        corsairSetup(caster, ability, action, tpz.effect.COMPANIONS_ROLL, tpz.job.COR)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return applyRoll(caster, target, ability, action, total)
end

function applyRoll(caster, target, ability, action, total)
    local duration = 300 + caster:getMerit(tpz.merit.WINNING_STREAK) + caster:getMod(tpz.mod.PHANTOM_DURATION)
    local effectpowers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0}
    local effectpower = effectpowers[total]
-- Apply Additional Phantom Roll+ Buff
    local phantomBase = 10 -- Used to pass either 30, 50, or 70 to effects/companions_roll.lua
    local effectpower = effectpower + (phantomBase * phantombuffMultiple(caster))
-- Check if COR Main or Sub
    if (caster:getMainJob() == tpz.job.COR and caster:getMainLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getMainLvl() / target:getMainLvl())
    elseif (caster:getSubJob() == tpz.job.COR and caster:getSubLvl() < target:getMainLvl()) then
        effectpower = effectpower * (caster:getSubLvl() / target:getMainLvl())
    end
    if (target:addCorsairRoll(caster:getMainJob(), caster:getMerit(tpz.merit.BUST_DURATION), tpz.effect.COMPANIONS_ROLL, effectpower, 0, duration, caster:getID(), total, MOD_PET_REGAIN) == false) then
        ability:setMsg(tpz.msg.basic.ROLL_MAIN_FAIL)
    elseif total > 11 then
        ability:setMsg(tpz.msg.basic.DOUBLEUP_BUST)
    end
    return total
end
