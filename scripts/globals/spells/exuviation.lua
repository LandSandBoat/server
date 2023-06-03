-----------------------------------
-- Spell: Exuviation
-- Restores HP and removes one detrimental magic xi.effect.
-- Can be used with Diffusion.
-- Shamelessly stolen from http://members.shaw.ca/pizza_steve/cure/Cure_Calculator.html
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local minCure = 60

    local divisor = 1
    local constant = 40
    local power = getCurePowerOld(caster)
    if power > 99 then
        divisor = 57
        constant = 79.125
    elseif power > 59 then
        divisor =  2
        constant = 55
    end

    local final = getCureFinal(caster, spell, getBaseCureOld(power, divisor, constant), minCure, true)

    final = final + (final * (target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100))
    local diff = (target:getMaxHP() - target:getHP())
    if final > diff then
        final = diff
    end

    caster:eraseStatusEffect()
    target:addHP(final)
    caster:updateEnmityFromCure(target, final)
    return final
end

return spellObject
