-----------------------------------
-- Spell: Nature's Meditation
-- Enhances Attack
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 6
-- Stat Bonus: DEX+6
-- Level: 00
-- Casting Time: 1 seconds
-- Recast Time: 60 seconds
-----------------------------------
-- Combos: None
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
    local typeEffect = xi.effect.ATTACK_BOOST
    local power = 20
    local duration = 90

    if (caster:hasStatusEffect(xi.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if (target:addStatusEffect(typeEffect, power, 1, duration) == false) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
