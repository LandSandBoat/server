-----------------------------------------
-- Spell: Cura III
-- Restores hp in area of effect. Self target only
-- From what I understand, Cura III's base potency is the same as Cure III's.
-- With Afflatus Misery Bonus, it can be as potent as a Curaga IV
-- Modeled after our cure_iii.lua, which was modeled after the below reference
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

    local minCure = 130
    if (USE_OLD_CURE_FORMULA == true) then
        power = getCurePowerOld(caster)
        divisor = 1
        constant = 70
        if (power > 300) then
            divisor = 15.6666
            constant = 180.43
        elseif (power > 180) then
            divisor = 2
            constant = 115
        end
    else
        power = getCurePower(caster)
        if (power < 125) then
            divisor = 2.2
            constant = 130
            basepower = 70
        elseif (power < 200) then
            divisor =  75/65
            constant = 155
            basepower = 125
        elseif (power < 300) then
            divisor = 2.5
            constant = 220
            basepower = 200
        elseif (power < 700) then
            divisor = 5
            constant = 260
            basepower = 300
        else
            divisor = 999999
            constant = 340
            basepower = 0
        end
    end

    if (USE_OLD_CURE_FORMULA == true) then
        basecure = getBaseCureOld(power, divisor, constant)
    else
        basecure = getBaseCure(power, divisor, constant, basepower)
    end

    --Apply Afflatus Misery Bonus to the Result
    if (caster:hasStatusEffect(tpz.effect.AFFLATUS_MISERY)) then
        if (caster:getID() == target:getID()) then -- Let's use a local var to hold the power of Misery so the boost is applied to all targets,
            caster:setLocalVar("Misery_Power", caster:getMod(tpz.mod.AFFLATUS_MISERY))
        end
        local misery = caster:getLocalVar("Misery_Power")

        --THIS IS LARELY SEMI-EDUCATED GUESSWORK. THERE IS NOT A
        --LOT OF CONCRETE INFO OUT THERE ON CURA THAT I COULD FIND

        --Not very much documentation for Cura II known at all.
        --As with Cura, the Afflatus Misery bonus can boost this spell up
        --to roughly the level of a Curaga 4. For Cura II vs Curaga III,
        --this is document at ~375HP, 15HP less than the cap of 390HP. So
        --for Cura II, i'll go with 15 less than the cap of Curaga IV (690): 675
        --So with lack of available formula documentation, I'll go with that.

        --printf("BEFORE AFFLATUS MISERY BONUS: %d", basecure)

        basecure = basecure + misery

        if (basecure > 675) then
            basecure = 675
        end

        --printf("AFTER AFFLATUS MISERY BONUS: %d", basecure)

        --Afflatus Misery Mod Gets Used Up
        caster:setMod(tpz.mod.AFFLATUS_MISERY, 0)
    end

    final = getCureFinal(caster, spell, basecure, minCure, false)
    final = final + (final * (target:getMod(tpz.mod.CURE_POTENCY_RCVD)/100))

    --Applying server mods....
    final = final * CURE_POWER

    local diff = (target:getMaxHP() - target:getHP())
    if (final > diff) then
        final = diff
    end
    target:addHP(final)

    target:wakeUp()

    --Enmity for Cura III is fixed, so its CE/VE is set in the SQL and not calculated with updateEnmityFromCure

    spell:setMsg(tpz.msg.basic.AOE_HP_RECOVERY)

    local mpBonusPercent = (final*caster:getMod(tpz.mod.CURE2MP_PERCENT))/100
    if (mpBonusPercent > 0) then
        caster:addMP(mpBonusPercent)
    end

    return final
end
