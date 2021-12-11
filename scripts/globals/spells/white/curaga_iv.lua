-----------------------------------
-- Spell: Curaga IV
-- Restores HP of all party members within area of effect.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local minCure = 450

    local divisor = 0.6666
    local constant = 330
    local power = getCurePowerOld(caster)
    if (power > 560) then
        divisor = 2.8333
        constant = 591.2
    elseif (power > 320) then
        divisor =  1
        constant = 410
    end

    local final = getCureFinal(caster, spell, getBaseCureOld(power, divisor, constant), minCure, false)

    final = final + (final * (target:getMod(xi.mod.CURE_POTENCY_RCVD)/100))

    --Applying server mods....
    final = final * xi.settings.CURE_POWER

    local diff = (target:getMaxHP() - target:getHP())
    if (final > diff) then
        final = diff
    end
    target:addHP(final)

    target:wakeUp()
    caster:updateEnmityFromCure(target, final)

    spell:setMsg(xi.msg.basic.AOE_HP_RECOVERY)

    local mpBonusPercent = (final*caster:getMod(xi.mod.CURE2MP_PERCENT))/100
    if (mpBonusPercent > 0) then
        caster:addMP(mpBonusPercent)
    end

    return final
end

return spell_object
