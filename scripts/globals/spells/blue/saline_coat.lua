-----------------------------------
-- Spell: Saline Coat
-- Enhances magic defense
-- Spell cost: 66 MP
-- Monster Type: Luminians
-- Spell Type: Magical (Light)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+2, AGI+2, MP+10
-- Level: 72
-- Casting Time: 3 seconds
-- Recast Time: 60 seconds
-- Duration: 60 seconds
-----------------------------------
-- Combos: Defense Bonus
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.MAGIC_DEF_BOOST
    local power = 40
    local duration = 60

    if (caster:hasStatusEffect(xi.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if (target:addStatusEffect(typeEffect, power, 0, duration) == false) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
