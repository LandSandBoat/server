-----------------------------------
-- Spell: Cure
-- Restores target's HP.
-- Shamelessly stolen from http://members.shaw.ca/pizza_steve/cure/Cure_Calculator.html
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local divisor = 0
    local constant = 0
    local basepower = 0
    local power = 0
    local basecure = 0
    local final = 0

    local minCure = 10
    if xi.settings.main.USE_OLD_CURE_FORMULA then
        power = getCurePowerOld(caster)
        divisor = 1
        constant = -10
        if power > 100 then
            divisor = 57
            constant = 29.125
        elseif power > 60 then
            divisor = 2
            constant = 5
        end
    else
        power = getCurePower(caster)
        if power < 20 then
            divisor = 4
            constant = 10
            basepower = 0
        elseif power < 40 then
            divisor =  1.3333
            constant = 15
            basepower = 20
        elseif power < 125 then
            divisor = 8.5
            constant = 30
            basepower = 40
        elseif power < 200 then
            divisor = 15
            constant = 40
            basepower = 125
        elseif power < 600 then
            divisor = 20
            constant = 40
            basepower = 200
        else
            divisor = 999999
            constant = 65
            basepower = 0
        end
    end

    if isValidHealTarget(caster, target) then
        if xi.settings.main.USE_OLD_CURE_FORMULA then
            basecure = getBaseCureOld(power, divisor, constant)
        else
            basecure = getBaseCure(power, divisor, constant, basepower)
        end

        final = getCureFinal(caster, spell, basecure, minCure, false)
        if
            caster:hasStatusEffect(xi.effect.AFFLATUS_SOLACE) and
            not target:hasStatusEffect(xi.effect.STONESKIN)
        then
            local solaceStoneskin = 0
            local equippedBody = caster:getEquipID(xi.slot.BODY)
            if equippedBody == 11186 then
                solaceStoneskin = math.floor(final * 0.30)
            elseif equippedBody == 11086 then
                solaceStoneskin = math.floor(final * 0.35)
            else
                solaceStoneskin = math.floor(final * 0.25)
            end

            solaceStoneskin = solaceStoneskin * (1 + caster:getMerit(xi.merit.ANIMUS_SOLACE) / 100)

            target:addStatusEffect(xi.effect.STONESKIN, solaceStoneskin, 0, 25, 0, 0, 1)
        end

        final = final + (final * (target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100))

        --Applying server mods
        final = final * xi.settings.main.CURE_POWER

        local diff = (target:getMaxHP() - target:getHP())
        if final > diff then
            final = diff
        end

        target:addHP(final)

        target:wakeUp()
        caster:updateEnmityFromCure(target, final)
    else
        -- no effect if player casted on mob

        if target:isUndead() then
            spell:setMsg(xi.msg.basic.MAGIC_DMG)

            final = xi.spells.damage.useDamageSpell(caster, target, spell)
        elseif caster:getObjType() == xi.objType.PC then
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        else
            -- e.g. monsters healing themselves.
            if xi.settings.main.USE_OLD_CURE_FORMULA then
                basecure = getBaseCureOld(power, divisor, constant)
            else
                basecure = getBaseCure(power, divisor, constant, basepower)
            end

            final = getCureFinal(caster, spell, basecure, minCure, false)
            local diff = (target:getMaxHP() - target:getHP())
            if final > diff then
                final = diff
            end

            target:addHP(final)
        end
    end

    local mpBonusPercent = (final * caster:getMod(xi.mod.CURE2MP_PERCENT)) / 100
    if mpBonusPercent > 0 then
        caster:addMP(mpBonusPercent)
    end

    return final
end

return spellObject
