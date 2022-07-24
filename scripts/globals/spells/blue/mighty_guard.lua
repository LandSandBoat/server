-----------------------------------
-- Spell: Mighty Guard
-- Gives the effect of Mighty Guard
-----------------------------------
-- Combos: None
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
    local typeEffect = xi.effect.MIGHTY_GUARD
    local power = 1
    local duration = 180

    if (caster:hasStatusEffect(xi.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if (target:hasStatusEffect(xi.effect.MIGHTY_GUARD)) then
        target:delStatusEffect(xi.effect.MIGHTY_GUARD)
    end

    if (target:addStatusEffect(typeEffect, power, 3, duration, 0, 0, 0) == false) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
