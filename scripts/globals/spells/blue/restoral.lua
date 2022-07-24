-----------------------------------
-- Spell: Restoral
-- Restores the caster's Health
-- (About a Cure VI)
-----------------------------------
-- Combos: Resist Sleep
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local minCure = 640
    local divisor = 1
    local constant = 60
    local basepower = 0
    local power = getCurePower(caster)

    if (power < 210) then
        divisor = 1.5
        constant = 600
        basepower = 90
    elseif (power < 300) then
        divisor =  0.9
        constant = 680
        basepower = 210
    elseif (power < 400) then
        divisor = 10/7
        constant = 780
        basepower = 300
    elseif (power < 500) then
        divisor = 2.5
        constant = 850
        basepower = 400
    elseif (power < 700) then
        divisor = 5/3
        constant = 890
        basepower = 500
    else
        divisor = 999999
        constant = 1010
        basepower = 0
    end

    local final = getCureFinal(caster, spell, getBaseCureOld(power, divisor, constant), minCure, true)

    final = final + (final * (target:getMod(xi.mod.CURE_POTENCY_RCVD)/100))

    if (target:getAllegiance() == caster:getAllegiance() and (target:getObjType() == xi.objType.PC or target:getObjType() == xi.objType.MOB)) then
        --Applying server mods
        final = final * xi.settings.main.CURE_POWER
    end

    local diff = (target:getMaxHP() - target:getHP())
    if (final > diff) then
        final = diff
    end

    target:addHP(final)
    target:wakeUp()
    caster:updateEnmityFromCure(target, final)
    spell:setMsg(xi.msg.basic.MAGIC_RECOVERS_HP)

    return final
end

return spell_object
