-----------------------------------
-- Spell: Barrier Tusk
-- Reduces the amount of damage you take.
-- Spell cost: 1 MP
-- Monster Type: Beasts
-- Spell Type: Magical (Earth)
-- Blue Magic Points: 3
-- Stat Bonus: VIT+3
-- Level: 8
-- Casting Time: 6 seconds
-- Recast Time: 60 seconds
-- Duration: 180 seconds
-----------------------------------
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.PHALANX
    local power = 15 -- Percentage, not amount.
    local duration = 180

    if (caster:hasStatusEffect(xi.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if (target:addStatusEffect(typeEffect, power, 3, duration) == false) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
