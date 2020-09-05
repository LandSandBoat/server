-----------------------------------------
-- Spell: Cura
-- Restores hp in area of effect. Self target only
-- From what I understand, Cura's base potency is the same as Cure's.
-- With Afflatus Misery Bonus, it can be as potent as a Curaga II
-- Modeled after our Cure.lua, which was modeled after the below reference
-- Shamelessly stolen from http://members.shaw.ca/pizza_steve/cure/Cure_Calculator.html
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    if (caster:getID() ~= target:getID()) then
        return tpz.msg.basic.CANNOT_PERFORM_TARG
    else
        return 0
    end
end

function onSpellCast(caster, target, spell)
    local divisor = 0
    local constant = 0
    local basepower = 0
    local power = 0
    local basecure = 0
    local final = 0

    local minCure = 10
    if (USE_OLD_CURE_FORMULA == true) then
        power = getCurePowerOld(caster)
        divisor = 1
        constant = -10
        if (power > 100) then
                divisor = 57
                constant = 29.125
        elseif (power > 60) then
                divisor = 2
                constant = 5
        end
    else
        power = getCurePower(caster)
        if (power < 20) then
            divisor = 4
            constant = 10
            basepower = 0
        elseif (power < 40) then
            divisor =  1.3333
            constant = 15
            basepower = 20
        elseif (power < 125) then
            divisor = 8.5
            constant = 30
            basepower = 40
        elseif (power < 200) then
            divisor = 15
            constant = 40
            basepower = 125
        elseif (power < 600) then
            divisor = 20
            constant = 40
            basepower = 200
        else
            divisor = 999999
            constant = 65
            basepower = 0
        end
    end

    if (USE_OLD_CURE_FORMULA == true) then
        basecure = getBaseCureOld(power, divisor, constant)
    else
        basecure = getBaseCure(power, divisor, constant, basepower)
    end

    --Apply Afflatus Misery Bonus to Final Result
    if (caster:hasStatusEffect(tpz.effect.AFFLATUS_MISERY)) then
        if (caster:getID() == target:getID()) then -- Let's use a local var to hold the power of Misery so the boost is applied to all targets,
            caster:setLocalVar("Misery_Power", caster:getMod(tpz.mod.AFFLATUS_MISERY))
        end
        local misery = caster:getLocalVar("Misery_Power")
        -- print(caster:getLocalVar("Misery_Power"))

        --THIS IS LARELY SEMI-EDUCATED GUESSWORK. THERE IS NOT A
        --LOT OF CONCRETE INFO OUT THERE ON CURA THAT I COULD FIND

        --If the target max affluent misery bonus
        --according to tests I found seems to cap out at most
        --people about 125 misery. With that in mind, if you
        --were hitting the Cure I cap of 65hp, then each misery
        --point would boost your Cura by about 1hp, capping at ~175hp
        --So with lack of available formula documentation, I'll go with that.

        --printf("BEFORE AFFLATUS MISERY BONUS: %d", basecure)

        basecure = basecure + misery

        if (basecure > 175) then
            basecure = 175
        end

        --printf("AFTER AFFLATUS MISERY BONUS: %d", basecure)

        --Afflatus Misery Mod Gets Used Up
        caster:setMod(tpz.mod.AFFLATUS_MISERY, 0)
    end

    final = getCureFinal(caster, spell, basecure, minCure, false)
    final = final + (final * (target:getMod(tpz.mod.CURE_POTENCY_RCVD)/100))

    --Applying server mods....
    final = final * CURE_POWER

    target:addHP(final)

    target:wakeUp()

    --Enmity for Cura is fixed, so its CE/VE is set in the SQL and not calculated with updateEnmityFromCure

    spell:setMsg(tpz.msg.basic.AOE_HP_RECOVERY)

    local mpBonusPercent = (final*caster:getMod(tpz.mod.CURE2MP_PERCENT))/100
    if (mpBonusPercent > 0) then
        caster:addMP(mpBonusPercent)
    end

    return final
end
