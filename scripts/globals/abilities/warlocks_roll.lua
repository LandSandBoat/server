-----------------------------------
-- Ability: Warlock's Roll
-- Enhances magic accuracy for party members within area of effect
-- Optimal Job: Red Mage
-- Lucky Number: 4
-- Unlucky Number: 8
-- Level: 46
-- Phantom Roll +1 Value: 1
--
-- Die Roll    |No RDM  |With RDM
-- --------    -------- -----------
-- 1           |+2      |+7
-- 2           |+3      |+8
-- 3           |+4      |+9
-- 4           |+12     |+17
-- 5           |+5      |+10
-- 6           |+6      |+11
-- 7           |+7      |+12
-- 8           |+1      |+6
-- 9           |+8      |+13
-- 10          |+9      |+14
-- 11          |+15     |+20
-- Bust        |-5      |-5
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/ability")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    local effectID = tpz.effect.WARLOCKS_ROLL
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
        corsairSetup(caster, ability, action, tpz.effect.WARLOCKS_ROLL, tpz.job.RDM)
    end
    local total = caster:getLocalVar("corsairRollTotal")
    return applyRoll(caster, target, ability, action, total)
end

function applyRoll(caster, target, ability, action, total)
    local duration = 300 + caster:getMerit(tpz.merit.WINNING_STREAK) + caster:getMod(tpz.mod.PHANTOM_DURATION)
    local effectpowers = {2, 3, 4, 12, 5, 6, 7, 1, 8, 9, 15, 5}
    local effectpower = effectpowers[total]
    if (caster:getLocalVar("corsairRollBonus") == 1 and total < 12) then
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
    if (target:addCorsairRoll(caster:getMainJob(), caster:getMerit(tpz.merit.BUST_DURATION), tpz.effect.WARLOCKS_ROLL, effectpower, 0, duration, caster:getID(), total, tpz.mod.MACC) == false) then
        ability:setMsg(tpz.msg.basic.ROLL_MAIN_FAIL)
    elseif total > 11 then
        ability:setMsg(tpz.msg.basic.DOUBLEUP_BUST)
    end
    return total
end
