-----------------------------------
-- Spell: Erratic Flutter
-- Increases attack speed
-- Spell cost: 92 MP
-- Monster Type: Vermin
-- Spell Type: Magical (Wind)
-- Casting Time: 1 Seconds
-- Recast Time: 45 Seconds
-----------------------------------
-- Combos: Dual Wield
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.HASTE
    local power = 3000 -- 30%
    local duration = 300

    if caster:hasStatusEffect(xi.effect.DIFFUSION) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if diffMerit > 0 then
            duration = duration + (duration / 100) * diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if not target:addStatusEffect(typeEffect, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
