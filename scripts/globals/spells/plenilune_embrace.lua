-----------------------------------------
-- Spell: Plenilune Embrace
-- Restores target party member's HP and enhances attack and magic attack..
-- Shamelessly stolen from http://members.shaw.ca/pizza_steve/cure/Cure_Calculator.html
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
--------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 90
    local attBoost = 1
    local magAttBoost = 1
    local moonPhase = VanadielMoonPhase()
    if (moonPhase <= 5) then
        magAttBoost = 15
        attBoost = 1
    elseif (moonPhase <= 25) then
        magAttBoost = 12
        attBoost = 3
    elseif (moonPhase <= 40) then
        magAttBoost = 10
        attBoost = 5
    elseif (moonPhase <= 60) then
        magAttBoost = 7
        attBoost = 7
    elseif (moonPhase <= 75) then
        magAttBoost = 5
        attBoost = 10
    elseif (moonPhase <= 90) then
        magAttBoost = 3
        attBoost = 12
    elseif (moonPhase <= 100) then
        magAttBoost = 1
        attBoost = 15
    end
    caster:addStatusEffect(tpz.effect.ATTACK_BOOST, attBoost, 0, duration)
    caster:addStatusEffect(tpz.effect.MAGIC_ATK_BOOST, magAttBoost, 0, duration)

    local minCure = 350

    local divisor = 0.6666
    local constant = 230
    local power = getCurePowerOld(caster)
    if (power > 559) then
        divisor = 2.8333
        constant = 491.2
    elseif (power > 319) then
        divisor =  1
        constant = 310
    end

    local final = getCureFinal(caster, spell, getBaseCureOld(power, divisor, constant), minCure, true)

    final = final + (final * (target:getMod(tpz.mod.CURE_POTENCY_RCVD)/100))
    local diff = (target:getMaxHP() - target:getHP())
    if (final > diff) then
        final = diff
    end
    target:addHP(final)
    caster:updateEnmityFromCure(target, final)
    return final
end
