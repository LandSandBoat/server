-----------------------------------------
-- Spell: Regeneration
-- Gradually restores HP
-- Spell cost: 36 MP
-- Monster Type: Aquans
-- Spell Type: Magical (Light)
-- Blue Magic Points: 2
-- Stat Bonus: MND+2
-- Level: 78
-- Casting Time: 2 Seconds
-- Recast Time: 60 Seconds
-- Spell Duration: 30 ticks, 90 Seconds
--
-- Combos: None
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local typeEffect = tpz.effect.REGEN
    local power = 25
    local duration = 90

    if (caster:hasStatusEffect(tpz.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(tpz.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(tpz.effect.DIFFUSION)
    end

    if (target:hasStatusEffect(tpz.effect.REGEN) and target:getStatusEffect(tpz.effect.REGEN):getTier() == 1) then
        target:delStatusEffect(tpz.effect.REGEN)
    end

    if (target:addStatusEffect(typeEffect, power, 3, duration, 0, 0, 0) == false) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end
